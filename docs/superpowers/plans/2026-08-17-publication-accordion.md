# Publication Accordion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an accessible, responsive publication accordion, visually distinguish accepted papers from preprints, retain the four newly added papers, and apply the requested profile and internship copy updates.

**Architecture:** Keep `_pages/about.md` as the single source of publication content and use native `<details>/<summary>` disclosure elements, so no JavaScript state is needed. Add focused SCSS in `assets/css/main.scss` for disclosure controls, badge variants, card polish, and mobile layout, plus a PowerShell validator that checks the content and style contract before deployment.

**Tech Stack:** Jekyll, Kramdown, HTML5 `<details>/<summary>`, SCSS, PowerShell validation, GitHub Pages.

## Global Constraints

- First-Author Accepted Papers is the only category expanded by default.
- First-Author Preprints, Co-Authored Papers, and preprint Papers are collapsed by default.
- Category counts are exactly 5, 4, 5, and 3 papers.
- Accepted-paper badges use deep blue; preprint badges use warm amber.
- Retain all 17 paper titles, authors, venues, images, ordering, and links.
- Retain the existing left-image/right-text desktop presentation and use image-above-text on narrow screens.
- Add `2026.07 - 2026.08, Evolvent AI` under Internships.
- Remove the Wentao Zhang/PKU clause from Research Topics while retaining the Jiahao Yuan collaboration sentence.
- Add no JavaScript, filters, search, or unrelated redesign.

---

### Task 1: Publication and Profile Contract

**Files:**
- Create: `scripts/validate_publications.ps1`
- Modify: `_pages/about.md:28`
- Modify: `_pages/about.md:45-240`
- Modify: `_pages/about.md:264-266`
- Include: `images/scope-router.png`
- Include: `images/dag.png`
- Include: `images/omni-deepsearch.png`
- Include: `images/videoafford.png`

**Interfaces:**
- Consumes: the 17 existing `.paper-box` entries in `_pages/about.md`.
- Produces: four `.publication-section` disclosures, four `.publication-summary` controls, 10 accepted badges, 7 preprint badges, corrected Research Topics copy, and the Evolvent AI internship entry.

- [ ] **Step 1: Write the failing content/style validator**

Create `scripts/validate_publications.ps1` with this contract:

```powershell
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
```

- [ ] **Step 2: Run the content validator to verify it fails**

Run:

```powershell
pwsh -File scripts/validate_publications.ps1 -Check Content
```

Expected: exit code 1, reporting missing publication sections, summaries, badge variants, and the Evolvent AI entry.

- [ ] **Step 3: Correct Research Topics and add the internship**

Replace the collaboration sentence with:

```markdown
Driven by my interest in LLM agent reasoning, I have also collaborated with [Jiahao Yuan](https://github.com) (ECNU).
```

Append this exact entry under `# 💻 Internships`:

```markdown
- *2026.07 - 2026.08*, Evolvent AI.
```

- [ ] **Step 4: Convert the four category headings into native disclosures**

Use this exact opening structure for the first category:

```html
<details class="publication-section" open markdown="1">
<summary class="publication-summary">
  <span class="publication-summary-title">First-Author Accepted Papers</span>
  <span class="publication-count">5 papers</span>
</summary>
```

Use the same structure without `open` for the remaining categories, with these exact title/count pairs:

```text
First-Author Preprints | 4 papers
Co-Authored Papers     | 5 papers
preprint Papers        | 3 papers
```

Close each category with `</details>` immediately before the next category or the Honors and Awards heading.

- [ ] **Step 5: Classify all venue badges**

Change the 10 conference/journal badge elements to `class="badge badge--accepted"` and the seven `arXiv` badge elements to `class="badge badge--preprint"`. Do not change badge text.

- [ ] **Step 6: Run the content validator and verify it passes**

Run:

```powershell
pwsh -File scripts/validate_publications.ps1 -Check Content
```

Expected: `Publication validation passed (Content).`

- [ ] **Step 7: Commit the content, validator, and paper assets**

```powershell
git add -- _pages/about.md scripts/validate_publications.ps1 images/scope-router.png images/dag.png images/omni-deepsearch.png images/videoafford.png
git diff --cached --check
git commit -m "feat: expand and organize publication profile"
```

---

### Task 2: Responsive Accordion and Card Styling

**Files:**
- Modify: `assets/css/main.scss:43-109`
- Test: `scripts/validate_publications.ps1`

**Interfaces:**
- Consumes: `.publication-section`, `.publication-summary`, `.publication-count`, `.badge--accepted`, and `.badge--preprint` from Task 1.
- Produces: accessible disclosure styling, distinct status colors, desktop card grid, and single-column mobile cards.

- [ ] **Step 1: Run the style validator to verify it fails**

Run:

```powershell
pwsh -File scripts/validate_publications.ps1 -Check Styles
```

Expected: exit code 1 with missing selector, focus, grid, and overflow messages.

- [ ] **Step 2: Implement the disclosure and card SCSS**

Replace the existing `.paper-box` and `.badge` blocks with SCSS that implements this exact contract:

```scss
.publication-section {
    margin: 1.25rem 0;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    background: #f8fafc;
    overflow: hidden;

    &[open] > .publication-summary {
        border-bottom-color: #e2e8f0;
    }

    &[open] > .publication-summary::after {
        transform: rotate(225deg);
    }
}

.publication-summary {
    display: flex;
    align-items: center;
    padding: 1rem 1.1rem;
    border-bottom: 1px solid transparent;
    color: #0f172a;
    cursor: pointer;
    list-style: none;
    font-size: 1.15rem;
    font-weight: 700;

    &::-webkit-details-marker { display: none; }
    &:hover { background: #f1f5f9; }
    &:focus-visible { outline: 3px solid rgba(37, 99, 235, .35); outline-offset: -3px; }
    &::after {
        content: "";
        width: .55rem;
        height: .55rem;
        margin-left: .85rem;
        border-right: 2px solid #475569;
        border-bottom: 2px solid #475569;
        transform: rotate(45deg);
        transition: transform .2s ease;
    }
}

.publication-summary-title { min-width: 0; }
.publication-count {
    margin-left: auto;
    padding: .2rem .65rem;
    border-radius: 999px;
    color: #475569;
    background: #e2e8f0;
    font-size: .78rem;
    font-weight: 600;
    white-space: nowrap;
}

.paper-box {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    margin: .9rem;
    padding: 1rem;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
    background: #fff;
    box-shadow: 0 4px 14px rgba(15, 23, 42, .06);
    transition: border-color .2s ease, box-shadow .2s ease, transform .2s ease;

    &:hover {
        border-color: #cbd5e1;
        box-shadow: 0 8px 22px rgba(15, 23, 42, .09);
        transform: translateY(-1px);
    }

    .paper-box-image {
        width: 100%;

        > div { position: relative; width: 100%; }
        img {
            display: block;
            width: 100%;
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            background: #f8fafc;
            object-fit: contain;
        }
    }

    .paper-box-text {
        min-width: 0;
        max-width: 100%;
        overflow-wrap: anywhere;

        > p:first-child a { color: #0f3d8a; font-size: 1.05rem; font-weight: 700; line-height: 1.35; }
    }

    @include breakpoint($medium) {
        display: grid;
        grid-template-columns: minmax(200px, 38%) minmax(0, 1fr);
        gap: 1.5rem;
        align-items: center;
        margin: 1rem 1.25rem;
        padding: 1.25rem;
    }
}

.badge {
    position: absolute;
    top: .55rem;
    left: -.4rem;
    z-index: 1;
    padding: .28rem .75rem;
    border-radius: 0 999px 999px 0;
    color: #fff;
    box-shadow: 0 2px 6px rgba(15, 23, 42, .18);
    font-size: .78rem;
    font-weight: 700;
    line-height: 1.35;
}

.badge--accepted { background: #1d4ed8; }
.badge--preprint { background: #b45309; }

@media (max-width: 480px) {
    .publication-summary { padding: .9rem; font-size: 1rem; }
    .publication-count { font-size: .72rem; }
    .paper-box { margin: .7rem; padding: .85rem; }
}
```

- [ ] **Step 3: Run the full validator and verify it passes**

Run:

```powershell
pwsh -File scripts/validate_publications.ps1 -Check All
git diff --check
```

Expected: `Publication validation passed (All).` and exit code 0 from `git diff --check`.

- [ ] **Step 4: Commit the styling**

```powershell
git add -- assets/css/main.scss
git diff --cached --check
git commit -m "style: add responsive publication accordions"
```

---

### Task 3: Release Preparation and Pre-Push Verification

**Files:**
- Verify: `_pages/about.md`
- Verify: `assets/css/main.scss`
- Verify: `scripts/validate_publications.ps1`
- Verify: `images/scope-router.png`
- Verify: `images/dag.png`
- Verify: `images/omni-deepsearch.png`
- Verify: `images/videoafford.png`

**Interfaces:**
- Consumes: the committed publication content and SCSS from Tasks 1-2.
- Produces: a clean, fully validated local `main` ready for whole-branch review and direct publication.

- [ ] **Step 1: Run fresh pre-push verification**

```powershell
pwsh -File scripts/validate_publications.ps1 -Check All
git diff --check
git status --short
git log -3 --oneline
```

Expected: validation passes, diff check exits 0, and only this implementation-plan document remains uncommitted.

- [ ] **Step 2: Commit the implementation plan**

```powershell
git add -- docs/superpowers/plans/2026-08-17-publication-accordion.md
git diff --cached --check
git commit -m "docs: add publication accordion implementation plan"
```

- [ ] **Step 3: Confirm the release candidate is clean**

```powershell
pwsh -File scripts/validate_publications.ps1 -Check All
git diff --check
git status --short
```

Expected: validation passes, diff check exits 0, and `git status --short` prints no tracked or untracked changes.

After this task passes its scoped review, run the required whole-branch review. Then push the reviewed `main` directly to `origin/main`, wait for GitHub Pages, and request `https://cuizhiq.github.io/`. The deployed HTML must contain `SCOPE-Router`, `Evolvent AI`, four `publication-section` controls, and the expected badge classes. Report any deployment failure instead of claiming publication success.
