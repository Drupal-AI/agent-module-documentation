# How it works (mechanism)

DB Maintenance is a cron hook plus a small driver layer. No services are registered in a
`*.services.yml`; the logic lives in static handler classes under `src/Module/`.

## Cron flow (`hook_cron` → `CommonHookHandler::hookCron`)

1. Read request time.
2. `IntervalHandler::isTimeIntervalConfirmed()` — if `use_time_interval` is true and the current
   time is outside `time_interval_start`–`time_interval_end`, **return early** (do nothing).
3. Compare `now - cron_frequency` against the last run (`state: db_maintenance.cron_last_run`,
   nudged back 5 minutes when a time interval is used). Only proceed if enough time elapsed.
4. `DbHandler::optimizeTables()` runs, then stores the new last-run timestamp in state.

## `DbHandler::optimizeTables()`

- Iterates every database connection from `Database::getAllConnectionInfo()`.
- If `all_tables` is true, it lists all base tables for that connection; otherwise it reads
  `table_list.<database_name>` from config.
- For each configured table it switches the active connection, strips the table prefix
  (`PrefixHandler::clearPrefix()`), checks the table exists, then calls the driver's
  `optimizeTable()`. Missing tables are logged as a notice when `write_log` is on.

## Drivers (`DbServerHandlerFactory`)

The factory returns a driver by DB engine:
- **`MySqlHandler`** — `listTables()` = `SHOW FULL TABLES WHERE Table_type = 'BASE TABLE'`;
  `optimizeTable()` = `OPTIMIZE TABLE {table}`.
- **`PgSqlHandler`** — the PostgreSQL equivalent using `VACUUM`.

## Manual "Optimize now"

Route `db_maintenance.optimize_tables_page` → `/db_maintenance` (CSRF-token required) calls
`DefaultController::optimizeTables()`, which runs `DbHandler::optimizeTables()` immediately and
redirects back to the settings form with a status message. The settings form builds this link
with a CSRF token via the `csrf_token` service.

## Things an agent should know

- MySQL **locks** a table for the duration of its `OPTIMIZE TABLE`. Prefer the time-interval
  window on busy sites.
- `table_list` keys are **database names**, not connection keys (`default` connection's DB name).
- The last-run gate is **state**, not config — `drush sset` / `drush sget db_maintenance.cron_last_run`
  to inspect or force a re-run; deleting it makes the next cron run optimize immediately.
- There is no Drush command; drive it via cron, the manual route, or `DbHandler::optimizeTables()`.
