<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cleaner (cleaner) — agent index

Scheduled site housekeeping. `hook_cron` (`cleaner_cron()`) dispatches the `cleaner.run`
event on a configured interval; five event subscribers each self-gate on a config flag and
do the work: truncate cache tables, truncate admin-listed extra tables, MySQL `OPTIMIZE`,
delete expired sessions, truncate the `watchdog` table. All actions are logged to the
`cleaner` logger channel. No module dependencies (uses `dblog` opportunistically). PHP >= 8.1,
core `^10 || ^11`. The module does nothing until you enable individual functions.

- Settings route: `cleaner.settings` → `/admin/config/system/cleaner`, permission
  `administer site configuration`. No permissions, drush commands, or plugin types of its own.
- Newest release on this branch is `3.0.0-alpha1` (no stable yet).

What you'd do:
- **Enable/schedule the cleanup functions (interval, cache, tables, sessions, watchdog, optimize)** → [configure/settings.md](configure/settings.md)
- **Subscribe your own code to the cleanup run** → [events/cleaner-run.md](events/cleaner-run.md)

Key facts:
- Config object: `cleaner.settings`. Keys: `cleaner_cron` (int seconds, `0`=every cron run),
  `cleaner_last_cron` (int, internal), `cleaner_clear_cache` (bool),
  `cleaner_additional_tables` (string, comma-separated table names),
  `cleaner_empty_watchdog` (bool), `cleaner_clean_sessions` (bool),
  `cleaner_optimize_db` (int: `0` no, `1` yes, `2` local-only).
- Event: `Drupal\cleaner\Event\CleanerRunEvent::CLEANER_RUN` = `'cleaner.run'`.
- Form: `Drupal\cleaner\Form\CleanerSettingsForm` (`cleaner_settings_form`).
- Service ids: `cleaner.cache_clear_subscriber`, `cleaner.tables_clear_subscriber`,
  `cleaner.mysql_optimization_subscriber`, `cleaner.session_clear_subscriber`,
  `cleaner.watchdog_clear_subscriber`.
- Logger channel: `cleaner`.
