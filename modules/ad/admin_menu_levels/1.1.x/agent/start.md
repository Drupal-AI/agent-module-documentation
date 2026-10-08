<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Menu Levels (admin_menu_levels) — agent index

A JavaScript-only convenience module: adds a **depth-level select** and a **"Hide disabled items"
checkbox** to menu edit pages and filters the menu-overview table **client-side**. Package `Custom`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0. Not covered by the security
advisory policy.

- **The form_alter, the two controls, and the jQuery behavior** →
  [ui/menu-form.md](ui/menu-form.md)

## What it actually is

- **No** routes, permissions, config, config schema, services, plugins, or Drush. **No PHP beyond a
  single hook.** Nothing is persisted — the controls only drive client-side show/hide.
- `admin_menu_levels_form_menu_edit_form_alter()` (`admin_menu_levels.module`,
  `hook_form_FORM_ID_alter` for `menu_edit_form`) adds:
  - `field_levels` — a `select` (One/Two/Three, `#empty_option` "All" / `#empty_value` `all`),
  - `field_enabled_toggle` — a `checkbox` "Hide disabled items",
  - re-weights the core `label`/`id`/`description`/`langcode` elements,
  - attaches library `admin_menu_levels/admin_menu_levels`.
- Library `admin_menu_levels/admin_menu_levels` (`.libraries.yml`) = `js/admin-menu-levels.js`
  (deferred), depends on `core/drupal`, `core/jquery`.
- `Drupal.behaviors.adminMenuLevels` (`js/admin-menu-levels.es6.js` → compiled `.js`) tags each
  `#menu-overview` row with `admin-menu-levels--1/2/3` by counting `.indentation` cells, then shows/
  hides rows to match the selected depth and the hide-disabled toggle (using core's `.menu-enabled`
  / `.menu-disabled` row classes).

## Access & safety

- The controls live on the core menu-edit page, which is gated by core's own **`administer menu`**
  access — the module adds no access surface of its own.
- The select/checkbox `#options` are static `t()` strings; there is no user/remote data rendered,
  and the JS reads only `.val()`/`:checked` (not markup), so no injection surface.

> This module is a candidate for the skip-list: it is a trivial UI helper with no PHP API surface
> beyond one form_alter hook.
