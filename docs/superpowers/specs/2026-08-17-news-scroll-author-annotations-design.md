# News Scrolling and Author Annotation Design

## Summary

Enhance the existing academic homepage without changing its current visual identity. The change adds accessible vertical auto-scrolling to the News section, standardizes equal-contribution annotations, and labels Zhiqing Cui as Project Leader on two specified papers.

## Scope

### News scrolling

- Keep the current News heading, wording, order, emoji, typography, colors, and page position.
- Place the existing News list in a vertical viewport with a `14rem` maximum height on desktop and `11rem` on screens up to `480px` wide.
- Preserve native wheel and touch scrolling as the baseline behavior.
- Add progressive-enhancement JavaScript that waits four seconds, then advances the viewport by one complete news item every four seconds.
- After the last item, return to the first item and continue the loop.
- Pause automatic movement while the pointer is over the News viewport or while keyboard focus is inside it. Touch or manual wheel scrolling pauses automatic movement for eight seconds before resuming when no other pause condition applies.
- Respect `prefers-reduced-motion: reduce` by disabling automatic movement while retaining native scrolling.
- If JavaScript fails or is unavailable, the News section remains a normally usable scrollable list.

### Equal-contribution notation

Use the dagger symbol consistently for every currently identified equal-contribution author. Do not use an asterisk or a superscript variant.

The affected author lines are:

- CauAir: `Jiaming Ma†, Zhiqing Cui†`
- MADGCN: `Zhiqing Cui†, Binwu Wang†`
- SCOPE-Router: `Tao Yu†, Yifei Qu†, Zhiqing Cui†`
- PaperX: `Tao Yu†, Minghui Zhang†, Zhiqing Cui†`

Bold only Zhiqing Cui's name, following the site's established author-emphasis convention. Each affected paper must include the note `† Equal contribution` directly below its publication metadata.

### Project Leader notation

Add `Project Leader` only to Zhiqing Cui in these two papers:

- SCOPE-Router
- PaperX

The visible author text should follow this Markdown pattern:

`Tao Yu†, Yifei Qu†, **Zhiqing Cui†** (Project Leader), ...`

Zhiqing Cui's name and associated dagger remain bold. Tao Yu and all other authors retain their normal author styling. Omni-DeepSearch and all other papers must not receive a Project Leader label.

## Visual Constraints

- Do not change the site's global palette, background, fonts, content width, sidebar, headings, publication accordion layout, cards, badges, or existing responsive breakpoints.
- New News styles must reuse inherited typography and colors.
- Any scrollbar styling must be minimal and use existing neutral colors; the section must remain usable with the browser's native scrollbar.
- Mobile behavior must preserve touch scrolling and must not cause horizontal overflow.

## Implementation Boundaries

- `_pages/about.md` owns the News wrapper and author-text updates.
- `assets/css/main.scss` owns the small, News-specific viewport and reduced-motion styles.
- A dedicated lightweight JavaScript file owns the News timer and pause/resume behavior, and is loaded from the existing page script include.
- `scripts/validate_publications.ps1` is extended to protect the annotation rules and ensure the News enhancement is wired correctly.
- No framework, dependency, site-wide theme replacement, or unrelated refactor is introduced.

## Accessibility and Failure Handling

- The News content remains ordinary semantic list content in document order.
- Keyboard focus inside the News section pauses motion.
- Reduced-motion users receive no automatic animation.
- Timer logic must not trap focus, block manual scrolling, or continuously fight a user's scroll position.
- A JavaScript error must not hide or remove any News item.

## Validation

- Confirm all four equal-contribution papers use `†` and display `† Equal contribution`.
- Confirm SCOPE-Router and PaperX contain exactly one `Project Leader` label for Zhiqing Cui, with no such label on any other paper.
- Confirm no former SCOPE-Router `* Equal contribution` markup remains.
- Confirm the News wrapper, styles, script include, reduced-motion handling, and native overflow fallback are present.
- Run the existing full publication validator, `git diff --check`, and a production Pages build or deployment check.
- After deployment, verify the live page, script, stylesheet, annotations, and News fallback return successfully.

## Non-Goals

- No page-wide recoloring or typography change.
- No redesign of the sidebar, hero, publications, research experiences, awards, services, internships, or visitor map.
- No News copy editing, deletion, reordering, or data migration.
- No new dark mode, navigation system, animation library, or visual branding system.
