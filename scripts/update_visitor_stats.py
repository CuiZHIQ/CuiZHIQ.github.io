"""Refresh the cumulative MapMyVisitors pageview count used by the homepage."""

from __future__ import annotations

import html
import re
import urllib.request
from datetime import datetime, timezone
from pathlib import Path


STATS_URL = "https://mapmyvisitors.com/web/1c1pb"
DATA_PATH = Path(__file__).resolve().parents[1] / "_data" / "visitor_stats.yml"


def fetch_stats() -> tuple[int, str]:
    request = urllib.request.Request(
        STATS_URL,
        headers={"User-Agent": "CuiZHIQ.github.io visitor-stat updater"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        document = response.read().decode("utf-8")

    total_match = re.search(
        r'class="pvTV total-pageviews odometer"\s+data-value="(\d+)"', document
    )
    since_match = re.search(
        r'Total Pageviews.*?<span[^>]*class="text-nowrap pvTT">Since\s+([^<]+)</span>',
        document,
        re.DOTALL,
    )
    if not total_match or not since_match:
        raise RuntimeError("MapMyVisitors total pageview data was not found")

    since = html.unescape(since_match.group(1)).strip()
    since = re.sub(r"(\d+)(?:st|nd|rd|th)", r"\1", since)
    since = re.sub(r"^([A-Za-z]+\s+\d+)\s+(\d{4})$", r"\1, \2", since)
    return int(total_match.group(1)), since


def main() -> None:
    total, since = fetch_stats()
    updated_at = datetime.now(timezone.utc).date().isoformat()
    content = (
        f'total_pageviews: "{total:,}"\n'
        f'since: "{since}"\n'
        f'updated_at: "{updated_at}"\n'
    )
    DATA_PATH.parent.mkdir(parents=True, exist_ok=True)
    DATA_PATH.write_text(content, encoding="utf-8")
    print(f"Updated total pageviews: {total:,} (since {since})")


if __name__ == "__main__":
    main()
