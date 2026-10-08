<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A single placeable block ("Resize block") rendering three A-/A/A+ links so site visitors can step the page font size down, reset it, or step it up entirely client-side.

---

Font Resize ships one Block plugin (`resize_block`, class `ResizeBlock`, admin label "Resize block") whose `build()` emits a fixed `.box` markup fragment: three `<a class="font_resize-button">` links with ids `font_resize-minus` (A-), `font_resize-default` (A) and `font_resize-plus` (A+), each keyboard-focusable (`tabindex="0"`) and carrying an `aria-label`. The block attaches two JS libraries: `font_resize/font_resize` (a jQuery plugin `$.fn.font_resize` that wires the three links) and `font_resize/font_resize_example` (an initializer that applies the plugin to `$('html')`). Clicking A+ adds 1px to the target element's `font-size` on each click (up to 10 steps), A- subtracts 1px per click (down to 10 steps), and A resets; at either limit the corresponding button gets a `font_resize-disabled` class, and Enter activates a focused button. Because the shipped example targets the `<html>` element, the site theme must use relative units (em/rem) for the change to cascade to page text — this is the module's core requirement. There is no configuration form, config schema, route, permission, service or Drush command; the block has no per-instance settings, and both libraries depend only on `core/jquery`. To resize only part of the page you copy the example JS to target a different selector and attach it via your own block/library (see agent/theming/customize.md).

---

- Give visitors a visible A-/A/A+ control to change the site's text size.
- Add a lightweight text-zoom widget to any theme region via Block layout.
- Let low-vision visitors enlarge page text without browser zoom.
- Let visitors step the font size up one pixel at a time (up to 10 steps).
- Let visitors step the font size down one pixel at a time (up to 10 steps).
- Reset text back toward the theme's default size with the A button.
- Cap how far text can grow or shrink (fixed 10-step limits in the plugin).
- Signal the min/max limit by disabling the A-/A+ button (`font_resize-disabled` class).
- Provide keyboard-operable controls (focusable links, Enter to activate).
- Expose accessible labels via `aria-label` on each control.
- Resize the whole page by targeting the `<html>` element (shipped default).
- Resize only a specific region/class/id by copying the example initializer JS.
- Pair with a theme that uses em/rem so the size change cascades site-wide.
- Place the block in a header/sidebar so the control is always reachable.
- Offer an on-page alternative to relying on browser-native zoom.
- Style the A-/A/A+ buttons with your own CSS via the `font_resize-button` class.
- Restrict who sees the control using core block visibility conditions.
- Localize the button labels through Drupal's `t()` translation.
- Run entirely from local assets with no external CDN request.
- Support Drupal 10 and Drupal 11 sites with no module dependencies.
- Serve as a starting template for a custom per-element font-resize widget.
