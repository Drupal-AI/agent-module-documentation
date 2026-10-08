<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Scheduler runs named migrations automatically on a time interval via Drupal's cron, optionally applying the equivalent of Migrate's `--update` and `--sync` flags — no admin UI, configured entirely in `settings.php`.

---

The module is a single `hook_cron()` implementation with no UI, routes, permissions, services, or config schema. On every cron run it reads `$config['migrate_scheduler']['migrations']` (a map of migration id → settings you place in `settings.php`), and for each entry compares the current request time against a per-migration `state` value `"{id}_next_execution"`. When the interval has elapsed it records the next run time (`now + time`), instantiates the migration plugin, forces its status to `IDLE` (recovering stuck migrations), optionally calls `prepareUpdate()` on the id map when `update` is set and sets `syncSource` when `sync` is set, then runs `MigrateExecutable::import()`. If `migrate_plus` is installed it also updates that module's `migrate_last_imported` timestamp. Because scheduling is keyed off cron, the effective granularity is however often cron actually runs on the site. Configuration lives only in `settings.php`/`settings.local.php` (the README notes a future plan for an admin UI); each migration entry supports `time` (seconds between runs), `update` (bool), and `sync` (bool).

---

- Re-import a feed/data migration automatically every hour without a manual `drush mim`.
- Keep content in sync with an external source on a recurring schedule via cron.
- Run a migration with the `--update` behaviour on a schedule (re-process previously imported rows).
- Run a migration with the `--sync` behaviour on a schedule (remove destination rows dropped from source).
- Schedule several migrations at different intervals from one config array.
- Refresh imported product/catalog data every 8 hours from a supplier feed.
- Poll a remote API-backed migration every minute for near-real-time updates.
- Automatically recover a migration stuck in a non-IDLE state (status is reset before each run).
- Keep `migrate_plus`'s "last imported" timestamp current for scheduled runs.
- Drive nightly content imports on a cron-only server with no interactive Drush access.
- Stagger heavy migrations across the day to smooth server load.
- Automate incremental content updates without writing a custom cron hook.
- Add scheduling to any existing migrate/migrate_plus migration by id, without changing the migration.
- Configure schedules per environment via `settings.local.php` (e.g. faster intervals in staging).
- Combine update + interval to continuously reconcile changed source records.
- Run a one-line-per-migration schedule for a suite of related migrations.
- Trigger migrations from cron on a headless/decoupled backend.
- Keep taxonomy or user reference data imported from an upstream system fresh.
- Avoid maintaining external crontab entries by using Drupal cron for migration scheduling.
