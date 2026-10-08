<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Controller, routes and queries

## Route
`database_dashboard.routing.yml`:
- `database_dashboard.dashboard` → path `/admin/reports/database`, title "Database Dashboard",
  controller `\Drupal\database_dashboard\Controller\DatabaseDashboardController::dashboard`,
  requirement `_permission: 'access database_dashboard'`.

Menu link `database_dashboard.dashboard` (in `.links.menu.yml`) places it under `system.admin_reports`.

## Controller
`src/Controller/DatabaseDashboardController.php` extends `ControllerBase`. It injects the default
`Connection` via `create()`/constructor (used only to read the site DB name), and separately calls
`Database::getConnection('default', 'schema')` for the actual `information_schema` queries.

`dashboard()` builds a `$data` array and returns a render array with `#theme => 'database_dashboard'`,
`#data => $data`, attaches library `database_dashboard/dashboard`, and sets `#cache max-age => 0`.

### Private query methods
- `fetchDatabaseSize($con)` — `SELECT table_schema, SUM(data_length + index_length)/1024/1024/1024
  FROM TABLES WHERE engine='InnoDB' GROUP BY table_schema` → `fetchAllKeyed()` (schema → GB).
- `fetchAndFormatTableSizes($con, $databaseName, $onlyCache = FALSE)` — top-20 tables by
  `data_length + index_length` for `table_schema = :databaseName`; when `$onlyCache` adds
  `AND TABLE_NAME like 'cache%'`. Sizes passed through `formatMbGb()`.
- `fetchTableRows($con, $databaseName, $onlyCache = FALSE)` — top-20 tables by `TABLE_ROWS` for
  the same schema, optional `cache%` filter.
- `formatMbGb($size_mb)` (static) — renders `>= 1000` MB as GB, else MB, `number_format` with comma
  decimal and space thousands separator.

The database name is bound as the parameter `:databaseName`; the `cache%` filter is a fixed literal.
Queries are parameterized — no request input reaches SQL. Results use `fetchAllKeyed()` (first column
= key, second = value), so the `information_schema` column order matters.

## Theming
`.module` defines `hook_theme()` for `database_dashboard` with a `data` variable. Template
`templates/database-dashboard.html.twig` renders the five cards, iterating `data.database_size`,
`data.tables_sizes`, `data.tables_rows`, `data.tables_cache_sizes`, `data.tables_cache_rows`, and
formats numbers with Twig's `number_format`. CSS comes from `css/dashboard.css`
(library `database_dashboard/dashboard`).
