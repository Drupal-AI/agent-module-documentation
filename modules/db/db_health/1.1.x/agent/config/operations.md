<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Health — operations (install, cron, routes, service, schema, Drush)

Everything needed to install, configure, and operate `db_health`. Cite paths as
`web/modules/contrib/db_health/…`.

## Install / enable

- `composer require drupal/db_health` then `drush en db_health`. No non-core dependencies (only
  core `system`). Core `^9 || ^10 || ^11`.
- `hook_install()` (`db_health.install`) sets `db_health.settings:interval = 86400` (daily) and
  immediately calls `db_health.size_checker->run()` for a first measurement.
- `hook_schema()` creates two tables (see Schema below). `hook_uninstall()` deletes the config
  object and **drops both tables** (`db_health_sizes`, `db_health_table_names`).

## Configuration

- Config object: **`db_health.settings`**, one key `interval` (integer seconds). No config schema
  ships (`config/schema/` absent), so it is untyped config.
- Settings form `DbHealthSettingsForm` (`src/Form/DbHealthSettingsForm.php`, form id
  `db_health_settings_form`, route `db_health.settings`,
  `/admin/reports/db-health/settings`). A `select` of preset intervals: 300, 600, 900, 1800, 3600,
  10800, 21600, 43200, 86400, 604800, 1209600, 2592000 seconds (5 min → 1 month). Default shown is
  the stored value or `43200`. It also renders a warning that collection depends on Drupal cron
  running frequently enough (links to `system.cron_settings`). `submitForm()` saves `interval`.

## Routes & permissions

All three route requirements are `_permission: 'administer site configuration'` (`db_health.routing.yml`):

| Route | Path | Handler |
|---|---|---|
| `db_health.list` | `/admin/reports/db-health` | `DbHealthController::list` |
| `db_health.settings` | `/admin/reports/db-health/settings` | `DbHealthSettingsForm` |
| `db_health.logs` | `/admin/reports/db-health/logs` | `DbHealthLogsForm` |

Menu links (`db_health.links.menu.yml`) place the report under **Reports**
(`system.admin_reports`) with Settings and Logs as children; local tasks
(`db_health.links.task.yml`) render them as tabs.

## The size checker service

`db_health.size_checker` → `DbHealthSizeChecker` (`src/DbHealthSizeChecker.php`), args
`['@database', '@config.factory']`. Key methods:

- `run(): void` — the collector. Reads `$connection->driver()`:
  - **mysql**: `SHOW TABLE STATUS` gives each table; per-table `size = Data_length + Index_length`,
    `count = SELECT COUNT(*) FROM {<name>}`; total DB size + rows from `information_schema.tables`
    filtered by the connection's database name (bound `:schema` placeholder).
  - **pgsql**: one query over `pg_class` / `pg_namespace` / `pg_stat_user_tables` for size
    (`pg_total_relation_size`) and `n_live_tup` row counts (`nspname = 'public'`); total via
    `SUM(pg_total_relation_size(...))` and `SUM(n_live_tup)`.
  - any other driver → `throw new \Exception('Unsupported database driver: ' . $driver)`.
  - Skips its own bookkeeping tables (`db_health_sizes`, `db_health_table_names`) and the reserved
    name `db`; inserts one `db_health_sizes` row per table with `table_id`, `size`, `count`,
    `timestamp = time()`. Tables previously seen but now absent are inserted with `size`/`count` 0.
  - The full DB is recorded under the pseudo-table name **`db`**.
  - Table names are resolved to ids via private `getOrCreateTableId($name)` (SELECT then INSERT into
    `db_health_table_names`). Names originate from the DB catalog, not request input.
- `list()` — joins `db_health_sizes` to `db_health_table_names`, returns size/timestamp/table_name
  ordered by timestamp ASC (helper; the controller does its own query for rendering).
- private `getTables()` — distinct measured table names.

## Cron

`db_health_cron($bypass = FALSE)` (`db_health.module`): runs `size_checker->run()` and updates
state `db_health.last_run` only when `time() - last_run >= interval` (or `$bypass` is TRUE). Wire
site cron (Drush `drush cron`, or external cron) frequently enough for your chosen interval.

## Drush

`DbHealthCronCommands` (`src/Commands/DbHealthCronCommands.php`, registered in
`drush.services.yml` as `db_health.cron`, arg `@module_handler`):

- **`db-health:run`** (alias **`dh:run`**) — calls `moduleHandler->invoke('db_health', 'cron', [TRUE])`,
  i.e. forces an immediate collection regardless of the interval, and prints start/done lines.

## The report page & charts

`DbHealthController::list()` (`src/Controller/DbHealthController.php`) selects size/timestamp/count +
table_name (join), sorts by size DESC in PHP, and returns a `#theme => 'db_health_table_chart'`
render array (template `templates/db-health-table-chart.html.twig`, registered via `hook_theme`),
attaching library `db_health/db_health.chart` and passing the rows through `drupalSettings.db_health.chart_data`.
`table($table)` builds the same for a single table (parameterized `condition('t.table_name', $table)`,
`range(0,100)`) but has **no route** — it is not reachable via the UI as shipped. Chart.js is loaded
externally (`db_health.chartjs` → `cdn.jsdelivr.net`); `js/chart.js` renders it.

## Logs management

`DbHealthLogsForm` (`src/Form/DbHealthLogsForm.php`, form id `db_health_manage_logs_form`, route
`db_health.logs`): lists distinct `timestamp` values from `db_health_sizes` as checkboxes; selecting
some and submitting stores them in the private tempstore (`db_health` collection) and rebuilds into a
**confirmation step**; confirming deletes all `db_health_sizes` rows whose `timestamp` is IN the
selected set (`Cancel` clears the selection). Standard `FormBase` (core CSRF applies).

## Schema (hook_schema)

- **`db_health_sizes`** — `id` (serial PK), `table_id` (int, FK to names), `size` (numeric(20,0)),
  `count` (int), `timestamp` (int); index `table_timestamp` on `(table_id, timestamp)`.
- **`db_health_table_names`** — `id` (serial PK), `table_name` (varchar 255, unique key
  `table_name_unique`).
- Update hooks: `db_health_update_8001` normalizes the old inline `table_name` column into
  `db_health_table_names` + `table_id`; `db_health_update_8002` adds the `count` column.
