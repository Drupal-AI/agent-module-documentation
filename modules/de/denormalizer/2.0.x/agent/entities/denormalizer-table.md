<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `denormalizer_table` config entity

`@ConfigEntityType(id="denormalizer_table")` — `src/Entity/DenormalizerTable.php` implements `DenormalizerTableInterface`. `admin_permission = "administer denormalizer"`, `config_prefix = "denormalizer_table"`. Exported keys: `id`, `label`, `status`, `source`, `configuration`. Schema: `denormalizer.denormalizer_table.*` (source-typed via `[%parent.source]`).

## Routes (AdminHtmlRouteProvider) & UI
- Collection `/admin/structure/denormalizer-tables` (`entity.denormalizer_table.collection`) — list builder `DenormalizerTableListBuilder` adds columns: table name (`getDbTableName()`), label, status, and live **Rows count** (`countRows()`).
- Add `/admin/structure/denormalizer-tables/add`, edit `/manage/{denormalizer_table}`, delete `/manage/{denormalizer_table}/delete`.
- Menu link "Denormalizer tables" under Structure; "Add table" local action.

## Form (`src/Form/DenormalizerTableForm.php`)
AJAX-driven `EntityForm`. Fields: `label`, machine `id`, `source` select (`entity` | `non_entity`, disabled after create), a `configuration` subform, and `status` radios. For an **entity** source: `entity_type` (content types only), `bundle`, `changed_key`, and `Fields` details with `base` + `bundle` checkboxes (empty = include all). Entity-key fields are force-checked and disabled (`processEntityKeysOptions`). `webform_submission` bundles list webform elements instead of fields. The **non_entity** branch renders `base_table`/`changed_key`/`external` but `save()` warns "None entity source are not currently supported!" and only writes the config entity — no table is built.

`save()` for an entity source runs a batch: `initBatch` (create table) then chunked `populateTableBatch` (1000 ids/chunk from `getEntityIdsToPopulate`, an `accessCheck(FALSE)` query), finishing via `finishBatch` (redirect to collection).

## Table lifecycle (methods on `DenormalizerTable`)
- `getDbTableName()` → `denormalizer_<id>`.
- `createDatabaseTable(bool $init)` — creates via schema API; if the table exists and `$init` is false it returns FALSE (no-op), otherwise drops and recreates. Columns from `getDbTableFieldsSchema()`, indexes from `getDbTableIndexes()` (one per selected base field), primary key `<idfield>__value`.
- `getDbTableColumnsSchemaForEntityFields()` — for each selected field, calls the field-type class's `::schema()` and emits `<field>__<column>` columns; `target_id` columns become `varchar_ascii(255)`.
- `insert/update/deleteDataFromEntityIntoDbTable()` — DB-API `insert`/`update`/`delete`. `getEntryFromEntity()` → `extractDataFromEntityForSelectedFields()` builds `<field>__<property>` values, imploding multi-value fields with commas.
- `countRows()` — `SELECT COUNT(*)` on the table (0 if it does not exist).
- `delete()` — drops the backing table after config delete.

## Sync: hooks + queue
`denormalizer.module` implements `hook_entity_insert/update/delete`; each calls `DenormalizerTable::onContentEntityCrud($entity, $is_new, $delete)` for content entities. That method finds every `source=entity` table whose `entity_type`+`bundle` match and queues a `denormalizer_queue` item (`denormalizer_table_id`, `entity_type_id`, `entity_ids`, `is_new`, `delete`).

`src/QueueWorker/DenormalizerWorker.php` (`@QueueWorker id="denormalizer_queue"`, cron time 60): loads the table + entity and calls insert (is_new) / delete (delete) / update. Logs each step to the `denormalizer` channel. Note: `denormalizer.services.yml` also declares a `denormalizer.queue_worker` service pointing at a `Queue\DenormalizerWorker` class that does not exist in this release; the working worker is the annotated plugin above.

## Webform submissions
When `entity_type === 'webform_submission'`, bundle "fields" are the webform's elements (`getElementsInitializedFlattenedAndHasValue`). `getDbTableColumnsSchemaForWebformElements()` gives each element a medium/big `text` column; multi-value elements (checkboxes, likert, `#multiple`) expand to one `<element>__<option>` column per option/question. `extractDataFromWebformSubmissionForSelectedElements()` fills them from `WebformSubmission::getElementData()`.
