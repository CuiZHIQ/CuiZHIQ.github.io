# News Scrolling and Author Annotations Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add accessible vertical auto-scrolling to News and standardize equal-contribution and Project Leader annotations without changing the homepage's existing visual design.

**Architecture:** Keep the page content semantic and usable without JavaScript. `_pages/about.md` supplies a native scroll viewport and corrected publication text, `assets/css/main.scss` supplies only bounded News-specific layout rules, and a standalone vanilla-JavaScript file progressively adds timed one-item scrolling with pause and reduced-motion behavior. The existing PowerShell validator protects content, styling, and script wiring.

**Tech Stack:** Jekyll, Kramdown/GFM, SCSS, vanilla JavaScript compatible with Node 14 syntax checks, PowerShell validation, GitHub Pages.

## Global Constraints

- Keep the current News wording, order, emoji, typography, colors, and page position.
- Do not change the global palette, background, fonts, content width, sidebar, headings, publication accordion layout, cards, badges, or existing responsive breakpoints.
- Use `†` for every currently identified equal-contribution author and show `† Equal contribution` on each affected paper.
- Add `Project Leader` only to Zhiqing Cui on SCOPE-Router and PaperX.
- Use a `14rem` News maximum height on desktop and `11rem` at widths up to `480px`.
- Wait four seconds before auto-scrolling, advance one news item every four seconds, and pause manual interactions for eight seconds.
- Disable automatic movement when `prefers-reduced-motion: reduce` matches; native scrolling must always remain available.
- Add no dependency, framework, News copy change, site-wide redesign, or unrelated refactor.
- Direct publication to `origin/main` is authorized only after all checks and final review pass.

## File Structure

- Modify `_pages/about.md`: wrap the existing News list and correct four equal-contribution author blocks.
- Modify `assets/css/main.scss`: add News viewport, focus, reduced-motion, and existing-mobile-breakpoint rules only.
- Create `assets/js/news-scroll.js`: own the News timer, item selection, pause/resume, and reduced-motion behavior.
- Modify `_includes/scripts.html`: load the dedicated News script after the existing site bundle.
- Modify `scripts/validate_publications.ps1`: enforce annotation, News markup, styling, script, and include invariants.

---

### Task 1: Standardize Equal-Contribution and Project Leader Annotations

**Files:**
- Modify: `scripts/validate_publications.ps1:190-196`
- Modify: `_pages/about.md:67-85, 117-143`

**Interfaces:**
- Consumes: The existing `$about` content string and `Assert-True` helper in `scripts/validate_publications.ps1`.
- Produces: Four dagger-form equal-contribution author lines, four `† Equal contribution` notes, and exactly two `Project Leader` labels for Task 3 validation.

- [ ] **Step 1: Add failing annotation assertions**

Append these assertions inside the existing `if ($Check -in @("Content", "All"))` block, immediately before `Assert-LocalImageReferences`:

```powershell
$equalContributionPrefixes = @(
    'Jiaming Ma†, **Zhiqing Cui†**, Binwu Wang',
    '**Zhiqing Cui†**, Binwu Wang†, Guanjun Wang',
    'Tao Yu†, Yifei Qu†, **Zhiqing Cui†** (Project Leader), Pengfei Zhou',
    'Tao Yu†, Minghui Zhang†, **Zhiqing Cui†** (Project Leader), Hao Wang'
)
foreach ($prefix in $equalContributionPrefixes) {
    Assert-True ($about.Contains($prefix)) "Missing standardized equal-contribution author line: $prefix"
}
Assert-True (([regex]::Matches($about, [regex]::Escape('† Equal contribution'))).Count -eq 4) "Expected four equal-contribution notes."
Assert-True (([regex]::Matches($about, [regex]::Escape('(Project Leader)'))).Count -eq 2) "Expected exactly two Project Leader labels."
Assert-True (-not $about.Contains('<sup>*</sup> Equal contribution')) "Found the former asterisk equal-contribution note."
Assert-True (-not $about.Contains('<sup>*</sup>')) "Found the former superscript asterisk author notation."
```

- [ ] **Step 2: Run the content validator and confirm it fails**

Run:

```powershell
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check Content
```

Expected: exit code `1` with failures for missing standardized lines, four notes, two Project Leader labels, and the former SCOPE-Router asterisk notation.

- [ ] **Step 3: Update the four author blocks with exact annotation text**

In `_pages/about.md`, make the affected author and venue/note blocks read exactly as follows while leaving titles, links, images, venues, and all other authors unchanged:

```markdown
Jiaming Ma†, **Zhiqing Cui†**, Binwu Wang, Pengkun Wang, Zhengyang Zhou, Zhe Zhao, Yang Wang

**IJCAI 2025 (Oral)**

† Equal contribution
```

```markdown
**Zhiqing Cui†**, Binwu Wang†, Guanjun Wang, Zhengyang Zhou, Fan Meng, Jingjia Luo, Yang Wang

**IEEE Transactions on Knowledge and Data Engineering (TKDE)**

† Equal contribution
```

```markdown
Tao Yu†, Yifei Qu†, **Zhiqing Cui†** (Project Leader), Pengfei Zhou, Zhongtian Luo, Yujia Yang, Shenghua Chai, Haopeng Jin, Zhenghao Zhang, Xinming Wang, Hongzhu Yi, Wangbo Zhao, Zhenglin Wan, Yan Huang, Yeshani, Jinwen Luo, Yang You

**arXiv preprint**

† Equal contribution
```

```markdown
Tao Yu†, Minghui Zhang†, **Zhiqing Cui†** (Project Leader), Hao Wang, Zhongtian Luo, Shenghua Chai, Junhao Gong, Yuzhao Peng, Yuxuan Zhou, Yujia Yang, Zhenghao Zhang, Haopeng Jin, Xinming Wang, Yufei Xiong, Jiabing Yang, Jiahao Yuan, Hanqing Wang, Hongzhu Yi, YiFan Zhang, Yan Huang, Liang Wang

**arXiv preprint**

† Equal contribution
```

- [ ] **Step 4: Run focused and full validators**

Run:

```powershell
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check Content
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check All
```

Expected: both commands output `Publication validation passed (...)` and exit `0`.

- [ ] **Step 5: Check and commit the annotation change**

Run:

```powershell
git diff --check
git add -- _pages/about.md scripts/validate_publications.ps1
git diff --cached --check
git commit -m "fix: standardize publication author annotations"
```

Expected: one commit containing only the two listed files.

---

### Task 2: Add Accessible News Auto-Scrolling

**Files:**
- Modify: `scripts/validate_publications.ps1:1-12, 193-209`
- Modify: `_pages/about.md:30-44`
- Modify: `assets/css/main.scss:161-179`
- Create: `assets/js/news-scroll.js`
- Modify: `_includes/scripts.html:1-3`

**Interfaces:**
- Consumes: `[data-news-scroll]` containing a Kramdown-rendered `<ul>` and `<li>` elements.
- Produces: `initNewsScroller(viewport: HTMLElement): void` inside an isolated IIFE; it has no global API and progressively enhances every `[data-news-scroll]` viewport.
- Produces: `.news-scroll` with native vertical overflow and inherited typography/colors.
- Produces: a `<script src="assets/js/news-scroll.js" defer></script>` include for Task 3 deployment checks.

- [ ] **Step 1: Extend the validator with failing News checks**

At the top of `scripts/validate_publications.ps1`, expand the validation modes and read the new integration files safely:

```powershell
param(
    [ValidateSet("Content", "Styles", "Behavior", "All")]
    [string]$Check = "All"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$aboutPath = Join-Path $repoRoot "_pages/about.md"
$scssPath = Join-Path $repoRoot "assets/css/main.scss"
$scriptsIncludePath = Join-Path $repoRoot "_includes/scripts.html"
$newsScriptPath = Join-Path $repoRoot "assets/js/news-scroll.js"
$about = Get-Content -Raw -LiteralPath $aboutPath
$scss = Get-Content -Raw -LiteralPath $scssPath
$scriptsInclude = Get-Content -Raw -LiteralPath $scriptsIncludePath
$newsScript = if (Test-Path -LiteralPath $newsScriptPath) {
    Get-Content -Raw -LiteralPath $newsScriptPath
} else {
    ""
}
$failures = [System.Collections.Generic.List[string]]::new()
```

Inside the Content block, before local-image validation, add:

```powershell
Assert-True (([regex]::Matches($about, 'class="news-scroll"')).Count -eq 1) "Expected exactly one News scroll viewport."
Assert-True ($about.Contains('data-news-scroll')) "News viewport is missing its behavior hook."
Assert-True ($about.Contains('tabindex="0"')) "News viewport is not keyboard focusable."
Assert-True ($about.Contains('aria-label="Latest news"')) "News viewport is missing its accessible label."
```

Inside the Styles block, add:

```powershell
foreach ($newsStyle in @('.news-scroll', 'max-height: 14rem', 'overflow-y: auto', 'overscroll-behavior: contain', 'scroll-behavior: smooth', 'prefers-reduced-motion: reduce', 'max-height: 11rem')) {
    Assert-True ($scss.Contains($newsStyle)) "Missing News style rule: $newsStyle"
}
```

Add a new Behavior block before the final failure report:

```powershell
if ($Check -in @("Behavior", "All")) {
    Assert-True (Test-Path -LiteralPath $newsScriptPath -PathType Leaf) "Missing News behavior script."
    Assert-True ($scriptsInclude.Contains('<script src="assets/js/news-scroll.js" defer></script>')) "News behavior script is not loaded by the site."
    foreach ($token in @('data-news-scroll', '4000', '8000', 'prefers-reduced-motion: reduce', 'mouseenter', 'focusin', 'wheel', 'pointerdown', 'scrollTo')) {
        Assert-True ($newsScript.Contains($token)) "Missing News behavior token: $token"
    }
}
```

- [ ] **Step 2: Run the full validator and confirm the new checks fail**

Run:

```powershell
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check All
```

Expected: exit code `1` with missing News viewport, style, behavior script, script include, and behavior-token failures. Existing publication checks must not fail.

- [ ] **Step 3: Wrap the existing News list without changing its content**

In `_pages/about.md`, insert this opening line immediately below `# 🔥 News`:

```html
<div class="news-scroll" data-news-scroll tabindex="0" aria-label="Latest news" markdown="1">
```

Insert this closing line after the final `*2024.06*` News list item and before `# 📝 Publications`:

```html
</div>
```

Do not edit, remove, or reorder any News list item.

- [ ] **Step 4: Add News-only SCSS without changing existing visual rules**

Insert this block before the existing `@media (max-width: 480px)` block in `assets/css/main.scss`:

```scss
.news-scroll {
    max-height: 14rem;
    padding-right: .35rem;
    overflow-y: auto;
    overscroll-behavior: contain;
    scroll-behavior: smooth;
    scrollbar-gutter: stable;

    &:focus-visible {
        outline: 2px solid currentColor;
        outline-offset: 4px;
    }
}

@media (prefers-reduced-motion: reduce) {
    .news-scroll { scroll-behavior: auto; }
}
```

Add this line inside the existing `@media (max-width: 480px)` block:

```scss
    .news-scroll { max-height: 11rem; }
```

- [ ] **Step 5: Create the standalone progressive-enhancement script**

Create `assets/js/news-scroll.js` with this complete implementation:

```javascript
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
      viewport.scrollTo({ top: nextTop, behavior: "smooth" });
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
```

- [ ] **Step 6: Load the script from the existing site include**

Update `_includes/scripts.html` so its first lines are:

```html
<script src="assets/js/main.min.js"></script>
<script src="assets/js/news-scroll.js" defer></script>
```

Leave the analytics and Google Scholar includes unchanged.

- [ ] **Step 7: Run syntax and integration checks**

Run:

```powershell
node --check assets/js/news-scroll.js
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check Content
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check Styles
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check Behavior
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check All
git diff --check
```

Expected: JavaScript syntax check exits `0`; all four validator runs report `Publication validation passed (...)`; diff check is silent and exits `0`.

- [ ] **Step 8: Commit the News enhancement**

Run:

```powershell
git add -- _pages/about.md assets/css/main.scss assets/js/news-scroll.js _includes/scripts.html scripts/validate_publications.ps1
git diff --cached --check
git commit -m "feat: add accessible news auto-scroll"
```

Expected: one commit containing only the five listed paths.

---

### Task 3: Review, Publish, and Verify the Live Page

**Files:**
- Verify: `_pages/about.md`
- Verify: `assets/css/main.scss`
- Verify: `assets/js/news-scroll.js`
- Verify: `_includes/scripts.html`
- Verify: `scripts/validate_publications.ps1`

**Interfaces:**
- Consumes: Task 1's annotation invariants and Task 2's News markup/style/script contract.
- Produces: A reviewed `origin/main` deployment and evidence that the live HTML, CSS, and JavaScript expose the approved behavior and content.

- [ ] **Step 1: Run a clean whole-branch validation**

Run:

```powershell
node --check assets/js/news-scroll.js
pwsh -NoProfile -File scripts\validate_publications.ps1 -Check All
git diff --check
git status --short
git log -5 --oneline
```

Expected: syntax and validation pass, diff check is silent, the worktree is clean, and the two feature commits follow design commit `90300e3`.

- [ ] **Step 2: Review the complete change against the approved spec**

Review:

```powershell
git diff 90300e3..HEAD -- _pages/about.md assets/css/main.scss assets/js/news-scroll.js _includes/scripts.html scripts/validate_publications.ps1
```

Confirm all of the following before publishing:

- No News text, order, emoji, global color, font, sidebar, publication layout, card, or badge change appears.
- Exactly four equal-contribution notes and two Zhiqing Cui Project Leader labels appear.
- News remains a semantic list in a native scroll viewport.
- JavaScript stops for reduced motion and interaction, and no dependency is added.

- [ ] **Step 3: Push the reviewed branch directly to GitHub**

Run:

```powershell
git push origin main
```

Expected: `origin/main` advances to the local `HEAD` with no rejected update.

- [ ] **Step 4: Wait for the GitHub Pages workflow to succeed**

Use the public GitHub API to wait for the `pages build and deployment` run whose `head_sha` matches the pushed commit, then poll it until `status` is `completed`:

```powershell
$head = (& git rev-parse HEAD).Trim()
do {
    $runs = Invoke-RestMethod -Uri 'https://api.github.com/repos/CuiZHIQ/CuiZHIQ.github.io/actions/runs?branch=main&per_page=20'
    $run = $runs.workflow_runs | Where-Object {
        $_.name -eq 'pages build and deployment' -and $_.head_sha -eq $head
    } | Select-Object -First 1
    if (-not $run -or $run.status -ne 'completed') { Start-Sleep -Seconds 15 }
} while (-not $run -or $run.status -ne 'completed')
$run | Select-Object id, status, conclusion, html_url, head_sha
if ($run.conclusion -ne 'success') { throw "Pages deployment failed: $($run.html_url)" }
```

Expected: `conclusion` is `success` and `head_sha` equals `git rev-parse HEAD`; polling waits 15 seconds between checks.

- [ ] **Step 5: Verify the deployed HTML, CSS, JavaScript, and repository state**

Fetch cache-busted live resources and assert the approved markers:

```powershell
$stamp = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
$html = (Invoke-WebRequest -Uri "https://cuizhiq.github.io/?v=$stamp" -Headers @{ 'Cache-Control' = 'no-cache' }).Content
$css = (Invoke-WebRequest -Uri "https://cuizhiq.github.io/assets/css/main.css?v=$stamp" -Headers @{ 'Cache-Control' = 'no-cache' }).Content
$js = (Invoke-WebRequest -Uri "https://cuizhiq.github.io/assets/js/news-scroll.js?v=$stamp" -Headers @{ 'Cache-Control' = 'no-cache' }).Content
if (-not $html.Contains('class="news-scroll"')) { throw 'Live News viewport is missing.' }
if (-not $html.Contains('Zhiqing Cui†</strong> (Project Leader)')) { throw 'Live Project Leader label is missing.' }
if (([regex]::Matches($html, [regex]::Escape('(Project Leader)'))).Count -ne 2) { throw 'Live Project Leader count is incorrect.' }
if (([regex]::Matches($html, [regex]::Escape('† Equal contribution'))).Count -ne 4) { throw 'Live equal-contribution note count is incorrect.' }
if (-not $css.Contains('.news-scroll')) { throw 'Live News CSS is missing.' }
if (-not $js.Contains('prefers-reduced-motion: reduce')) { throw 'Live News behavior is missing reduced-motion handling.' }
if ((& git rev-parse HEAD).Trim() -ne ((& git ls-remote origin refs/heads/main) -split '\s+')[0]) { throw 'Local and remote main do not match.' }
```

Expected: all assertions pass, the homepage and resources return HTTP `200`, and local `HEAD` equals `origin/main`.

---

## Plan Self-Review Checklist

- Every approved News behavior maps to Task 2 and Task 3 validation.
- Every annotation requirement maps to Task 1 and Task 3 live checks.
- Every file path, selector, attribute, timing constant, label, command, and commit scope is explicit.
- No global visual redesign, dependency, News-content edit, unrelated refactor, placeholder, or deferred implementation remains.
