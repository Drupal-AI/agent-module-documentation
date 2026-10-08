<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a configurable block that renders a thin bar at the top of the page which fills in proportion to how far the visitor has scrolled through the content.

---

On long articles, tutorials or documentation, readers have no sense of how much remains. This module adds a reading-position indicator: a block whose JavaScript (`js/reading_progress_bar.js`, using `core/drupal` and `core/once`) measures scroll position against document (or a chosen container) height and grows a coloured bar accordingly. It ships a block plugin, a Twig theme hook (`reading_progress_bar`), and a CSS/JS library.

Everything is configured through the block's settings form: bar height, fill colour, background colour or transparency, border, a minimum document/screen ratio below which the bar stays hidden, an auto-hide delay after scrolling stops, and an optional DOM `container_selector` to track a specific element instead of the whole page. Because the bar renders fixed at the very top, the README notes it can sit behind the admin toolbar — verify appearance as an anonymous user.

Typical setup: place the “Reading Progress Bar block” in a region (often the very top / header), tune its colours and behaviour, and clear caches. No custom permissions or routes are added.

---

- Show reading progress on long blog posts and articles
- Add a reading-position indicator to documentation pages
- Track progress within a specific content container via a CSS selector
- Customise the bar height to a thin or bold line
- Set the fill colour to match the site's brand
- Use a transparent background instead of a solid colour
- Add a border to the progress bar
- Hide the bar on short pages below a document/screen ratio
- Auto-hide the bar after scrolling pauses for a set delay
- Place the bar block at the top of the page region
- Provide visual feedback for tutorial/step content
- Improve UX on knowledge-base and help pages
- Restrict the bar to article content by targeting its container
- Keep the indicator lightweight using core/drupal and core/once
- Theme the bar markup via the `reading_progress_bar` Twig hook
- Configure separate colour when transparency is disabled
- Verify placement against the admin toolbar as an anonymous user
- Enable per-block so different sections can differ
- Give readers a sense of remaining length on long-form content
