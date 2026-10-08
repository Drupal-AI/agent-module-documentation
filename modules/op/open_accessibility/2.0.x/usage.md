<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Accessibility ships the jQuery-based "Open Accessibility" widget (a re-package of Jossef Harush Kadouri's open-source plugin) as a placeable Drupal block: a floating toolbar offering larger text, higher contrast, link highlighting, readable font, cursor and image controls. All JS/CSS is bundled with the module — nothing is fetched from a CDN.

---

The mechanism is small and worth knowing exactly. A single core Block plugin, `open_accessibility_block` ("Open Accessibility"), is what puts the widget on the page: place it in any region (Block layout) and its `build()` attaches the `open_accessibility/open-accessibility` library and hands four values to the front end through `drupalSettings.openAccessibility` — `menu_opened`, `mobile_enabled`, `text_selector`, `icon_size` (the block also references a `highlighted_links` key that no config screen sets, so it is always null). The library is `js/open-accessibility.min.js` (the vendored plugin) plus `js/open-accessibility-settings.js`, which calls `$('header').openAccessibility({...})` reading those drupalSettings, with `core/jquery` as the one dependency; styling is `css/open-accessibility.min.css`. Configuration lives at `/admin/config/user-interface/open-accessibility` behind a dedicated `configure open accessibility` permission (a standard `ConfigFormBase`, so admin-gated and CSRF-protected): checkboxes for "Expanded by default" and "Enable on Mobile", a required comma-separated "Zoom HTML tags" selector (default `body,h1,h2,h3,h4,p,div,span`), and an Icon Size select (Small/Medium/Large). The block sets `getCacheMaxAge(0)`. Version **2.0.1**, core `^10 || ^11`. What must be said alongside any overlay module, because it is the single most consequential piece of advice here: **an accessibility overlay is not accessibility conformance, and the accessibility community is broadly opposed to overlays.** People who need larger text or higher contrast overwhelmingly already have it configured in their OS and browser; screen-reader users bring their own software and a DOM-manipulating overlay can conflict with it; and an overlay cannot fix what actually fails an audit — missing alt text, unlabelled form controls, keyboard traps, poor heading structure, insufficient contrast in the design. If the driver is WCAG 2.2 AA, EN 301 549 or the European Accessibility Act, that is met by fixing the site, and an overlay can even be cited as evidence the underlying problems were known. Reach for this only as an addition to a site that already conforms — never as a route to conformance.

---

- Place a floating accessibility toolbar via a block.
- Add a text-resize (zoom) control.
- Offer a high-contrast mode.
- Highlight links on request.
- Provide a readable-font toggle.
- Add a cursor-size control.
- Offer an image-hiding / focus mode.
- Configure which HTML tags the zoom feature targets.
- Choose the toolbar icon size (small/medium/large).
- Have the menu expanded by default on load.
- Enable or disable the widget on mobile.
- Restrict who can configure it via a dedicated permission.
- Add a visible accessibility widget without a CDN dependency (assets are bundled).
- Respond to a stakeholder or procurement request for a visible a11y control.
- Support visitors who lack OS-level display settings.
- Offer per-visitor display preferences.
- Add a widget alongside an already-conformant site.
- Signal a public-sector accessibility expectation.
- Complement (not replace) an accessibility remediation programme.
- Give editors a one-click block to add to a region.
