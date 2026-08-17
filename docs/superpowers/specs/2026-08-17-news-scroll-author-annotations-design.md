# News Scrolling and Author Annotation Design

## Summary

Enhance the existing academic homepage without changing its current visual identity. The change adds accessible vertical auto-scrolling to the News section, standardizes equal-contribution annotations, labels Zhiqing Cui as Project Leader on two specified papers, adds one verified accepted paper, and gives the two internship entries larger official logos.

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

### Less is More publication

Add the following accepted work to Co-Authored Papers:

- Title: `LLMSR@XLLM25: Less is More: Enhancing Structured Multi-Agent Reasoning via Quality-Guided Distillation`
- Official paper link: `https://aclanthology.org/2025.xllm-1.23/`
- Authors: `Jiahao Yuan, Xingzhe Sun, Xing Yu, Jingwen Wang, Dehui Du, Zhiqing Cui, Zixiang Di`, with only Zhiqing Cui bolded
- Badge: `XLLM 2025` using the existing accepted-paper badge style
- Venue: `XLLM@ACL 2025 (Shared Task, 3rd Place)`
- Local image: `images/less-is-more.png`, downloaded from the official project repository asset `https://raw.githubusercontent.com/JhCircle/Less-is-More/main/asset/less_is_more.png`

Increase the Co-Authored Papers count from 5 to 6, the total paper-card count from 17 to 18, and the accepted-paper badge count from 10 to 11. Do not classify this proceedings paper as a preprint.

### Internship logos

Replace the two plain Internship list items with two semantic internship rows while preserving their existing dates and organization wording.

- Yangtze River Delta Information Intelligence Innovation Research Institute uses the official horizontal SVG from `https://www.ustciscr.cn/Public/Home/images/logo_12.svg`, stored as `images/yangtze-info-institute.svg` and linked to `https://www.ustciscr.cn/`.
- Evolvent AI uses the official square brand image from `https://evolvent.co/images/logo/logo-square.png`, stored as `images/evolvent-ai.png` and linked to `https://evolvent.co/`.
- Each desktop row uses a logo area up to `170px` wide and `64px` high, followed by the original date and organization text.
- At widths up to `480px`, the logo area is up to `140px` wide and `52px` high and stacks above the text.
- Images use `object-fit: contain`, descriptive alternative text, and no cropping, recoloring, generated replacement, or third-party logo recreation.

## Visual Constraints

- Do not change the site's global palette, background, fonts, content width, sidebar, headings, publication accordion layout, cards, badges, or existing responsive breakpoints.
- New News styles must reuse inherited typography and colors.
- New Internship styles must inherit existing typography and colors; white or transparent official-logo backgrounds remain unchanged.
- Any scrollbar styling must be minimal and use existing neutral colors; the section must remain usable with the browser's native scrollbar.
- Mobile behavior must preserve touch scrolling and must not cause horizontal overflow.

## Implementation Boundaries

- `_pages/about.md` owns the News wrapper and author-text updates.
- `_pages/about.md` also owns the additional accepted-paper card and the two branded internship rows.
- `assets/css/main.scss` owns the small, News-specific viewport and reduced-motion styles.
- `assets/css/main.scss` owns only the bounded Internship row and logo-size rules needed for the two official assets.
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
- Confirm Less is More appears exactly once in Co-Authored Papers with the official ACL Anthology link, exact authors, accepted badge, venue, and official local image.
- Confirm publication totals are 18 cards, 11 accepted badges, and 7 preprint badges; Co-Authored Papers displays 6 papers.
- Confirm both official internship images exist with exact case, appear once, have descriptive alt text, and link to the official organization websites.
- Confirm the News wrapper, styles, script include, reduced-motion handling, and native overflow fallback are present.
- Run the existing full publication validator, `git diff --check`, and a production Pages build or deployment check.
- After deployment, verify the live page, script, stylesheet, annotations, and News fallback return successfully.

## Non-Goals

- No page-wide recoloring or typography change.
- No redesign of the sidebar, hero, publication-card system, research experiences, awards, services, or visitor map; Internship changes are limited to the two specified logo rows.
- No Internship copy editing beyond restructuring the two existing lines around their official logos.
- No News copy editing, deletion, reordering, or data migration.
- No new dark mode, navigation system, animation library, or visual branding system.
