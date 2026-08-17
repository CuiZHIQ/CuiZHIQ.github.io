param(
    [ValidateSet("Content", "Styles", "All")]
    [string]$Check = "All"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$aboutPath = Join-Path $repoRoot "_pages/about.md"
$scssPath = Join-Path $repoRoot "assets/css/main.scss"
$about = Get-Content -Raw -LiteralPath $aboutPath
$scss = Get-Content -Raw -LiteralPath $scssPath
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { $script:failures.Add($Message) }
}

if ($Check -in @("Content", "All")) {
    Assert-True (([regex]::Matches($about, '<details class="publication-section"')).Count -eq 4) "Expected four publication sections."
    Assert-True (([regex]::Matches($about, '<details class="publication-section" open markdown="1">')).Count -eq 1) "Expected exactly one default-open section."
    Assert-True (([regex]::Matches($about, 'class="publication-summary"')).Count -eq 4) "Expected four publication summaries."
    Assert-True (([regex]::Matches($about, "class='paper-box'")).Count -eq 17) "Expected 17 paper cards."
    Assert-True (([regex]::Matches($about, 'badge badge--accepted')).Count -eq 10) "Expected 10 accepted badges."
    Assert-True (([regex]::Matches($about, 'badge badge--preprint')).Count -eq 7) "Expected seven preprint badges."
    Assert-True (([regex]::Matches($about, '<span class="publication-count">5 papers</span>')).Count -eq 2) "Expected two five-paper counts."
    Assert-True ($about.Contains('<span class="publication-count">4 papers</span>')) "Missing four-paper count."
    Assert-True ($about.Contains('<span class="publication-count">3 papers</span>')) "Missing three-paper count."
    Assert-True (-not $about.Contains('Assistant Professor [Wentao Zhang](https://github.com) (PKU) to develop automated research agents')) "Research Topics still contains the removed Wentao Zhang clause."
    Assert-True ($about.Contains('I have also collaborated with [Jiahao Yuan](https://github.com) (ECNU).')) "Jiahao Yuan collaboration sentence is missing."
    Assert-True ($about.Contains('- *2026.07 - 2026.08*, Evolvent AI.')) "Evolvent AI internship is missing."
    foreach ($image in @('images/scope-router.png', 'images/dag.png', 'images/omni-deepsearch.png', 'images/videoafford.png')) {
        Assert-True (Test-Path -LiteralPath (Join-Path $repoRoot $image)) "Missing image: $image"
    }
}

if ($Check -in @("Styles", "All")) {
    foreach ($selector in @('.publication-section', '.publication-summary', '.publication-count', '.badge--accepted', '.badge--preprint')) {
        Assert-True ($scss.Contains($selector)) "Missing style selector: $selector"
    }
    Assert-True ($scss.Contains('focus-visible')) "Missing keyboard focus styling."
    Assert-True ($scss.Contains('grid-template-columns')) "Missing desktop publication grid."
    Assert-True ($scss.Contains('overflow-wrap: anywhere')) "Missing narrow-screen overflow protection."
    Assert-True ($scss.Contains('#1d4ed8')) "Missing accepted-paper blue."
    Assert-True ($scss.Contains('#b45309')) "Missing preprint amber."
    Assert-True ($scss.Contains('@media (max-width: 480px)')) "Missing narrow-mobile breakpoint."
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "FAIL: $_" -ForegroundColor Red }
    exit 1
}

Write-Output "Publication validation passed ($Check)."
