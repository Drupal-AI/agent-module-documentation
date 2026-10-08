<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crouton (crouton) — agent index

A **menu-based breadcrumb builder**. Registers one `breadcrumb_builder` service that derives a
page's breadcrumb trail from the **active trail of a configured menu** instead of the URL path.
No dependencies beyond core. `core_version_requirement: ^10.1 || ^11`, PHP `>=8.1`, license
GPL-2.0-or-later. Version 1.1.2 (doc dir `1.x`).

- **The service, its `applies()`/`build()` logic, all five settings, routes & permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- One tagged service: **`crouton.breadcrumb`** = `\Drupal\crouton\MenuBasedBreadcrumbBuilder`,
  tag `breadcrumb_builder` priority **2000** (`crouton.services.yml`). Implements core
  `BreadcrumbBuilderInterface`. Constructor args: `@router.admin_context`, `@config.factory`,
  `@menu.active_trail`, `@plugin.manager.menu.link`.
- One config form: `\Drupal\crouton\Form\SettingsForm` (extends `ConfigFormBase`), route
  **`crouton.settings`** at `/admin/config/crouton`, permission **`administer crouton`**
  (`crouton.routing.yml`, `crouton.permissions.yml`).
- One config object **`crouton.settings`** with schema (`config/schema/crouton.schema.yml`) and
  install defaults (`config/install/crouton.settings.yml`): `menu_name` (string, nullable),
  `prepend_front`, `append_current`, `use_disabled`, `hide_plain_text` (all boolean, default
  `false`).
- One hook in `crouton.module`: `crouton_menu_delete()` clears `menu_name` when the referenced
  menu entity is deleted.
- **No** block, field, formatter, filter, plugin type, Drush command, JS, CSS, or template.

## Mechanism (from source)

- `applies()` returns TRUE only on **non-admin** routes where the current page has an active link
  in the configured menu; a disabled active link applies only if `use_disabled` is on, otherwise
  it defers to the next builder. Adds cache context `route` + the config as a dependency.
- `build()` calls `getActiveTrailLinks()` → `menu.active_trail` `getActiveTrailIds($menu_name)`,
  `array_reverse(array_filter(...))` (root-first), maps each id to a menu link plugin, filters via
  `isMenuLinkApplicable()`, and converts each to a core `Link` with `Link::fromTextAndUrl()`.
- `isMenuLinkApplicable()` drops the active link unless `append_current`, drops disabled links
  unless `use_disabled`, and drops `<nolink>` items when `hide_plain_text`. The active link's Url
  gets `attributes.aria-current = 'page'`. `addFrontLink()` unshifts a `<front>` "Home" link when
  `prepend_front`.
- Link text is the menu item's `getTitle()` rendered through core `Link` (auto-escaped); targets
  come from `getUrlObject()`. No request-supplied input, no external I/O.
