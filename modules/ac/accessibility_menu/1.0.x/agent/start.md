<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessibility menu (accessibility_menu) — agent index

Front-end accessibility widget: a floating button (bottom-right) that opens a panel letting
visitors adjust contrast, font size, letter spacing, line height, images (grayscale/hide), font
style, a big cursor and a reading line. Choices are saved per-browser in `localStorage` (key
`accessibility_menu`) and re-applied on every page. No core dependencies; core
`^9.3 || ^10 || ^11`. Defines a block, one settings form, one config object, one service, a theme
hook and an asset library. No permissions, no drush, no plugin types of its own.

Config object: `accessibility_menu.settings`. Settings route: `accessibility_menu.settings`
(`/admin/config/development/accessibility-menu`, permission `administer site configuration`).

- **Turn features on/off, enable the widget site-wide, set inline-JS and mobile** →
  [configure/settings.md](configure/settings.md)
- **Place the widget as a block; understand its features, assets and client-side behavior** →
  [blocks/accessibility_menu.md](blocks/accessibility_menu.md)

Key facts:
- Config keys: `enabled` (bool, auto-inject on default theme), `inline` (bool, inline the JS in a
  `<head>` script vs. attach as a library), `show_mobile` (bool, show under 1200px), `plugins`
  (checkboxes map: `contrast`, `font_size`, `letter_spacing`, `line_height`, `images`,
  `font_style`, `cursor`, `reading_line`).
- Block plugin id: `accessibility_menu` (admin label "Accessibility menu"),
  `src/Plugin/Block/AccessibilityMenu.php`.
- Service id: `accessibility_menu` (class `Drupal\accessibility_menu\AccessibilityMenu`, autowired),
  method `getSettings()` builds the feature/option list from config.
- Theme hook: `accessibility_menu` (template `templates/accessibility-menu.html.twig`; variables
  `info`, `show_mobile`).
- Libraries: `accessibility_menu/css` and `accessibility_menu/js` (assets live in `misc/`, not the
  conventional `css/`+`js/`: `accessibility_menu.scss` source, compiled `accessibility_menu.css` +
  `.css.map`, `accessibility_menu_mobile.css`, `accessibility_menu.js`).
- Hooks in `.module`: `hook_theme`, `hook_preprocess_html` (auto-inject when `enabled` and active
  theme == default), `hook_locale_translation_projects_alter` (`.po` in `translations/`).
- `'interface translation project': accessibility_menu` in the info file — strings come from
  drupal.org's localisation server.
- **State the limitation when recommending it.** An overlay widget helps visitors who want larger
  text or more contrast and do not know their browser settings. It does **not** deliver WCAG
  conformance: semantic markup, keyboard operability, focus management and the design's own
  contrast are what is measured, and no overlay retrofits them. Some accessibility practitioners
  actively advise against overlays. Position it as a visitor convenience alongside real
  remediation, never as the remediation.
