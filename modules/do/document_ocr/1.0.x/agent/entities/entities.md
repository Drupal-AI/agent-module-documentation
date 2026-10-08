<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities

Five entity types, all with `admin_permission = "administer document ocr"`. Three config entities
define the wiring; two content entities hold jobs and results.

## Config entities

### `document_ocr_mapping` (`\Drupal\document_ocr\Entity\Mapping`)
The central "recipe": binds a source field holding files to a processor and a destination bundle,
and maps extracted properties to destination fields. `config_prefix: mapping`. Exported keys:
`id`, `label`, `field_selector`, `destination_bundle`, `settings`, `processor`, `mapping`.
- `field_selector` = `{entity_type_id, bundle, field}` — which source entity/bundle/file-field to
  watch (`Process::matchDocumentMapping()` queries on `field_selector.entity_type_id` +
  `.bundle`).
- `destination_bundle` = `{entity_type_id, bundle}` — where extracted data is written.
- `settings` = per-mapping overrides (`realtime_processing`, `process_update`,
  `delete_destination`; mirror the global settings object).
- `processor` = a `document_ocr_processor` entity id (`getProcessorReference()` loads it).
- `mapping` = per-destination-field rows `{property, transformer, custom_value}`.
- Has a `status` (enabled/disabled) toggled by `HelperController::enable/disable`; `isActive()`.
- Form handlers: edit, settings, mapping, process, template_file, delete (see routing).

### `document_ocr_processor` (`\Drupal\document_ocr\Entity\Processor`)
An instance of a processor plugin with stored credentials/config. `config_prefix: processor`.
Exported: `id`, `label`, `description`, `credentials`, `configuration`, `processor` (plugin id).
`getProcessorPlugin()` instantiates the plugin via the manager.

### `document_ocr_transformer` (`\Drupal\document_ocr\Entity\Transformer`)
An instance of a transformer plugin. `config_prefix: transformer`. Exported: `id`, `label`,
`description`, `credentials`, `configuration`, `transformer` (plugin id). `getTransformerPlugin()`
instantiates it. One default entity `default` (plugin `basic`) is installed.

Schema for all three (plus the settings object) is in `config/schema/document_ocr.schema.yml`.

## Content entities

### `document_ocr_task` (`\Drupal\document_ocr\Entity\Task`)
One processing job per file. `base_table: document_ocr_task`. Base fields include
`document_ocr_mapping` (ref), `processor`, source refs (`source_entity_type_id`, `source_bundle`,
`source_entity_id`, `source_entity_revision_id`), `field_name`, `file` (file ref), `file_details`
(JSON), destination refs, `status` (int), `attempts`, `last_attempt`, `data` (JSON).
Status constants (`DocumentOcrInterface`): `INIT=1`, `PENDING=2`, `PROCESSED=3`, `FAILED=4`, with
`setPending()/setProcessed()/setFailed()/setInitiated()`, `attempt()`, `restart()`. Has a
`views_data` handler (`Entity\ViewsData\Task`) — the installed `views.view.document_ocr` lists
tasks with custom Views field plugins (`src/Plugin/views/field/`: Source, Destination, File,
Status). `getTaskStatus(TRUE)` renders a status marker via `Markup::create` from the internal
integer status + a translated label (no user text).

### `document_ocr_data` (`\Drupal\document_ocr\Entity\Data`)
Optional store of the raw processor response as JSON (used when a processor
`supports store_json`). Installed via `hook_update_10000` (`document_ocr.install`). `base_table:
document_ocr_data`. Base fields: `file` (ref), `entity_type_id`, `bundle`, `entity_id`, `data`
(JSON string via `setData()/getData()`).

## Cleanup

`Process::deleteEntity()` (from `hook_entity_delete`) removes related tasks and JSON data when a
source file, source entity, destination entity, processor or mapping is deleted; if the mapping's
`delete_destination` setting is on, deleting the file also deletes the imported destination entity.
