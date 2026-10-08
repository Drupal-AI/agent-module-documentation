<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Area Print adds a Print button or link that sends one chosen region of the current page — an article, a table, a receipt — to the browser's print dialog, instead of printing the whole document.

---

The standards answer to printing is a print stylesheet, and it stays the right tool for controlling how a page looks on paper. What `@media print` does not do easily is let a visitor print one region on demand: it decides globally, so a page with several printable sections needs several stylesheets and a way to switch between them. Area Print takes the JavaScript route instead. It ships a render element (`print_area_button`, class `PrintButton` in `src/Element`), a placeable block (`print_area`, class `PrintArea` in `src/Plugin/Block`), and a small helper function `area_print()` in the `.module`. All three produce the same control: on click, `area_print.js` opens the current URL in a popup, hides everything except the element matched by a configured CSS selector, calls the browser print dialog, and closes the popup. The block exposes the button text, a link-or-button toggle, and the target selector; the render element exposes `#css_selector`, `#as_link`, and `#label`. Config schema for the block settings is present; there are no routes, permissions, services, or non-core dependencies, and no module settings page (configuration is per block instance). The newest release on the 2.0.x branch is 2.0.0-beta4 — the branch has no stable release. Two caveats worth stating when recommending it: a print stylesheet should still exist because this module governs only what is sent to the dialog, not how it renders; and JavaScript-driven printing behaves differently across browsers, so output should be checked in the browsers the site's audience actually uses. Note also that the current release renders the default "Print" label regardless of the configured button text, because the block and helper set `#value` while the element renders `#label`.

---

- Print a single article from a listing page.
- Print a table without the surrounding page.
- Give visitors a print button per region via a block.
- Print a receipt or confirmation area.
- Avoid printing navigation and footers.
- Print a recipe without the comments.
- Add a print control to a sidebar or region.
- Print a form's summary or a report section.
- Print a specific tab's content.
- Reduce paper use on long pages.
- Add a print link in custom code with the `area_print()` helper.
- Add a print control from a template or module via the `print_area_button` render element.
- Target any element by CSS selector, not just `#content`.
- Give a directory or catalogue entry a print option.
- Print an event's details only.
- Support a print-and-take workflow at a kiosk.
- Print a chosen region of a dashboard.
- Complement, not replace, a `@media print` stylesheet.
- Print a policy chapter alone.
- Provide a lightweight alternative to full PDF generation.
- Offer either a styled link or a native button for the print action.
