<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Cleanups (db_cleanups) — agent index

Cron-driven maintenance module that **truncates the `watchdog` (dblog) table and all `cache_*` tables**
on configurable per-task intervals, with an optional `OPTIMIZE TABLE` pass and a manual "Run Cleanup Now"
trigger. Package `Custom`. **No dependencies** (core only), no Composer requirements, no libraries. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.

- **Settings form, config keys, the cron mechanism, the manual trigger, and the cleanup functions** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **`hook_cron()`** in `db_cleanups.module` — reads `db_cleanups.settings`, converts `watchdog_interval`
  (default 1h) and `cache_interval` (default 8h) hours to seconds, and compares `REQUEST_TIME` against
  State keys `db_cleanups.last_watchdog_cleanup` / `db_cleanups.last_cache_cleanup`. When an interval has
  elapsed it runs the matching cleanup, updates the State timestamp, and logs a notice.
- **`db_cleanups_clear_watchdog($optimize)`** — `Database::getConnection()->truncate('watchdog')`, then
  optionally `OPTIMIZE TABLE watchdog`. Wrapped in try/catch → logs errors.
- **`db_cleanups_clear_cache_tables($optimize)`** — discovers tables via `SHOW TABLES LIKE 'cache_%'`
  (`fetchCol()`), truncates each, optionally `OPTIMIZE TABLE {$table}`. Table names come from the DB, not
  from any request/config input.
- **`DbCleanupSettingsForm`** (`src/Form/DbCleanupSettingsForm.php`, extends `ConfigFormBase`) — form id
  `db_cleanups_settings_form`, editable config `db_cleanups.settings`. Three fields (`watchdog_interval`,
  `cache_interval` numbers with `#min => 1`; `optimize_tables` checkbox). A `manual_cleanup` submit button
  routed to `::runCleanupNow` runs both cleanups immediately and reports DB size before/after/saved via
  `getDatabaseSizeMB()` (parameterized `information_schema.TABLES` sum over the current schema).
- **Route** `db_cleanups.settings` → `/admin/config/development/db-cleanup`, `_permission:
  'administer site configuration'`. Menu link `db_cleanups.settings_link` under
  `system.admin_config_development`.
- **No** permissions.yml, services.yml, install file, config/install, config/schema, entities, plugins,
  or Drush commands. State keys (not config) track last-run times.

## Notes

- Destructive by design: truncating `watchdog` discards all logged events; truncating `cache_*` forces a
  cold rebuild. It is an admin-only (`administer site configuration`) maintenance action.
- MySQL/MariaDB-oriented: `SHOW TABLES LIKE` and `OPTIMIZE TABLE` are MySQL-family SQL.
- There is no config schema shipped, so `db_cleanups.settings` values are untyped in the config system.
