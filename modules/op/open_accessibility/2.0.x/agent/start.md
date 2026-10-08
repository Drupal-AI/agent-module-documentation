<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Accessibility (open_accessibility) — agent index

Front-end **accessibility toolbar** widget (text zoom, contrast, link highlighting, readable
font, cursor/image controls), a re-package of Jossef Harush Kadouri's open-source jQuery
`open-accessibility` plugin. Version **2.0.1**, core `^10 || ^11`. Package: Accessibility.
License GPL-2.0-or-later.

## Mechanism (verified from source)
- **Block plugin** `open_accessibility_block` (admin label "Open Accessibility"),
  `src/Plugin/Block/OpenAccessibilityBlock.php`. This is the only thing that renders the
  widget — you must place the block in a region. Its `build()` attaches the
  `open_accessibility/open-accessibility` library and passes settings via
  `drupalSettings.openAccessibility` (`menu_opened`, `highlighted_links`, `mobile_enabled`,
  `text_selector`, `icon_size`). `getCacheMaxAge()` returns 0.
  - Note: `highlighted_links` is read in `build()` but no config screen sets it → always null.
- **Library** `open_accessibility/open-accessibility` (`open_accessibility.libraries.yml`):
  `css/open-accessibility.min.css`, `js/open-accessibility.min.js` (the vendored plugin,
  header scope), `js/open-accessibility-settings.js` (footer). Dependency: `core/jquery`.
  **All assets are bundled locally — no CDN / external fetch.**
- **Init glue** `js/open-accessibility-settings.js`: `Drupal.behaviors.open_accessibility`
  calls `$('header').openAccessibility({ maxZoomLevel:5, minZoomLevel:0.1, zoomStep:0.2,
  isMenuOpened, isMobileEnabled, textSelector, iconSize, localization:['en'] })` reading the
  drupalSettings values.
- **Config form** `src/Form/OpenAccessibilityConfigForm.php` (`ConfigFormBase`) at route
  `open_accessibility.settings` → `/admin/config/user-interface/open-accessibility`, gated by
  permission `configure open accessibility` (`_admin_route: TRUE`). Fields: `menu_opened`
  (checkbox "Expanded by default"), `mobile_enabled` (checkbox "Enable on Mobile"),
  `text_selector` (required textfield "Zoom HTML tags", comma-separated),
  `icon_size` (select s/m/l). Editable config: `open_accessibility.settings`.
- **Config** `config/install/open_accessibility.settings.yml` defaults: `menu_opened: true`,
  `mobile_enabled: true`, `text_selector: 'body,h1,h2,h3,h4,p,div,span'`, `icon_size: 'm'`.
  Schema in `config/schema/open_accessibility.schema.yml`.
- **Permission** (`open_accessibility.permissions.yml`): `configure open accessibility`.
- **Menu link** `open_accessibility.links.menu.yml`: under `system.admin_config_ui`.
- `hook_help()` on `help.page.open_accessibility` (the only hook in `.module`).
- No dependencies on other contrib modules, no Drush commands, no submodules, no services.

## Solution types
- `blocks/` — placing and configuring the widget block.
- `config/` — the settings form fields and their front-end effect.

## Overlay caveat (say this whenever the module comes up)
**An accessibility overlay is not accessibility conformance, and the accessibility community is
broadly opposed to overlays.** Concretely:
- users who need larger text / higher contrast **already have it configured** in their OS and
  browser; a site widget duplicates that at best;
- screen-reader users bring **their own software**, and a DOM-manipulating overlay can
  **conflict** with it;
- an overlay **cannot fix what fails an audit** — missing alt text, unlabelled form controls,
  keyboard traps, poor heading structure, insufficient contrast in the design.

If the driver is **WCAG 2.2 AA, EN 301 549 or the European Accessibility Act**, that is met by
fixing the site; an overlay can even be cited as evidence the underlying problems were known.
Reach for this only as an **addition to a site that already conforms** — never as a route to it.
