<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Import (batch_import) — agent index

A **developer framework** for running custom content-import migrations through Drupal's **queue +
Batch API**. You write `@BatchMigration` plugin classes (override `source()` / `destination()`);
they appear on an admin form that queues them for cron or runs them in a batch. Inspired by core
Migrate but plain-PHP, class-based. Package `Migration`. **No contrib dependencies.** Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The admin form, permission, route, and how a run executes (queue vs. manual)** →
  [config/form.md](config/form.md)
- **Writing a migration plugin: annotations, base class, processors, services** →
  [plugins/migrations.md](plugins/migrations.md)
- **The built-in migration services (node/user/term/media/file/paragraph + id-map table)** →
  [api/migration-services.md](api/migration-services.md)

## What it actually is

- **Two plugin types**, each with a manager (`batch_import.services.yml`):
  - `batch_migrations` → `BatchMigrationsPluginManager`, scans `Plugin/batch_import/Migrations/`,
    interface `BatchMigrationInterface`, annotation `@BatchMigration`.
  - `batch_migration_processors` → `BatchMigrationProcessorsPluginManager`, scans
    `Plugin/batch_import/Processors/`, annotation `@BatchMigrationProcessor`. Ships two processors:
    `basic` (`BasicMigrationProcessor`) and `entity` (`EntityMigrationProcessor`).
- **One service** `migration_activation` (`MigrationActivationService`) — orchestrates queueing and
  batch execution.
- **Four QueueWorkers** (`Plugin/QueueWorker/`): `batch_import_source_queue` /
  `batch_import_source_manual` (fetch source rows → enqueue per-row items) and
  `batch_import_destination_queue` / `batch_import_destination_manual` (process one row → save an
  entity). The `_queue` variants run on cron (`cron = {"time" = 10}`); the `_manual` variants run
  inside a Batch.
- **A service-provider + compiler pass** (`BatchImportServiceProvider`, `BatchImportServicePass`)
  auto-registers any class under a module's `src/BatchMigrationServices/` that implements
  `MigrationServiceInterface` as a container service `batch_import.migration.<id()>`.
- **One permission** `run batch imports` (`restrict access: true`). **One route** `batch_import.form`
  at `/admin/content/batch-import` (menu under *Content*). **One DB table** `batch_import`
  (`hook_schema`) mapping source id → new entity id/uuid per type/bundle/origin.
- Hook: `batch_import_entity_delete()` removes an entity's id-map row on delete.
- No config schema shipped (the form's `ConfigFormBase` names `batch_import.settings` but stores no
  keys). One CSS-only library `batch_import/import_form`.

## Provided migration services (auto-injected by id)

`db_table` (id-map table, always injected), `node`, `user`, `taxonomy_term`, `media`, `file`,
`paragraph`. A migration also auto-receives the service matching its `entity_type` and its `origin`.
See [api/migration-services.md](api/migration-services.md).

## Operating it

Enable, grant *run batch imports*, write at least one migration plugin in a custom module, then go
to `/admin/content/batch-import`, select migrations, and choose **Queue import for cron** or
**Manually run import**. Details in [config/form.md](config/form.md).
