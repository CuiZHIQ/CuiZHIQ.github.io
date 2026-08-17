# Logo Scale and Internship Layout Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Repair the Internship markup and make Internship and Research Experiences logos visibly larger without changing the site's established visual style.

**Architecture:** Keep the current Jekyll page structure and add only section-scoped classes. Use plain HTML for Internship copy and CSS containment/cropping for the two different logo aspect ratios.

**Tech Stack:** Jekyll, Kramdown, SCSS, PowerShell validation.

## Global Constraints

- Preserve current typography and colors.
- Do not change publication or News behavior.
- Keep the layout responsive at the existing 480 px breakpoint.

---

### Task 1: Add failing regression checks

**Files:**
- Modify: `scripts/validate_publications.ps1`

- [ ] Assert balanced plain-HTML Internship text, two logo modifiers, 250 × 90 px desktop dimensions, 210 × 76 px mobile dimensions, and seven `.research-logo` uses.
- [ ] Run `pwsh -NoProfile -File scripts/validate_publications.ps1 -Check All` and confirm it fails on the current malformed markup and old dimensions.

### Task 2: Repair markup and enlarge logos

**Files:**
- Modify: `_pages/about.md`
- Modify: `assets/css/main.scss`

- [ ] Replace the two inline Markdown text containers with balanced HTML and add the Evolvent modifier.
- [ ] Replace all seven inline Research logo styles with `.research-logo`.
- [ ] Apply the scoped desktop and mobile dimensions, including whitespace-aware Evolvent cropping.
- [ ] Run the full validator and confirm it passes.

### Task 3: Publish and verify

**Files:**
- No product files beyond Tasks 1–2.

- [ ] Run `git diff --check` and inspect the scoped diff.
- [ ] Commit and push `main`.
- [ ] Wait for GitHub Pages success and verify the live Internship HTML, CSS, and logo assets.
