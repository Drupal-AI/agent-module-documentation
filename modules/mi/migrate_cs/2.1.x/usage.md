Migrate Cron Scheduler runs Drupal migrations automatically on cron, with a per-migration on/off toggle, a per-migration interval (seconds), and a per-migration mode (normal / update / delete). Unlike a direct `MigrateExecutable` runner, it invokes `drush migrate:import` as a subprocess, so cron must be triggered through Drush (e.g. `drush core:cron`).

---

The module exposes every discovered migration (from `plugin.manager.migration`) on a settings form at `/admin/config/system/migrate-cs` (route `migrate_cs.admin_settings_form`, gated by the core `administer site configuration` permission). For each migration you can enable "Run at cron", set an interval in seconds, and pick a mode: Normal, Update (adds `--update`), or Delete (adds `--sync` when `migrate_tools` is installed, otherwise `--delete`). Settings are saved to the `migrate_cs.options` config object as flat keys `<migration_id>_cs`, `<migration_id>_interval`, and `<migration_id>_type`. On each `hook_cron` run the module first checks that a Drush container is available — if not it logs a notice and does nothing. Otherwise it iterates all migrations; for any with `_cs` enabled it compares `now - last_run` (stored in state `migrate_cs.last_run.<id>`) against the interval and, if due and the migration is IDLE, launches `drush migrate:import <id> [flags]` via the Drush process runner. `last_run` is only updated when the subprocess succeeds; a failed run is logged and the migration is reset to IDLE. Non-idle migrations are skipped with a warning. It depends only on `migrate`; the migrations themselves are defined elsewhere (e.g. `migrate_plus` config entities or module-provided plugins). There is no config schema shipped and no permissions of its own.

---

- Import an external feed (JSON/XML/CSV) into content on a schedule via a migrate_plus migration.
- Keep a set of nodes in sync with a remote source by running its migration every cron.
- Run different migrations at different cadences (e.g. products hourly, categories daily).
- Automate a recurring data import without writing a custom cron hook or Drush wrapper.
- Set a per-migration interval in seconds to throttle how often a heavy migration runs.
- Force a migration to run on every cron by leaving the interval empty or below the cron interval.
- Re-import previously migrated rows by choosing the Update mode (`--update`) for a migration.
- Remove destination records dropped from the source by choosing the Delete mode (`--sync`/`--delete`).
- Let `migrate_tools` (if installed) take over the flag so Delete becomes `--sync` automatically.
- Enable/disable scheduled runs per migration from a single settings screen.
- Pause a scheduled migration temporarily by unchecking "Run at cron" without deleting its config.
- Schedule migrations that back a search index or aggregated dataset to refresh regularly.
- Keep taxonomy or reference data imported from an upstream system current.
- Drive incremental content ingestion for a headless/decoupled source.
- Stagger multiple heavy imports by giving each a distinct interval.
- Automate periodic re-import of remotely-hosted price or inventory lists.
- Run scheduled imports only in environments where cron is driven by Drush (avoids double-running under web cron).
- Skip a migration that is mid-run instead of colliding with it, since non-idle migrations are passed over.
- Recover automatically from a failed scheduled run, which resets the migration to IDLE for the next tick.
- Coordinate scheduled imports alongside other cron tasks without extra infrastructure.
- Turn a one-off migration into a continuously-updating integration by giving it an interval and mode.
