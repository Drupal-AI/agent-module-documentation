<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Dashboards (varbase_dashboards) — agent index

Layer on top of the contrib **Dashboard** module that builds an admin dashboard with core
**Layout Builder**. It ships block plugins, a custom `VarbaseDashboard` widget plugin type, a
default `dashboard` layout, and a set of Views — all provisioned by an install **recipe**.
Package `Varbase`. `core_version_requirement: ~11.4.0`. License GPL-2.0-or-later. Version 2.x
(installed 2.0.3).

- **Blocks, the VarbaseDashboard plugin type, and how they render** →
  [plugins/blocks-and-widgets.md](plugins/blocks-and-widgets.md)
- **Permissions, the install recipe, Views, the default dashboard config** →
  [config/permissions-and-recipe.md](config/permissions-and-recipe.md)

## Dependencies (composer.json `require`, minus core)

- `drupal/dashboard: ~2` — provides the `dashboard` config entity, its routes and access.
- `drupal/layout_builder_restrictions: ~3` — limits blocks/layouts allowed on the dashboard.
- `drupal/statistics: ~1.0.0`.
- Runtime config also pulls in core `layout_builder`, `layout_discovery`, `views`; the recipe
  additionally installs `content_moderation`.
- `info.yml` declares **no** `dependencies:` key — enforcement is via composer + the recipe.

## What it actually provides

- **Plugin type** `VarbaseDashboard` (manager `plugin.manager.varbase_dashboard`, base dir
  `src/Plugin/VarbaseDashboard`, interface `VarbaseDashboardInterface`, base
  `VarbaseDashboardBase`, annotation `@VarbaseDashboard`, alter hook `varbase_dashboard_info`).
  One implementation ships: **`varbase_add_content_menu`** (`AddContentMenu`).
- **Block plugins** (`src/Plugin/Block/`): `varbase_dashboard_user` (welcome block),
  `varbase_content_overview` (My Site Overview counts), and `dashboards_block` — a *derived*
  block (`VarbaseDashboardBlock` + deriver `Derivative/VarbaseDashboardBlock`) that exposes each
  `VarbaseDashboard` widget as a placeable block (`dashboards_block:dashboard:<id>`).
- **Services** (`varbase_dashboards.services.yml`): `plugin.manager.varbase_dashboard`,
  `dashboard.cache` (a `dashboard` cache bin), and the hook class `VarbaseDashboardsHooks`.
- **Hooks** (`src/Hook/VarbaseDashboardsHooks.php`, attribute-based): `page_attachments`
  (attaches CSS on dashboard routes), `theme` / `theme_registry_alter` (Gin/Claro layout
  templates + `varbase_dashboards_admin_list` theme), `preprocess_varbase_dashboards_admin_list`.
- **10 permissions** (`varbase_dashboards.permissions.yml`) consumed by the recipe's Views.
- **No routes, no controllers, no forms, no Drush, no config schema.** All UI is reached through
  the Dashboard module's routes and Layout Builder.
- **Library** `varbase_dashboards/style` (one theme CSS file). `hook_install` runs the default
  recipe; `hook_update_20001` adds a Dashboard block to the Navigation sidebar.

## Security-relevant shape (public, non-sensitive)

- The module defines **no routes of its own**; dashboard view/edit access is enforced by the
  Dashboard module (`view dashboard <id>` / `administer dashboard`) and each Views block carries
  its own `type: perm` access. Blocks are placed inside that access-gated dashboard.
- `VarbaseContentOverview` runs count queries with **bound `:type` placeholders** (no string
  concatenation). Output flows through `Link`/`Url`/`formatPlural`; the only interpolated labels
  are admin-defined node-type names.
- `AddContentMenu` filters listed content types through core `createAccess()` per bundle.
