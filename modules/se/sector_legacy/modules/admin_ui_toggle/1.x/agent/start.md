<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI Toggle (admin_ui_toggle) — agent index

Submodule of **Sector Legacy**. Ships **one block** that hides/shows admin UI chrome on the front
end by toggling a body class. Package `Sector`. Core `^10 || ^11`. Depends on core **`block`**.
GPL-2.0-or-later. Version 1.0.6.

## What it provides (from source)

- **Block plugin** `AdminUiToggle` (`src/Plugin/Block/AdminUiToggle.php`), id **`admin_ui_toggle`**,
  admin label *"Sector blocks - Admin UI toggle"*, extends core `BlockBase`. `build()` returns a
  render array `#theme => 'admin_ui_toggle'` and attaches library `admin_ui_toggle/admin-ui-toggle`.
  No config form, no `blockAccess()` override (uses core block placement/visibility only).
- **hook_theme** `admin_ui_toggle_theme()` in `admin_ui_toggle.module` registers theme
  `admin_ui_toggle` (`render element => 'element'`), template
  `templates/admin-ui-toggle.html.twig` — renders `.admin-ui-toggle > p > button`.
- **Library** `admin-ui-toggle` (`admin_ui_toggle.libraries.yml`): `css/admin-ui-toggle.css` +
  `js/admin_ui_toggle.js`; deps `core/jquery`, `core/jquery.once`, `core/drupal`.
- **Behavior** `Drupal.behaviors.admin_ui_toggle` (`js/admin_ui_toggle.js`): on button click,
  `$('body').toggleClass('admin-ui-hide')` and adds/removes `ui-is-hidden` on `.admin-ui-toggle`;
  `evt.preventDefault()`. Actual hiding is done by **theme CSS** keyed on the `admin-ui-hide` body
  class (this module only flips the class).

- **Block plugin, markup, behavior, how to enable & place** →
  [blocks/admin-ui-toggle.md](blocks/admin-ui-toggle.md)

## Operate

- `drush en admin_ui_toggle -y`, then place the block (*Structure → Block layout*) in a region;
  restrict visibility/roles there. No routes, permissions, config objects, or config schema.

## Notes

- Purely client-side toggle of a CSS class; stores nothing and grants no access — what gets hidden
  depends entirely on the active theme's `.admin-ui-hide` rules.
- Uses `core/jquery.once`, deprecated in favor of `core/once`; still shipped by core in D10/D11.
