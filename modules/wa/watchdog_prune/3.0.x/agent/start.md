<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog Prune — agent index

Deletes rows from the core `watchdog` (dblog) table on **cron** based on a global age threshold and
optional per-log-type age rules. Settings form only; no Drush, no plugins, no config schema, no
default config (the config object appears when you first save the form).

- **Settings keys, the config form, cron prune logic, and the dblog prerequisite** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `watchdog_prune.settings`, two keys:
  `watchdog_prune_age` (global "older than", default `-18 MONTHS`) and
  `watchdog_prune_age_type` (newline-separated `type|age` rules, e.g. `php|-1 MONTH`).
- Configure route `watchdog_prune.watchdog_prune_settings` → `/admin/config/development/watchdog-prune`,
  permission `administer watchdog prune`.
- Pruning runs only in `watchdog_prune_cron()`; ages parsed with `strtotime()`. Requires core dblog
  "Database log messages to keep" (`dblog.settings:row_limit`) = **All** (`0`).
