<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Breadcrumb Menu (breadcrumb_menu) — agent index

Replaces core's breadcrumb builder so that breadcrumb links whose URL matches a link in
the active **menu** trail are re-labelled with the **menu link title** instead of the page
title. It does not change the trail's *shape* — the trail is still the standard path-based
trail; only the link **text** is swapped where a configured menu's active trail contains a
matching URL. No dependencies beyond core. Core requirement `^8 || ^9 || ^10 || ^11`.

Configure route: `breadcrumb_menu.settings` → `/admin/config/system/breadcrumb-menu`
(permission `administer breadcrumb_menu`). Defines 1 permission, 0 drush commands, 0 plugin
types, config schema for `breadcrumb_menu.settings`.

- **Pick which menus supply titles / set it via drush or PHP** → [configure/menus.md](configure/menus.md)
- **The permission that gates the settings form** → [permissions/permissions.md](permissions/permissions.md)
- **How the builder works, its service id & priority, cache contexts (priority conflicts)** → [api/breadcrumb-builder.md](api/breadcrumb-builder.md)

Key facts:
- Service `breadcrumb_menu.breadcrumb` (class `Drupal\breadcrumb_menu\BreadcrumbBuilder`),
  tagged `breadcrumb_builder` at **priority 1** — higher than core's
  `system.breadcrumb.default` (priority 0), so it wins for every route (it does not override
  `applies()`, which the parent leaves returning TRUE).
- Extends `Drupal\system\PathBasedBreadcrumbBuilder`: `build()` calls `parent::build()` for
  the access-filtered path trail, then overlays menu titles. It never *adds* links.
- Config object `breadcrumb_menu.settings`, single key `menus` (sequence of menu machine
  names). Fresh install ships `menus: {}` (empty → no substitution); update hook
  `breadcrumb_menu_update_10201` backfills `['main']` on existing sites.
- Settings form field is an `entity_autocomplete` (target_type `menu`, multiple, required).
- Falls back to the page title wherever a breadcrumb link's URL is not in any configured
  menu's active trail.
- `.info.yml` reports the legacy `version: '8.x-1.5'` (branch dir `1.5.x`).
