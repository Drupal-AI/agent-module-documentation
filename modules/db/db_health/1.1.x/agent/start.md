<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Health (db_health) — agent index

Records the **size (bytes) and row count of every database table over time** and charts the
history on an admin report, so you can spot bloated / fast-growing tables. Package `Custom`.
Depends only on core **`system`**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version
**1.1.8** (version dir `1.1.x`). No permissions of its own — everything is gated by core
**`administer site configuration`**.

- **Install, cron collection, the report/settings/logs routes, the size-checker service, schema,
  and the Drush command** → [config/operations.md](config/operations.md)

## What it actually is

- One service: **`db_health.size_checker`** = `DbHealthSizeChecker` (`src/DbHealthSizeChecker.php`),
  constructed with `@database` + `@config.factory`. Its `run()` collects and stores measurements.
- One controller: `DbHealthController` (`src/Controller/DbHealthController.php`) — `list()` (routed)
  and `table($table)` (a method, **not routed**) build a Chart.js render array.
- Two forms: `DbHealthSettingsForm` (collection interval) and `DbHealthLogsForm` (review/delete
  measurement snapshots by timestamp, with a confirm step), in `src/Form/`.
- One Drush command class: `DbHealthCronCommands` (`src/Commands/`) — `db-health:run` / `dh:run`
  invokes `hook_cron` with a force flag.
- No content/config entities, no plugins, no config schema, no `config/install`. It ships two
  **custom database tables** (`hook_schema`) instead: `db_health_sizes`, `db_health_table_names`.

## Routes (all `_permission: administer site configuration`)

- `db_health.list` — `GET /admin/reports/db-health` → `DbHealthController::list` (the report/chart).
- `db_health.settings` — `/admin/reports/db-health/settings` → `DbHealthSettingsForm` (interval).
- `db_health.logs` — `/admin/reports/db-health/logs` → `DbHealthLogsForm` (delete snapshots).

Menu links under **Reports** (`system.admin_reports`); local tasks tab the three together.

## How collection works (from source)

- `hook_cron()` (`db_health.module`) runs `size_checker->run()` when
  `time() - state('db_health.last_run') >= config('db_health.settings').interval` (or when forced).
- `run()` branches on `$connection->driver()`: **mysql** uses `SHOW TABLE STATUS` +
  `SELECT COUNT(*)` per table + `information_schema.tables` for the total; **pgsql** uses
  `pg_total_relation_size` / `pg_stat_user_tables`; any other driver **throws**. Table names come
  from the DB catalog (not from request input). Each table → a row in `db_health_sizes`
  (`table_id`, `size`, `count`, `timestamp`); the whole DB is stored as pseudo-table **`db`**.
- Tables measured before but now gone are logged with size/count `0`.

## Config & state

- Config object **`db_health.settings`**, single key `interval` (seconds). `hook_install` seeds
  `86400` (daily) and runs one immediate collection. No config schema ships.
- State key `db_health.last_run` (Unix timestamp of the last collection).

## Libraries

- `db_health/db_health.chartjs` loads **Chart.js from `cdn.jsdelivr.net`** (external);
  `db_health/db_health.chart` adds `js/chart.js` + `css/chart.css` and depends on it. Attached by
  the controller, which also passes `chart_data` via `drupalSettings`.

## Notes / caveats

- `provides_config_schema` is **false** (no `config/schema/`); the stub's earlier `true` was wrong.
- The report/settings/logs pages are strictly admin-gated — keep them so; they surface operational
  DB metadata (table names, sizes, counts).
