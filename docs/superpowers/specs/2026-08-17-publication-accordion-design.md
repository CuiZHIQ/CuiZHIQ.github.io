# Publication Accordion Design

## Goal

Shorten the publication section on first load while preserving the current academic-card presentation and making it comfortable to use on desktop and mobile.

## Approved Scope

- Keep **First-Author Accepted Papers** expanded by default.
- Keep **First-Author Preprints**, **Co-Authored Papers**, and **preprint Papers** collapsed by default.
- Show each section's paper count and a directional arrow in its heading.
- Use visually distinct colors for accepted-paper and preprint badges.
- Improve responsive behavior for desktop, tablet, and mobile.
- Preserve all paper titles, authors, venues, images, ordering, and links.

## Structure and Behavior

Each publication category will use a native HTML `<details>` element with a `<summary>` heading. The accepted first-author section will include the `open` attribute; the other three sections will omit it. This provides keyboard support and folding behavior without JavaScript.

The summary will contain:

- the existing category title;
- the exact number of papers in that category;
- a CSS arrow that rotates when the section opens.

The four counts at implementation time are:

- First-Author Accepted Papers: 5;
- First-Author Preprints: 4;
- Co-Authored Papers: 5;
- preprint Papers: 3.

## Visual Treatment

The current left-image/right-text paper cards remain in place. Styling changes are limited to publication presentation:

- clearer spacing and typography hierarchy around category summaries;
- a subtle border, background, radius, and hover treatment for cards;
- consistent image sizing without cropping important figure content;
- deep blue venue badges for accepted papers;
- warm amber `arXiv` badges for preprints;
- visible keyboard focus styling on section summaries.

No filters, search controls, animation library, or JavaScript state will be added.

## Responsive Behavior

On medium and large screens, cards retain the existing image-left/text-right layout. On narrow screens, each card becomes a single column with the image above the text. Titles, author lists, badges, and section summaries must wrap without horizontal scrolling or clipping. Touch targets on summaries will receive sufficient vertical padding.

## Fallback and Accessibility

Native `<details>` and `<summary>` preserve keyboard activation and expose the open/closed state to assistive technology. All publication content remains in the page source. If custom CSS fails, the browser's native disclosure control remains usable and the content stays readable.

## Validation and Delivery

Validation will cover:

- balanced disclosure and card markup;
- correct default open/closed states and category counts;
- accepted/preprint badge classification for all 17 cards;
- valid local image references and no horizontal-overflow rules;
- responsive CSS breakpoints and focus-visible styling;
- the GitHub Pages deployment result after pushing.

After validation, all requested publication additions and presentation changes will be committed and pushed directly to `origin/main`, without opening a pull request.

## Non-Goals

- Reordering or rewriting publication metadata;
- changing other homepage sections;
- adding topic/year filters or publication search;
- auditing or replacing links for previously listed papers;
- redesigning the site's global navigation or theme.
