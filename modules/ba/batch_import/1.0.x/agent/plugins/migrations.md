<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Import — writing migration & processor plugins

Two plugin types, both annotation-based (`Drupal\Component\Annotation\Plugin`), each with a
`DefaultPluginManager` subclass in `batch_import.services.yml`.

## `@BatchMigration` plugins (the migrations)

- Manager: `BatchMigrationsPluginManager`, subdir **`Plugin/batch_import/Migrations/`**, interface
  `Plugin\BatchMigrationInterface`, annotation `Annotation\BatchMigration`, alter hook
  `batch_import_migrations_info`, cache bin `batch_import_migrations`.
- Create a class in your module's `src/Plugin/batch_import/Migrations/` extending
  **`Drupal\batch_import\Plugin\BatchMigrationBase`** and override:
  - `source(): array` — return the rows to import (the module ships no source parser; you supply the
    data, e.g. a query via `getConnection($origin)`).
  - `destination(array $data, array $args = [])` — turn one row into a saved entity / result. With
    the `entity` processor, `$args['entity']` is the pre-loaded/created entity.

### Annotation keys (`Annotation\BatchMigration`)

Required: **`id`**, **`name`** (`@Translation`). Optional: `processor` (defaults to `basic`),
`origin` (secondary DB id, injects the matching migration service), `entity_type`
(e.g. `node`/`user`/`taxonomy_term`/`media`/`file`/`paragraph` — injects that service), `entity_id_key`
(e.g. `nid`/`tid`; auto-detected from the entity type if omitted, via `entityIdKey()`), `bundle`
(defaults to `entity_type`), `services` (extra migration-service ids to inject), `dependencies`
(migration ids that must run first — used for form ordering), `hidden` (hide from the form).

### `BatchMigrationBase` behavior

- Constructor injects `entity_type.manager`, `migration_activation`,
  `plugin.manager.batch_migration_processors`, and a computed `$services` array; instantiates the
  processor named by `processor()` (falls back to `basic` if unknown).
- `serviceList()` builds the injected services: always `db_table`, plus the `origin` service and the
  `entity_type` service if set, plus any in the `services` annotation. Each is fetched as
  `batch_import.migration.<id>` and reachable via `service($key)` / `hasService($key)`.
- `processSource()` / `processDestination()` delegate to the processor. Entity helpers
  `getEntity()`, `initEntity()`, `saveEntity()` delegate to the injected `EntityMigrationServiceInterface`
  for `entity_type`; `saveEntity()` also writes a row to the `batch_import` id-map via `db_table`.
- `getConnection($id = null)` calls `Database::setActiveConnection($id ?: origin())` then
  `Database::getConnection()` — use it inside `source()` to read the `origin` database.

## `@BatchMigrationProcessor` plugins (source↔destination glue)

- Manager: `BatchMigrationProcessorsPluginManager`, subdir **`Plugin/batch_import/Processors/`**,
  interface `Plugin\BatchMigrationProcessorInterface`, annotation `Annotation\BatchMigrationProcessor`
  (only key is `id`), alter hook `batch_import_migration_processors_info`.
- Base `Plugin\BatchMigrationProcessorBase`: `processSource()` → `migration->source()`;
  `processDestination()` → `migration->destination($data)`.
- Shipped processors (`Plugin/batch_import/Processors/`):
  - **`basic`** (`BasicMigrationProcessor`) — pass-through, uses the base as-is.
  - **`entity`** (`EntityMigrationProcessor`) — before `destination()`, calls `migration->getEntity()`
    (load-or-create), `initEntity()`, then `destination($data, ['entity' => $entity])`, then
    `saveEntity()`. Use this for entity imports.
- To customize, extend `BatchMigrationProcessorBase`, give it an `id`, and override
  `processSource()` / `processDestination()` (call the migration's `source()`/`destination()`
  inside).

## Migration services (shared logic)

Not plugins. Any class in a module's `src/BatchMigrationServices/` implementing
`MigrationServiceInterface` (typically extending `MigrationServiceBase` or
`EntityMigrationServiceBase`) is auto-registered as `batch_import.migration.<id()>` by
`BatchImportServicePass` (a compiler pass added by `BatchImportServiceProvider`). Override static
`id()` and static `serviceArguments()` (container ids for the constructor). See
[../api/migration-services.md](../api/migration-services.md) for the ones shipped with the module.
