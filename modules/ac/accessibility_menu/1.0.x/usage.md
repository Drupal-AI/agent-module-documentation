<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessibility menu adds a floating accessibility widget — a button in the bottom-right corner that opens a panel where visitors adjust contrast, text size, spacing, images and more, with their choices remembered per-browser in localStorage.

---

The module is front-end work with a thin Drupal layer. A block plugin (id `accessibility_menu`) renders a button and slide-up panel; each control (contrast, font size, letter spacing, line height, images, font style, big cursor, reading line) cycles through preset steps applied to the page by `misc/accessibility_menu.js`, which persists the selection in `localStorage` (key `accessibility_menu`) and re-applies it on each load — nothing is stored server-side. A settings form at `/admin/config/development/accessibility-menu` (permission `administer site configuration`, config object `accessibility_menu.settings`) chooses which features appear (`plugins`), whether the widget is auto-injected site-wide (`enabled`, via `hook_preprocess_html` on the default theme), whether the JS is inlined (`inline`) and whether it shows on mobile (`show_mobile`). Assets live in `misc/` (compiled from an SCSS source), styling is driven by the CSS variable `--accessibility-menu-color`, and the info file declares an `interface translation project` so labels are translatable through drupal.org's localisation server. There are no dependencies beyond core (`^9.3 || ^10 || ^11`). Be clear about scope: an overlay like this helps visitors who need larger text or higher contrast and do not know their browser settings, but it does not make an inaccessible site accessible — semantic markup, keyboard operability, focus management and the design's own contrast are what WCAG measures. Treat it as a visitor convenience, not a compliance measure.

---

- Offer visitors a text-resize control.
- Provide a high-contrast toggle with four themes (high contrast, inversion, white, comfort).
- Add an accessibility widget to a public site.
- Help visitors who cannot change their browser settings.
- Meet a procurement requirement for an accessibility tool.
- Place the widget as a block in any region.
- Auto-inject the widget site-wide on the default theme without placing a block.
- Configure which accommodations (features) the panel offers.
- Show or hide the widget on mobile screens under 1200px.
- Inline the widget JS into the page head or serve it as a library.
- Offer grayscale or hidden images.
- Adjust line height (1.5x–2x) and letter spacing.
- Switch body text between serif and sans-serif.
- Add a big-cursor mode for pointer visibility.
- Add a mouse-following reading line to aid tracking.
- Reset all visual adjustments to defaults.
- Remember a visitor's choices per-browser across pages.
- Match the widget's accent color to a site's branding.
- Translate the widget's labels via the localisation server.
- Support visitors with low vision.
- Support a site still on Drupal 9.3.
