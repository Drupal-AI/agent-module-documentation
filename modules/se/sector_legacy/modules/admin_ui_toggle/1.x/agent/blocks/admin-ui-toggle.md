<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Admin UI Toggle block

## Plugin

- Class `Drupal\admin_ui_toggle\Plugin\Block\AdminUiToggle` (`src/Plugin/Block/AdminUiToggle.php`),
  `@Block(id = "admin_ui_toggle", admin_label = "Sector blocks - Admin UI toggle")`.
- `build()` returns:
  - `#theme => 'admin_ui_toggle'`
  - `#attached['library'][] = 'admin_ui_toggle/admin-ui-toggle'`
- No `defaultConfiguration()`, `blockForm()`, `blockSubmit()`, or `blockAccess()` — it inherits
  core `BlockBase`, so placement region, visibility conditions and roles are set entirely on the
  block config UI.

## Markup & behavior

- Template `templates/admin-ui-toggle.html.twig`: `<div class="admin-ui-toggle"><p><button></button></p></div>`.
- `js/admin_ui_toggle.js` (`Drupal.behaviors.admin_ui_toggle`): binds click on
  `$("button", ".admin-ui-toggle")` → `$("body").toggleClass("admin-ui-hide")`; when body has
  `admin-ui-hide` it adds `ui-is-hidden` to `.admin-ui-toggle`, else removes it; calls
  `evt.preventDefault()`.
- The visual effect (what disappears when `admin-ui-hide` is on the body) is defined by **theme
  CSS**, not by this module. `css/admin-ui-toggle.css` styles only the toggle control itself.

## Enable & place

1. `drush en admin_ui_toggle -y` (pulls in core `block`).
2. *Structure → Block layout* → place *"Sector blocks - Admin UI toggle"* in a region; set role/
   visibility restrictions there (e.g. only authenticated/editor roles).
3. Add `.admin-ui-hide … { … }` rules in your theme to actually hide admin decorations.

## Boundaries

- Client-side only; the toggle state is not persisted across page loads and is not tied to any
  permission or stored setting. No routes, permissions, config, schema, hooks besides `hook_theme`.
