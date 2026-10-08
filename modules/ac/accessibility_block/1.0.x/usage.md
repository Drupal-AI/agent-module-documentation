<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A single placeable block that gives site visitors a floating accessibility toolbar for changing body/paragraph font size and switching between colored and grayscale appearance.

---

Accessibility Tools block ships one Block plugin (`accessibility_block`, class `AccessibilityTools`) that renders a floating accessibility widget. A launcher icon opens a panel with two groups of controls: a "Dark Mode" group that toggles a `greyscale` class on `<html>` (Colored / Grayscale), and a "Font Resize" group offering Small / Medium / Large / X-Large text sizes. The pixel value for each of the four sizes is set by the site builder in the block's configuration form; the block passes those numbers to the browser via `drupalSettings`. All switching is done client-side in `assets/js/main.js` and each choice is persisted in the browser's `localStorage` (`appearance` and `FontSize` keys), so the visitor's preference sticks across page loads without any server-side storage. The site builder can also hide either the Dark Mode group or the Font Resize group per block instance. There are no routes, permissions, services, or config entities beyond the standard block instance; it relies only on `core/jquery` and `core/drupalSettings`, and all icons/CSS/JS are shipped locally.

---

- Add a visitor-facing accessibility toolbar to any theme region via Block layout.
- Let visitors enlarge body text to a site-builder-defined "Small" pixel size.
- Let visitors enlarge body text to a "Medium" pixel size.
- Let visitors enlarge body text to a "Large" pixel size.
- Let visitors enlarge body text to an "X-Large" pixel size.
- Offer a one-click grayscale mode for low-vision or color-sensitivity users.
- Offer a "Colored" toggle to return to the normal palette.
- Persist a visitor's chosen font size across page views using localStorage.
- Persist a visitor's chosen color mode across page views using localStorage.
- Place multiple instances in different regions with different enabled controls.
- Hide the Dark Mode group on a given block instance (Disable Dark Mode).
- Hide the Font Resize group on a given block instance (Disable Font Resize).
- Provide a floating launcher icon that opens/closes an overlay panel.
- Close the panel by clicking outside its container.
- Improve WCAG-oriented text-resize affordances without theme rework.
- Give editors a drop-in a11y widget instead of a paid third-party toolbar.
- Run entirely from local assets (no external CDN or tracking script).
- Support Drupal 10 and Drupal 11 sites.
- Localize the toolbar labels through Drupal's `t()` translation.
- Style the widget by overriding `assets/css/style.css` or the Twig template.
- Restrict which visitors see the widget using core block visibility conditions.
- Pair with a theme's own dark-mode CSS by keying off the `greyscale`/size classes on `<html>`.
