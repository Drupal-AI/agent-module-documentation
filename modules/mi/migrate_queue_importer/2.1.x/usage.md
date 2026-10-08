<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migration queue importer runs Migrate API migrations automatically on cron: you create `cron_migration` config entities that reference a migration and an interval, and each cron run queues the due migrations (and their dependencies) for import via the Queue API.

---

The module defines a `cron_migration` config entity (one per scheduled migration) with a referenced **migration** plugin id, an **interval** (`time`, in seconds), an active **status**, and three per-migration flags — **update**, **sync**, and **ignore_dependencies**. On every cron run `hook_cron()` loads all *active* `cron_migration` entities; for each it checks the migration's last-imported timestamp (from the `migrate_last_imported` key/value store) against the interval, and if enough time has passed it pushes an item onto the `migrations_importer` queue (unless `ignore_dependencies` is off, in which case required dependency migrations are queued first, recursively). A `migrations_importer` QueueWorker plugin (cron time budget 30s) then processes each item by running `MigrateExecutable::import()` from Migrate Tools, honouring the queued `update` (re-import/prepareUpdate), `sync`, and `ignore` (clear requirements) flags. To avoid timeouts it deliberately skips scheduling when cron is triggered from the *system cron settings* form. The `cron_migration` entities are exportable configuration, so schedules can be deployed between environments or isolated with Config Split. Administration is a simple UI at `/admin/config/migrate_queue_importer/cron_migration` (create/edit/delete plus enable/disable actions), gated by the single `administer cron migrations` permission. It requires `migrate_tools` and `migrate_plus` (and core Migrate). Note the module has no `configure` key in its info.yml (`configure: null`), so it is reached via the *Configuration → Development* menu link rather than the Extend "Configure" button.

---

- Import a migration automatically on a schedule without running drush by hand.
- Refresh content from an external feed every N seconds/minutes/hours via cron.
- Keep an imported dataset in sync with a source by scheduling periodic re-imports.
- Queue several migrations to run over successive cron runs instead of all at once.
- Run a migration and its required dependency migrations in the correct order automatically.
- Re-import changed rows periodically by enabling the `update` flag on a cron migration.
- Remove destination items no longer in the source by enabling the `sync` flag.
- Skip dependency checking for a standalone migration with `ignore_dependencies`.
- Deploy migration schedules between environments as exportable `cron_migration` config.
- Isolate environment-specific scheduled migrations using Config Split.
- Pause a scheduled migration by disabling its `cron_migration` entity (enable/disable action).
- Set a long interval so an expensive migration only runs occasionally.
- Set a zero/short interval so a migration runs on essentially every cron run.
- Stagger many migrations by giving each its own interval.
- Batch large imports across cron runs using the Queue API worker (30s per-run budget).
- Trigger scheduled imports from a real cron job (crontab/`drush cron`) rather than the UI.
- Avoid import timeouts by keeping migrations off the interactive system-cron form.
- Automate nightly content ingestion from a JSON/XML/CSV source via migrate_plus source plugins.
- Centralise all scheduled migrations in one admin screen for site operators.
- Log when migrations are scheduled and when there is nothing to import (`migrate_queue_importer` logger).
- Grant a limited operator role the `administer cron migrations` permission to manage schedules.
- Programmatically create `cron_migration` entities as part of a deployment recipe.
- Combine `update` + `sync` to fully reconcile a destination with its source on a schedule.
- Schedule a migration group by creating a `cron_migration` for each migration in it.
- Reduce manual maintenance for recurring imports (price lists, catalogs, event feeds).
