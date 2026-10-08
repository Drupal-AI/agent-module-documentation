<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture: services, entities, deriver, events

## Services (`entity_import.services.yml`)

- **`entity_import.entity_properties`** (`EntityImportEntityProperties`) — args `@config.typed`,
  `@entity_field.manager`. Exposes field/property options for the field-mapping destination selector.
- **`entity_import.source.manager`** (`EntityImportSourceManager`) — args `@plugin.manager.migrate.source`,
  `@plugin.manager.migration`. Lists available source plugins for the importer form.
- **`entity_import.process.manager`** (`EntityImportProcessManager`) — args `@event_dispatcher`,
  `@plugin.manager.migration`, `@plugin.manager.migrate.process`. `getMigrationProcessInfo()` returns
  the `entity_import_*` process plugins (any implementing `EntityImportProcessInterface`) as options +
  instances; `createPluginInstance()` dispatches the stub event then builds the plugin against a stub
  migration.
- **`entity_import.event_subscribers`** (`Subscriber\EntityImportSubscriber`) — on core migrate
  `POST_IMPORT`, calls `runCleanup()` on the source (deletes uploaded CSV files).
- **`entity_import.param_converter`** (`Routing\ParamConverter\MigrationConverter`, arg
  `@plugin.manager.migration`) — resolves the `{migration}` route slug to a migration instance (used by the
  log-delete route).

## Config entities

- **`entity_importer`** (`Entity\EntityImporter` + `EntityImporterInterface`, base
  `EntityImporterConfigEntityBase`) — the importer definition. Route provider
  `Entity\Routing\EntityImporterRouteDefault`; list builder `Controller\EntityImporterList`; forms
  `Form\EntityImporterForm` (add/edit) and `EntityImporterDeleteForm`. Backward-compat getters
  (`getMigrationSource`/`getMigrationEntity`/`exposeImporter`) still read the pre-`update_8103` flat
  properties if present. It assembles migrate definitions (`getMigrationDefinition`,
  `getMigrateSourceDefinition`, `getMigrateProcessDefinition`, `getMigrateDestinationDefinition`,
  `calculateMigrationDependencies`) and creates stub migrations via `createStubMigration()`. On save/delete
  it clears the `cache.discovery_migration` (`migration_plugins`) cache; delete also removes the options
  object and field mappings.
- **`entity_importer_field_mapping`** (`Entity\EntityImporterFieldMapping` + interface) — one CSV-column →
  destination mapping. Getters `name()`, `getSource()`, `getDestination()`, `getImporterType()`,
  `getImporterBundle()`, `getProcessingPlugins()`, `getProcessingConfiguration()`, `hasProcessingPlugin()`.
  List controllers: `EntityImporterFieldMappingList`, plus options form `EntityImporterOptionsForm`
  (unique identifiers). Deletion via `EntityImporterFieldMappingDeleteForm`.

## Migration derivation

`Plugin/migrate/EntityImporterMigrateDeriver` (a `ContainerDeriverInterface`) loops all `entity_importer`
config entities × their bundles and calls `createMigrationInstance($bundle)`, registering a derivative keyed
`"<importer_id>:<bundle>"`. The migration plugin id is therefore `entity_import:<importer>:<bundle>`
(`EntityImporter::getMigrationPluginId()`). This makes every configured importer a first-class, discoverable
core migration (runnable by the UI batch and, in principle, by `drush migrate:import`).

## Forms & batch

`Form\EntityImporterPageImportForm` (extends `EntityImporterBundleFormBase`) builds the upload UI. It
resolves the base migration, walks optional dependencies (`buildMigrationDependencyInfo` →
`buildMigrationExecuteOrder`, reversed), renders each source's import subform, an **Update** checkbox and a
**Download template** link, then on submit assembles batch operations
(`EntityImporterBatchProcess::import($migration, $update, STATUS_IDLE)`). Validation requires at least one
unique identifier. Status/rollback = `EntityImporterStatusForm` / `EntityImporterPageImportActionForm`;
logs = `EntityImporterLogForm` / `EntityImporterLogConfirmDeleteForm`.

## Events

`Event\EntityImportEvents::ENTITY_IMPORT_PREPARE_MIGRATION_STUB` (`entity_import.prepare_migration_stub`)
carries `EntityImportMigrationStubEvent`; subscribers can set stub configuration values before a process
plugin is instantiated (the `entity_import_plus` submodule uses this to give its EntityLookup/EntityGenerate
plugins a valid `destination` and to blank `search`/`replace` for its StrReplace).

## Menu links & param converter

`Plugin/Derivative/EntityImportMenuLinks` derives menu links per exposed importer; `.links.action|menu|task`
YAML wire the Add/collection/tabs. `MigrationConverter` upcasts the `{migration}` route param.
