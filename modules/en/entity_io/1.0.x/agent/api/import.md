<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO — import mechanism

How JSON becomes entities. Source: `src/Service/EntityImporter.php`,
`src/Form/EntityJsonImportForm.php`, `src/Service/JsonStorageService.php`,
`src/Helper/*` (`JsonParseEntityData`, `JsonValidate`, `EntityJsonDiff`, `EntityCreate`,
`EntityLoader`, `EntityFields`, `EntityPathAlias`).

## `EntityImporter::import(array $json_, $langcode = NULL, $debug = FALSE)`

The importer (`entity_io.entity_importer`) processes an array of decoded JSON entity documents:

1. If `entity_io.import_settings.import_user` is set, `account_switcher->switchTo()` impersonates
   that user for the import scope.
2. Detects and decompresses optimized JSON (`root`/`structures`/`keys` → `json_compressor`).
3. `JsonParseEntityData::parseEntityInfo()` extracts `type`, `bundle`, `id`, `uuid`. The entity is
   loaded by UUID (`getEntityFromParsedInfo`), else by the `entity_io_storage` binding, else
   created with `EntityCreate::create()`. UUID mapping is recorded via
   `JsonStorageService::getOrSave()` (`entity_io_storage` table) to avoid duplicating referenced
   content on re-import; a static `$alreadyImported` / `$globalEntities` index breaks recursion.
4. For each field in `EntityFields::getAll($type, $bundle)` present in the JSON: identity/audit
   fields (`id`, `uuid`, `vid`, `changed`, `langcode`, `revision_id`, …) are skipped; scalars are
   `set()` directly; `link`/`path` fields are re-mapped (`replaceEntityUri`,
   `EntityPathAlias::updateAliasFromJson`); `entity_reference`(`_revisions`) fields recurse into
   `import()` for the referenced payload or bind to an existing entity by `target__uuid`;
   `image`/`file` fields recurse then `validateOrCreateFileFromJson()` writes the base64 payload
   with `file.repository->writeData()`. Unknown types dispatch
   `hook_entity_io_import_<field_type>_alter`.
5. Optional behaviors from `entity_io.import_settings`: `import_create_new_revision` creates a new
   node revision attributed to the current user; `moderation_state` is applied only when a valid
   workflow transition exists.
6. `$entity->validate()` runs and violations are collected into static `$entityValidation` (logged
   as warnings) but do **not** block the save. `state('entity_io.skip_webhooks')` is toggled around
   `$entity->save()` so importing does not re-fire the webhooks submodule. Translations are imported
   recursively.

## The import form — `EntityJsonImportForm` (`entity_io_entity_json_import_form`)

Route `entity_io.entity_import` = `/admin/content/import`, permission **`entityio import json`**
(local task/menu link under Content). Multi-step `FormBase`:

- **Step 1 (upload):** a `file` element accepting `.json`, `.gz`, `.br`. `validateForm()` checks the
  extension + MIME, decompresses gz/Brotli, `json_decode`s, optionally decompresses optimized JSON,
  and stores the parsed data in `$form_state`.
- **Step 2 (preview):** loads the existing entity by UUID (or storage binding), validates with
  `JsonValidate::validateEntity()` (and `validateLastChanged()` when `ignore_import_older` is on),
  and renders a **visual diff** per language via `EntityJsonDiff::diff()`/`diffFields()` themed by
  `diffs_table` (diff mode select: `full`/`json`/`fields`/`base`; libraries `diff2html`,
  `diffs_search`, `toggle_diffs_entity_table`). A **confirm checkbox** is required before
  `submitForm()` calls `EntityImporter::import()`; on a single imported entity it redirects to that
  entity's edit form.

## Import logging & storage

`EntityIoLogger` (`entity_io.logger`) writes rows to `entity_io_log` (uid, operation, entity_type,
entity_id, status, message, created). `JsonStorageService` (`entity_io.storage`) reads/writes
`entity_io_storage` (`json_uuid`, `json_id`, `json_entity_type`, `json_bundle`, `entity_id`,
`entity_uuid`, `entity_type`, `entity_bundle`); `hook_entity_delete` prunes rows by UUID.
Log viewer: `entity_io.log_admin` (`/admin/config/entity-io/reports/logs`,
`EntityIoLogController::logPage`, `administer site configuration`).

CLI import paths and the push/queue submodule import endpoints reuse the same
`EntityImporter::import()` — see [drush.md](drush.md) and
[../submodules/overview.md](../submodules/overview.md).
