<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Logging Time (dblog_time) — agent index

Overrides core **Database Logging (dblog)** cron to prune the `watchdog` table **by elapsed time
instead of by row count**, with optional per-log-type retention windows, and adds a database index
on `watchdog.timestamp`. Version **1.0.4**, core `^10 || ^11`. Depends only on core `dblog`.
No permissions or Drush commands of its own; retention runs on cron.

## What it actually does (confirmed from source)

- **Retention toggle.** `hook_form_system_logging_settings_alter()` (in `dblog_time.module`) adds a
  radio `dblog_limit_type` to `/admin/config/development/logging` (route `system.logging_settings`)
  with options **Row limit** (core default) and **Timespan**, plus a `dblog_timespan` text field and
  a `dblog_timespan_per_type_override` textarea. A custom submit handler saves them to
  `dblog_time.settings` as `limit_type`, `timespan`, `timespan_per_type_override`.
- **Cron replacement.** `hook_module_implements_alter()` unsets **dblog's** `hook_cron`;
  `dblog_time_cron()` calls the `dblog_time.manager` service
  (`Drupal\dblog_time\DatabaseLoggingTimeManager::runCron()`).
- **Pruning logic** (`DatabaseLoggingTimeManager`): only acts when `limit_type === 'timespan'` and
  `strtotime($timespan)` parses; otherwise it `loadInclude('dblog','module')` and calls core
  `dblog_cron()` (row-limit fallback). With no overrides: `DELETE FROM watchdog WHERE timestamp <
  <cutoff>`. With overrides: default delete excludes overridden types (`type NOT IN (...)`), then one
  delete per type at its own cutoff. All conditions use the DB query builder (parameterised).
- **Timespan format.** Any `strtotime()`-compatible string, meant to be relative + negative, e.g.
  `-7 days`. Per-type overrides are `type|-N unit` lines (e.g. `cron|-2 days`), parsed by
  `getPerTypeOverrides()`; unparseable lines/timespans are skipped.
- **Index.** `hook_schema_alter()` + `hook_install()` add index `timestamp` on `watchdog.timestamp`;
  `hook_uninstall()` drops it.

## Config (`dblog_time.settings`, schema in `config/schema/dblog_time.schema.yml`)

| Key | Type | Meaning |
|-----|------|---------|
| `limit_type` | string | `row_limit` (core) or `timespan`. Empty install default → row-limit fallback. |
| `timespan` | string | Default retention window, `strtotime()`-compatible (e.g. `-7 days`). |
| `timespan_per_type_override` | string | Newline list of `type|-N unit` per-type windows. |

Install default: all three empty, so out of the box behaviour is unchanged (core row limit) until an
admin selects **Timespan** and enters a window.

## Caveats

- **Time-based, not count-bounded:** a logging spike can leave a very large `watchdog` table between
  cron runs (the module README flags this risk explicitly). Use per-type overrides to bound noisy types.
- Retention only happens on **cron**; there is no Drush command or admin action to force it.
- Invalid `timespan` silently reverts to core row-limit pruning — no error is surfaced.

See `../usage.md` for use cases and `config/settings.md` for the configuration reference.
