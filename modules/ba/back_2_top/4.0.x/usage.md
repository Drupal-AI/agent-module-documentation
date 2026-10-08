<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Back-2-Top adds a configurable, dependency-free "back to top" button that appears when a page is taller than the viewport and smoothly scrolls the user to the top when clicked.

The entire module is one admin settings form plus a `hook_page_attachments()` implementation. `back_2_top_page_attachments()` reads the `back_2_top.settings` config object and, when `enabled` is set, attaches the `back_2_top/back_to_top` library (`js/back_2_top.js` + `css/back_2_top.css`) and passes the button configuration to the browser via `drupalSettings.back2Top`. The vanilla-JS behaviour (`Drupal.behaviors.back2Top`) creates a `<button class="back-2-top">` element, appends it to `document.body`, shows it once the user scrolls past one viewport height, and animates `window.scrollTo` back to the top on click. Admins control on/off, corner position (bottom-left / bottom-center / bottom-right), color, opacity, size, glyph (built-in triangle/chevron/arrow or a custom uploaded image stored as a managed file), and whether the button also appears on admin routes. There are no routes beyond the settings form and no external requests.

Typical setup: enable the module, open Configuration → User Interface → Back-2-Top Settings (`/admin/config/user-interface/back-2-top`), toggle it on, and adjust appearance and visibility.

---

Short summary: a themeable, dependency-free scroll-to-top button configured from one admin form and injected site-wide via page attachments.

It solves the common UX need for a scroll-to-top affordance on long pages without pulling in jQuery or a third-party library. It works by attaching a small JS behaviour and CSS parameterised by config stored in `back_2_top.settings`. The button stays hidden until the document is taller than the viewport and the user has scrolled past one screen height; the only administrative surface is the settings form, gated by the `administer site configuration` permission. A custom button image is uploaded through a `managed_file` element and deleted on module uninstall.

---

- Enable the module to add a back-to-top button across the whole site.
- Turn the button on or off from the settings form (`enabled`).
- Position the button at bottom-left, bottom-center, or bottom-right.
- Set the button background color with a color picker (`color`).
- Adjust the button opacity from 0.1 to 1.0 (`opacity`).
- Set the button size in pixels, 20–100 (`size`).
- Choose a built-in triangle, chevron, or arrow glyph (`image_type`).
- Upload a custom PNG/JPG/GIF/SVG image (max 2 MB) for the button.
- Show or hide the button on administrative pages (`show_on_admin`).
- Provide smooth 500 ms ease-out scrolling back to the top of long pages.
- Improve navigation UX on long articles, listings, and reports.
- Keep the button hidden until the page exceeds one viewport height and the user scrolls.
- Ship a scroll-to-top affordance without any JavaScript framework dependency.
- Match the button color to the site theme.
- Restrict configuration to trusted users via the `administer site configuration` permission.
- Tune button prominence via opacity and size for accessibility.
- Remove the button quickly by unchecking `enabled` in config.
- Override the default look by styling the `.back-2-top` class (and glyph child classes) in your theme CSS.
- Rely on automatic cleanup: any uploaded custom image is deleted when the module is uninstalled.
