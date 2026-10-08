<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes List (routes_list) — agent index

Developer/audit aid. Adds one admin **report listing every registered route** at
`/admin/reports/routes-list`, grouped by providing module, showing path, route name, and a
plain-language **access rule** per route. Installed version **8.x-6.3** (`version` dir `8.x-6.x`).

- **Package:** Development. **Core:** `^8 || ^9 || ^10 || ^11`. **License:** GPL-2.0-or-later.
- **Dependencies:** none beyond core (optional Views integration uses core `views`).
- **Permission:** `access routes list` (`routes_list.permissions.yml`).
- **Route:** `routes_list.report` → `/admin/reports/routes-list`, `_admin_route: TRUE`, controller
  `\Drupal\routes_list\Controller\RoutesListController::report` (`routes_list.routing.yml`).
- **Menu link:** `routes_list.report` under `system.admin_reports` (`routes_list.links.menu.yml`).
- **Library:** `routes_list/routes_list.report` (theme CSS `css/routes_list.css`).
- **Config:** no settings form, no config entities, no config schema, no install config.
- **Services / plugins:** none defined; controller consumes core services (see below).
- **Views:** `hook_views_data()` in `routes_list.module` registers a `router` base table
  (Name, Path fields/filters/sorts).

Solution docs:
- [The routes-list report page](pages/routes-list.md) — route, permission, controller, access-rule
  classification, rendering.
- [Views integration](api/views-integration.md) — the `router` base table from `hook_views_data()`.
