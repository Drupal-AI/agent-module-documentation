<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate process plugins

Under `src/Plugin/migrate/process/`. All implement `EntityImportProcessInterface` and use
`EntityImportProcessTrait` (adds a config form so a plugin can be picked and configured on a field mapping;
`getFormStateValue()`, `getConfiguration()`, `defaultConfigurations()`). They are ordinary
`@MigrateProcessPlugin`s and also run in a normal migrate pipeline. `EntityImportProcessManager` discovers
every migrate process plugin implementing `EntityImportProcessInterface` and lists them as options; it
dispatches `ENTITY_IMPORT_PREPARE_MIGRATION_STUB` so a plugin can seed stub config before instantiation.

| id | class | label | key settings |
|---|---|---|---|
| `entity_import_default_value` | `EntityImportDefaultValue` | Default Value | `default_value`, `strict` |
| `entity_import_explode` | `EntityImportExplode` | Explode | `delimiter`, `strict`, `limit` (split a value into a multi-value array) |
| `entity_import_extract` | `EntityImportExtract` | Extract | `index[]` (nested keys), `default` |
| `entity_import_flatten` | `EntityImportFlatten` | Flatten | — (flatten nested value) |
| `entity_import_format_date` | `EntityImportFormatDate` | Format Date | date from/to format conversion |
| `entity_import_machine_name` | `EntityImportMachineName` | Machine Name | transliterate a label to a machine name |
| `entity_import_skip_on_empty` | `EntityImportSkipOnEmpty` | Skip On Empty | `method` (row/process), `message` |
| `entity_import_make_unique_entity_field` | `EntityImportMakeUniqueEntityField` | Unique Entity Field | make a field value unique against existing entities |
| `entity_import_migrate_lookup` | `EntityImportMigrationLookup` | Migrate Lookup | `migration[]`, `no_stub`, `stub_id`, `source_ids[]` (resolve via another migration's ID map) |
| `entity_import_callback` | `EntityImportCallback` | Callback | `callable` — a PHP callable string applied with `call_user_func` |

Notes:

- **`entity_import_callback`** validates the configured string with `is_callable()` (config form and at
  `transform()` time) before invoking it. Configuring field mappings — hence this callable — requires the
  `administer entity import` permission.
- **`entity_import_migrate_lookup`** feeds `EntityImporter::getMigrationLookupDependencies()`: any migration
  named in its `settings.migration` is automatically added as an **optional** migration dependency of the
  importer's derived migration, so the import page runs them in dependency order.
- Each plugin's persisted settings are validated by config schema `entity_import.migrate.process.<id>`.
- The **entity_import_plus** submodule adds three more process plugins (entity lookup, entity generate,
  string replace) — see its own docs.

## How a field mapping becomes a migrate process pipeline

`EntityImporter::getMigrateProcessDefinition($bundle)` iterates the bundle's field mappings; for each it
reads `processing.configuration.plugins` and builds a process list `['plugin' => <id>] + settings`, adding
the `source` (CSV column) only to the **first** plugin so the rest inherit the pipeline value. If a mapping
has no processes, the destination is mapped directly to the source column. The whole definition
(`source`/`process`/`destination`/`migration_dependencies`) is assembled in `getMigrationDefinition()` and
turned into a stub migration via `createStubMigration()`.
