<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Cleanups — configuration, cron mechanism & manual trigger

Source: `db_cleanups.module`, `src/Form/DbCleanupSettingsForm.php`, `db_cleanups.routing.yml`,
`db_cleanups.links.menu.yml`.

## Install / enable

```
drush en db_cleanups -y
```

No dependencies beyond Drupal core, no Composer requirements, no external libraries. After enabling,
configure it before relying on cron (defaults apply even with no saved config).

## Configuration form

- Route `db_cleanups.settings` → `/admin/config/development/db-cleanup`
  (`_permission: 'administer site configuration'`). Menu link under Configuration → Development.
- Form `DbCleanupSettingsForm` (extends `ConfigFormBase`), form id `db_cleanups_settings_form`, editable
  config object **`db_cleanups.settings`**.

Config keys (no config schema ships, so these are untyped):

| Key                | Type   | Default | Meaning |
|--------------------|--------|---------|---------|
| `watchdog_interval`| int    | `1`     | Hours between `watchdog` truncations. `#min => 1`. |
| `cache_interval`   | int    | `8`     | Hours between `cache_*` truncations. `#min => 1`. |
| `optimize_tables`  | bool   | `TRUE`  | Run `OPTIMIZE TABLE` after each truncation. |

`submitForm()` saves the three values and shows "Settings saved successfully."

Example export of `db_cleanups.settings`:

```yaml
watchdog_interval: 1
cache_interval: 8
optimize_tables: true
```

## Cron mechanism (`db_cleanups_cron`)

On every cron run:

1. Load `db_cleanups.settings`; compute `watchdog_interval * 3600` and `cache_interval * 3600` seconds;
   read `optimize_tables`.
2. `now = \Drupal::time()->getRequestTime()`.
3. If `now - state('db_cleanups.last_watchdog_cleanup', 0) > watchdog_interval_seconds` →
   `db_cleanups_clear_watchdog($optimize)`, set the State timestamp, log a notice.
4. Same pattern for `db_cleanups.last_cache_cleanup` → `db_cleanups_clear_cache_tables($optimize)`.

Last-run times live in **State** (`\Drupal::state()`), not config — so they are not exported and reset
if State is cleared. Interval accuracy is bounded by how often cron actually runs.

## Cleanup functions

- `db_cleanups_clear_watchdog($optimize = FALSE)` — `Database::getConnection()->truncate('watchdog')->execute()`;
  if `$optimize`, `OPTIMIZE TABLE watchdog`. try/catch logs failures via the `db_cleanups` logger channel.
- `db_cleanups_clear_cache_tables($optimize = FALSE)` — `$connection->query("SHOW TABLES LIKE 'cache_%'")->fetchCol()`,
  then for each table `truncate($table)->execute()` and optionally `OPTIMIZE TABLE {$table}`. The table list
  is derived from the database itself (not from request or config input). Per-table failures are caught and
  logged; the loop continues.

Both are plain module functions (procedural), callable from cron and from the form.

## Manual trigger ("Run Cleanup Now")

- The form's `manual_cleanup` submit button (`#submit => ['::runCleanupNow']`) runs, independent of the
  save handler and intervals.
- `runCleanupNow()`: reads `optimize_tables`, records `getDatabaseSizeMB()` before, calls
  `db_cleanups_clear_watchdog()` then `db_cleanups_clear_cache_tables()`, records size after, computes
  `saved = max(0, before - after)`, and prints status messages including a size-before / size-after /
  space-saved summary.
- `getDatabaseSizeMB()` sums `data_length + index_length` from `information_schema.TABLES` for the current
  schema, using a **parameterized** `:schema` bound to the connection's own database name.

## Operating notes

- Truncating `watchdog` erases all Database Logging history — avoid short intervals if you rely on dblog
  for incident review; consider forwarding logs elsewhere.
- Truncating `cache_*` forces a full cache rebuild (transient slowdown after each run).
- MySQL/MariaDB-focused SQL (`SHOW TABLES LIKE`, `OPTIMIZE TABLE`); other backends may not support the
  optimize step.
