<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export services & API

Services registered in `acquia_perz_push.services.yml`.

## `acquia_perz_push.export_content` — `ExportContent`

Builds and sends entity payloads to CIS via `acquia_perz.client_factory`.
- `exportEntity(EntityInterface $entity)` / `exportEntityById($type, $id, $langcode = 'all')`
- `exportEntities(array $entities, $langcode = 'all')`
- `getEntityPayload($type, $id, $langcode)` — returns the CIS variation payload (or NULL).
- `deleteEntity()` / `deleteEntityById()` / `deleteTranslation()` / `deleteTranslationById()`
- `sendBulk(array $entity_variations)` — send a batch of variations.

The entity insert/update/delete hooks in `acquia_perz_push.module` call these for eligible
published entities (eligibility via `acquia_perz.entity_helper` `isEligibleForExport()`).

## `acquia_perz_push.export_queue` — `ExportQueue`

- `rescanContentBulk($use_batch = TRUE)` — scan opted-in content and enqueue it.
- `addBulkQueueItem($action, array $entities, $langcode = 'all')`
- `exportBulkQueueItems()` — drain the queue, exporting each chunk.
- `getQueueCount()`, `purgeQueue()`
- Batch callbacks: `rescanBatchBulkProcess()`, `exportBulkBatchProcess()`, `*Finished()`.

## `acquia_perz_push.tracker` — `ExportTracker`

Reads/writes the `acquia_perz_push_export_tracking` table.
- `trackEntity($type, $id, $langcode, $action)`, `export()`, `exportTimeout()`, `delete()`,
  `deleteTimeout()`, `clear()`, `get($uuid, $langcode)`, `isTracked($uuid, $langcode)`.
- Status constants: `EXPORTED`, `EXPORT_TIMEOUT`, `DELETED`, `DELETE_TIMEOUT`, `FAILED`;
  table name constant `EXPORT_TRACKING_TABLE`.

This submodule defines **no plugin types and no hooks of its own**; it consumes the parent
module's `acquia_perz.client_factory` and `acquia_perz.entity_helper` services.
