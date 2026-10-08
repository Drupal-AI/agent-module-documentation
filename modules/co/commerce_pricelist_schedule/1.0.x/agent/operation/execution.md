<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Execution: cron pickup, queue worker, cleanup

## `hook_cron` (`commerce_pricelist_schedule.module`)

On each cron run:

1. **Pick up due imports.** `entityQuery('pricelist_scheduled_import')` (`accessCheck(FALSE)`) for
   `status = pending` and `scheduled_time.value <= now` (`date('Y-m-d\TH:i:s', requestTime)`). For
   each match: set status `in_progress`, save, and enqueue an item `['id' => $id]` on queue
   **`scheduled_import_worker`**.
2. **Cleanup.** Delete imports in `completed` / `failed` / `cancelled` whose `changed` timestamp is
   older than 30 days (`30*24*60*60`). For each, remove the referenced file's usage
   (`file.usage->delete(...)`), delete the file, then delete the entity; logs a notice with the
   count.

Because pickup is cron-driven, imports run on the **next cron run at or after** `scheduled_time`;
ensure cron runs regularly (`drush cron` or a system scheduler).

## Queue worker — `Plugin\QueueWorker\ScheduledImportWorker` (`scheduled_import_worker`)

`@QueueWorker(id="scheduled_import_worker", cron={"time"=60})`. `processItem($data)` **emulates the
Batch API** using `commerce_pricelist`'s `PriceListItemImportForm` static methods, persisting a
batch context in `\Drupal::state()` under key `commerce_pricelist_schedule.batch_context.<id>`:

- **First pass (context is NULL):** decodes `import_settings` and builds the operations list:
  - if `delete_fieldset.delete_existing` is truthy → `PriceListItemImportForm::batchDeleteExisting`
    (arg: the price-list id);
  - if the file loads → `PriceListItemImportForm::batchProcess` (args: file URI, `mapping`,
    `options`, price-list id, and the delete-existing bool).
  Context = `{operations, current_operation:0, finished:0, results:[]}`.
- **Each pass:** invokes the current operation's hardcoded callback via
  `call_user_func_array($callback, array_merge($args, [&$context]))`.
  - If `context.finished < 1` → save context and **requeue** the same id (continue this operation).
  - Else if `context.results.error` → log, set status `failed`, delete state.
  - Else → advance `current_operation`, invoke
    `hook_commerce_pricelist_schedule_finished($context, $scheduled_import)`, reset
    `finished`/`results`, and requeue if another operation remains.
- **When no operations remain:** call `PriceListItemImportForm::finishBatch(TRUE, results,
  operations)`, set status `completed` (or `failed` on exception, logged), delete the state key.

The callbacks are fixed to `PriceListItemImportForm` — never caller-supplied — so item data only
carries the import id. Multi-pass work is spread across cron runs via self-requeuing.

## Extension hook

`hook_commerce_pricelist_schedule_finished(array $context, PricelistScheduledImport $scheduled_import)`
fires after each completed operation — a place to react to progress/completion of a scheduled
import.

## File access — `hook_ENTITY_TYPE_access` (`commerce_pricelist_schedule_file_access`)

For files whose URI starts with the pricelists upload dir (`private://pricelists/`, or
`temporary://pricelists/` when no private stream), access is **allowed only** to accounts with
`administer commerce_pricelist` when the file is referenced by an existing
`pricelist_scheduled_import`; otherwise it returns neutral (defers to core). This keeps uploaded
price-list CSVs out of anonymous reach.
