<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Dashboard (database_dashboard) — agent index

Read-only admin report at `/admin/reports/database` (menu: Reports › Database Dashboard) showing
database size and the largest tables by size/rows, plus a cache-tables breakdown. Version 1.0.2.
Core `^9 || ^10 || ^11`. Depends on core **mysql**.

## What it provides
- **Route** `database_dashboard.dashboard` → `/admin/reports/database`, controller
  `DatabaseDashboardController::dashboard()`, `_permission: 'access database_dashboard'`.
- **Permissions** (declared in `database_dashboard.permissions.yml`): `access mysql_dashboard`
  and `administer mysql_dashboard configuration` (both `restrict access: true`).
- **Theme hook** `database_dashboard` (`hook_theme()` in `.module`) → template
  `templates/database-dashboard.html.twig`.
- **Library** `database_dashboard/dashboard` → `css/dashboard.css`.
- **Menu link** under `system.admin_reports`.
- No config, no entities, no plugins, no services (uses core `database`), no Drush.

## Key mechanism
The controller reads the site DB name from the default connection, then runs `information_schema`
queries over a **second connection keyed `schema`** that the admin must declare in `settings.php`
(`$databases['schema']['default']`). All queries are parameterized (`:databaseName`). Output is
uncached (`max-age = 0`).

## Solution docs
- Install, configure the `schema` connection, and operate the report: [agent/config/settings.md](config/settings.md)
- Route, controller, queries and theming internals: [agent/api/controller.md](api/controller.md)
