# Logo Scale and Internship Layout Fix Design

## Goal

Make the meaningful content inside the Internship logos easier to see, enlarge the school and laboratory logos in Research Experiences, and repair the malformed Internship layout visible on the deployed homepage.

## Design

- Replace the inline Kramdown Internship text containers with plain HTML so Jekyll emits balanced markup and no literal `</div>` text.
- Increase the desktop Internship logo column to 250 × 90 px and the mobile logo area to 210 × 76 px.
- Keep the wide institute logo contained at its natural aspect ratio. Give the square Evolvent artwork a dedicated modifier that enlarges and clips its surrounding whitespace while keeping the full visible mark and wordmark.
- Replace the seven inline `height: 1em` Research Experiences rules with a shared `.research-logo` class at 1.55 em desktop and 1.4 em mobile.
- Preserve the existing typography, colors, content order, links, and page structure outside these sections.

## Validation

- The publication validator must reject inline Markdown Internship containers, literal escaped closing tags, missing modifier classes, wrong logo dimensions, and fewer than seven shared Research logo classes.
- Jekyll output must contain two sibling Internship rows and must not contain `&lt;/div&gt;` near the Internship section.
- GitHub Pages and all referenced logo assets must return HTTP 200 after deployment.
