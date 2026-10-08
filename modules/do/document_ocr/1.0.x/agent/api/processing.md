<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processing pipeline (hooks, cron, batch, events)

The orchestration lives in `\Drupal\document_ocr\Services\Process` (service `document_ocr.process`),
driven by hook glue in `\Drupal\document_ocr\Services\Module` (service `document_ocr.module`).

## Entry points (`document_ocr.module`)

- `hook_entity_insert` / `hook_entity_update` → `Module::entity_insert/update()` →
  `Process::processEntity($entity)` (wrapped in try/catch, errors logged to channel
  `document_ocr`). This fires for **every** entity save; a mapping only acts when its
  `field_selector` matches the entity's type/bundle.
- `hook_entity_delete` → `Process::deleteEntity()` (cascade cleanup of tasks / JSON data /
  destination entities — see [entities/entities.md](../entities/entities.md)).
- `hook_cron` → `Process::processPendingOnCron()`.
- `hook_theme` + `template_preprocess_document_ocr_progressbar` (wizard progress bar).

## `Process::processEntity()`

For each matching, **active** mapping: skip if the entity is not new and `process_update` is off;
load the processor plugin; for each referenced file whose extension the processor supports
(`isExtensionSupported()`), create/reuse a `document_ocr_task`. Then:
- **Async** processor (`isAsynchronous()` + config `asynchronous`): optionally initiate the remote
  job, set task Initiated.
- **Real-time** (`settings.realtime_processing`): run `processDocument()` inline; on success attach
  destination + set Processed, else increment attempts + set Pending.
- Otherwise set Pending (run later on cron/batch).

## `processDocument()` / `saveEntity()`

`processDocument()` sets the processor's credentials/config/file and calls `getMappingData()`, then
`saveEntity()` maps properties→fields: for each mapping row it reads
`$mapping_data->getValues()[property]`, optionally runs the row's transformer plugin
(`transform()`), or expands `%property%` tokens for the `custom_value` transformer, and
`$entity->set()`s the field. It fills a missing `title`/`label` with the filename, optionally sets
the source file field, then `$entity->save()`. One-time variants: `processOneTimeDocument()` /
`processAsyncOneTimeDocument()` (destination bundle carried in the task's `data`).

## Events

`saveEntity()` dispatches (`event_dispatcher`):
- `TaskDestinationBeforeSave` (`src/Event/`, `EVENT` constant) before saving the destination —
  subscribers can alter or veto (`getEntity()` returning null aborts the save).
- `TaskDestinationAfterSave` after saving.
Module's own subscriber `document_ocr.processed_data`
(`EventSubscriber\TaskEventSubscriber`) stores the raw processor response as a
`document_ocr_data` entity when the processor `supports store_json`.

## Cron & Batch

- `processPendingOnCron()` queries tasks with status INIT/PENDING (`accessCheck(FALSE)` — a
  system/cron context, not a request route) and calls `runPendingTask()` on each.
- `runPendingTask()` re-loads mapping/processor, enforces the attempts limit (async uses
  `asynchronous_attempts`, else `settings.attempts`), runs sync or async processing, and on
  success attaches the destination + marks Processed, else increments attempts + Pending.
- Batch API static callbacks in `\Drupal\document_ocr\Services\Batch`:
  `process()` (queued tasks), `processOneTime()` (one-time upload form), `processOlderEntity()`
  (the "Queue Older Entities" tool), and `completeProcessCallback()`. The one-time upload form
  (`Form/OneTime/FilesForm`) uses a `managed_file` element validated against the processor's
  extensions and sets a batch of `Batch::processOneTime` operations.
