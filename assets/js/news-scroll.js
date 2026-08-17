(function () {
  "use strict";

  var AUTO_INTERVAL_MS = 4000;
  var MANUAL_PAUSE_MS = 8000;
  var REDUCED_MOTION_QUERY = "(prefers-reduced-motion: reduce)";

  function initNewsScroller(viewport) {
    var items = Array.prototype.slice.call(viewport.querySelectorAll("li"));
    var motionQuery = window.matchMedia(REDUCED_MOTION_QUERY);
    var timerId = null;
    var manualPauseUntil = 0;
    var pointerInside = false;
    var focusInside = false;

    if (items.length < 2) { return; }

    function stopTimer() {
      if (timerId !== null) {
        window.clearTimeout(timerId);
        timerId = null;
      }
    }

    function canRun() {
      return !motionQuery.matches &&
        !document.hidden &&
        !pointerInside &&
        !focusInside &&
        viewport.scrollHeight > viewport.clientHeight;
    }

    function nearestItemIndex() {
      var targetTop = viewport.scrollTop + items[0].offsetTop;
      var nearestIndex = 0;
      var nearestDistance = Number.POSITIVE_INFINITY;

      items.forEach(function (item, index) {
        var distance = Math.abs(item.offsetTop - targetTop);
        if (distance < nearestDistance) {
          nearestDistance = distance;
          nearestIndex = index;
        }
      });
      return nearestIndex;
    }

    function advance() {
      var nextIndex = (nearestItemIndex() + 1) % items.length;
      var nextTop = nextIndex === 0 ? 0 : items[nextIndex].offsetTop - items[0].offsetTop;

      if (typeof viewport.scrollTo === "function") {
        viewport.scrollTo({ top: nextTop, behavior: "smooth" });
      } else {
        viewport.scrollTop = nextTop;
      }
    }

    function schedule() {
      stopTimer();
      if (!canRun()) { return; }

      var manualDelay = Math.max(0, manualPauseUntil - Date.now());
      var delay = Math.max(AUTO_INTERVAL_MS, manualDelay);
      timerId = window.setTimeout(function tick() {
        if (!canRun() || Date.now() < manualPauseUntil) {
          schedule();
          return;
        }
        advance();
        timerId = window.setTimeout(tick, AUTO_INTERVAL_MS);
      }, delay);
    }

    function pauseForManualInput() {
      manualPauseUntil = Date.now() + MANUAL_PAUSE_MS;
      schedule();
    }

    viewport.addEventListener("mouseenter", function () {
      pointerInside = true;
      stopTimer();
    });
    viewport.addEventListener("mouseleave", function () {
      pointerInside = false;
      schedule();
    });
    viewport.addEventListener("focusin", function () {
      focusInside = true;
      stopTimer();
    });
    viewport.addEventListener("focusout", function (event) {
      focusInside = viewport.contains(event.relatedTarget);
      schedule();
    });
    viewport.addEventListener("wheel", pauseForManualInput, { passive: true });
    viewport.addEventListener("pointerdown", pauseForManualInput, { passive: true });

    document.addEventListener("visibilitychange", schedule);
    if (motionQuery.addEventListener) {
      motionQuery.addEventListener("change", schedule);
    } else {
      motionQuery.addListener(schedule);
    }
    window.addEventListener("resize", schedule);
    schedule();
  }

  function init() {
    Array.prototype.forEach.call(
      document.querySelectorAll("[data-news-scroll]"),
      initNewsScroller
    );
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
}());
