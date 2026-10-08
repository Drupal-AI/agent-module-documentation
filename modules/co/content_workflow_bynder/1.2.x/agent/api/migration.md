<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mapping entity, migration generation, import & rollback

## Mapping config entity (`src/Entity/Mapping.php`)
`@ConfigEntityType id = "content_workflow_bynder_mapping"`, config prefix `content_workflow_bynder_mapping`. Exported fields: `id`, `uuid`, `project_id`, `project`, `template_id`, `template_name`, `entity_type`, `content_type`, `content_type_name`, `updated_drupal`, `data` (serialized field-mapping blob), `template`, `migration_definitions` (the generated migration IDs). Legacy getters keep `getGathercontent*()` names (`getGathercontentProjectId()`, `getGathercontentTemplate()`, `getMigrations()`, etc.). `src/MappingLoader.php` and `src/MappingInterface.php` accompany it.

## Dynamic migration definitions (`src/MigrationDefinitionCreator.php`)
Service `content_workflow_bynder.migration_creator` turns a Mapping into one or more `migrate_plus.migration.*` config entities. `BASIC_SCHEMA_CWB_DESTINATION_CONFIG` seeds each definition: source `content_workflow_bynder_migration`, a `process` map built from the mapping's `data`, and destination `cwb_entity`. Media/file/taxonomy/paragraph fields get the corresponding CWB process plugins wired in. The generated migration IDs are stored back on the Mapping's `migration_definitions`.

## Migrate plugins
- **Source** `content_workflow_bynder_migration` (`Plugin/migrate/source/ContentWorkflowBynderMigrateSource`) — requires `projectId`, `templateId`, `fields`, `metatagFields` in config (throws `MigrateException` otherwise). `getItemIds()` pages `client->itemsGet()` for the project/template; `setItemIds()` limits the source to explicit CWB IDs (used by the batch import). `getItems()` calls `client->itemGet($id)` per item and flattens `content` fields; `singleComponent` mode explodes a repeatable component into one row per delta. `prepareRow()` marks rows with file elements as `STATUS_NEEDS_UPDATE` so alt-text changes re-import.
- **Destination** `cwb_entity` (`Plugin/migrate/destination/ContentWorkflowBynderEntity`, extends `EntityContentBase`) with deriver `Plugin/Derivative/MigrateEntity` — one derivative per content entity type.
- **Process** plugins (`Plugin/migrate/process/`): `content_workflow_bynder_get`, `_concat`, `_file` (downloads an asset via `client->downloadFiles()` into a `file` entity, sets alt text), `_media`, `_taxonomy` (matches/creates terms by `contentworkflowbynder_option_ids`), `_reference_revision` (Paragraphs), `_sub_process`, `_migrate_lookup_multiple`.

## Import execution
- `Commands\ContentWorkflowBynderCommands::import()` (or the UI action) selects a Mapping, fetches project items, filters to the mapping's `templateId`, builds one `Import\ImportOptions` per item (`publish`, `createNewRevision`, `newStatus`, `parentMenuItem`) and sets a batch running `content_workflow_bynder_import_process()`.
- `content_workflow_bynder_import_process()` (`.module`) runs each of the mapping's migrations through `content_workflow_bynder\MigrateExecutable` with `setItemIds($cwb_ids)`, passing `import_options` and the `client` into the migration. Failed/ignored rows trigger `rollback()`. Messages are captured via `MigrateMessageCapture` and logged to the `content_workflow_bynder` channel.
- `Import\MenuCreator` builds menu-link hierarchy for imported nodes when a parent menu item is chosen.

## Entity-delete rollback (`.module`)
`hook_entity_delete` / `hook_entity_translation_delete` → `content_workflow_bynder_on_entity_delete()`: looks up `content_workflow_bynder_entity_mapping` rows for the deleted entity (by id/type, optionally langcode), deletes them, and rolls back the tracked migration by `cwb_id` so the source is re-importable. The `cwb_file_id` base field on `file` entities and `contentworkflowbynder_option_ids` on terms let re-imports find previously imported assets/terms instead of duplicating them.
