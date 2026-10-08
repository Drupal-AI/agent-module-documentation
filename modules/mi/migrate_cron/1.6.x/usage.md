Migrate Cron runs Drupal migrations automatically on cron, with a per-migration on/off toggle and a per-migration time interval configured from one admin form. It is a thin scheduler on top of core Migrate and Migrate Plus.

---

The module exposes every discovered migration (from `plugin.manager.migration`) on a settings form at `/admin/config/system/migrate-cron` (route `migrate_cron.admin_settings_form`, gated by the core `administer site configuration` permission). For each migration you can enable "Run at cron", set an interval in seconds, and optionally check "Don't update previously migrated entities". Settings are saved to the `migrate_cron.settings` config object as flat keys `<migration_id>_cron`, `<migration_id>_interval`, and `<migration_id>_skip_update`. On each `hook_cron` run the module iterates all migrations; for any with `_cron` enabled it compares `now - last_run` (stored in state `migrate_cron.last_run.<id>`) against the interval and, if due, resets the migration to IDLE, records the new run time, optionally calls `getIdMap()->prepareUpdate()` (unless skip-update is set), then builds a `MigrateExecutable` and calls `import()`. It depends on `migrate` and `migrate_plus`; migrations themselves are defined elsewhere (e.g. `migrate_plus` config entities or module-provided plugins). There is no config schema shipped and no permissions of its own.

---

- Import an external feed (JSON/XML/CSV) into content on a schedule via a migrate_plus migration.
- Keep a set of nodes in sync with a remote source by running its migration every cron.
- Run different migrations at different cadences (e.g. products hourly, categories daily).
- Automate a recurring data import without writing a custom cron hook or Drush wrapper.
- Set a per-migration interval in seconds to throttle how often a heavy migration runs.
- Force a migration to run on every cron by leaving the interval empty or below the cron interval.
- Skip re-updating already-migrated entities with the "Don't update" toggle for insert-only syncs.
- Re-run a migration that would otherwise be stuck by auto-resetting its status to IDLE each cycle.
- Refresh imported data periodically (prepareUpdate) so source changes propagate to Drupal.
- Enable/disable scheduled runs per migration from a single settings screen.
- Schedule migrations that back a search index or aggregated dataset to refresh regularly.
- Keep taxonomy or reference data imported from an upstream system current.
- Drive incremental content ingestion for a headless/decoupled source.
- Run migrations on cron in environments where Drush-based cron is triggered by the system scheduler.
- Coordinate scheduled imports alongside other cron tasks without extra infrastructure.
- Turn a one-off migrate_plus migration into a continuously-updating integration.
- Stagger multiple heavy imports by giving each a distinct interval.
- Pause a scheduled migration temporarily by unchecking "Run at cron" without deleting its config.
- Automate periodic re-import of remotely-hosted price or inventory lists.
