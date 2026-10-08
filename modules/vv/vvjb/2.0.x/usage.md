<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Vanilla Javascript Basic Carousel (VVJB) adds a Views style plugin that renders any View's results as an accessible, responsive carousel using plain JavaScript instead of jQuery or a bundled slider library.

---

Views has no carousel of its own, so sites reach for a contrib slider — and typically inherit jQuery, a third-party plugin, and that plugin's accessibility record along with it. VVJB takes the other route: vanilla JavaScript, no framework, no bundled library, and accessibility treated as a requirement — keyboard operation (arrows, Space, Home, End), correct ARIA roles and live-region announcements, `inert` on hidden slides, and reduced-motion handling. Each row of the View becomes a slide, and it works with either Fields rows or entity/Content (teaser) rows.

Under the hood it is a Views style plugin (`views_vvjb`, class `BasicCarousel`) that renders a `<vvjb-carousel>` custom element and drives all behavior client-side from `data-*` attributes. In 2.x it builds on the shared `vvj_core` module (installed automatically with composer), which holds the base style plugin, the token resolver, and the JavaScript `ElementBase`, so the whole VVJ family can be mixed on one site without duplicating the foundation. Options cover orientation (horizontal / vertical / hybrid), items-per-screen at small and large viewports, gap and item width, autoplay interval with play/pause, looping, touch/swipe, five responsive breakpoints, arrow/dot navigation with scrollable dots, progress bar, page counter, and shareable per-slide deep links. It also exposes a `Drupal.vvjb.*` JavaScript API and `[vvjb:FIELD]` Views tokens for header/footer/empty text.

Two constraints to plan around: core `^11.3 || ^12` (no Drupal 10 path) and **PHP 8.3+** — both deliberately forward-looking for contrib. Because it is only the rendering layer, everything Views already offers — filters, sorts, contextual arguments, pagers, caching, access — behaves normally.

---

- Render Views results as an accessible carousel.
- Replace a jQuery-based carousel/slider module.
- Avoid pulling a third-party JavaScript library onto the page.
- Meet keyboard accessibility requirements for carousel content.
- Give screen-reader users correct ARIA roles, state, and slide announcements.
- Build a carousel from a filtered content listing.
- Drive the carousel from taxonomy- or reference-filtered results.
- Use contextual filters to vary carousel content per page.
- Combine the carousel with a Views pager, sorts, and access checks.
- Show a horizontal, vertical, or hybrid (vertical-below-breakpoint) carousel.
- Autoplay a promotional carousel with a play/pause control and progress bar.
- Set different items-per-screen on small vs large viewports.
- Provide shareable deep links to individual slides (`#carousel-products-3`).
- Drive the carousel programmatically from site JS via `Drupal.vvjb.*`.
- Inject first-row field values into Views header/footer text with `[vvjb:field]` tokens.
- Respect users' reduced-motion preference automatically.
- Mix multiple VVJ formats (accordion, slideshow, tabs…) on one site without duplication.
- Theme the carousel with the site's own CSS (stable `.vvjb-*` classes).
- Reduce front-end payload on a content-heavy page.
- Plan a Drupal 11.3+ / PHP 8.3 front-end stack.
- Retire an unmaintained or inaccessible carousel module.
- Upgrade a 1.x VVJB install with API/class/library names preserved.
- Start from the shipped `vvjb_example` reference view.
