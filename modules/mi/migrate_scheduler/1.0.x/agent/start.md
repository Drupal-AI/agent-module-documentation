<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Scheduler (migrate_scheduler) — agent index

Runs named migrations on a time interval via `hook_cron()`. No UI, routes, permissions,
services, plugins, Drush, or config schema — the whole module is one cron hook. Depends on
core `migrate`. Configured entirely in `settings.php`.

- **The `settings.php` config array, per-migration options, and cron mechanics** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config source: `$config['migrate_scheduler']['migrations']` (a map of migration id →
  `{time, update?, sync?}`). No `config/install`, no editable UI.
- Per-migration next-run time stored in State as `"{migration_id}_next_execution"`.
- Each due run forces migration status to `IDLE`, then `MigrateExecutable::import()`.
- Effective schedule granularity = how often cron runs.
- Behaviour is driven only by `settings.php` config; no routes or low-privilege triggers.
