<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processor plugins

Processors run a batch plugin through a specific Drupal mechanism. Discovery dir
`src/Plugin/Processor`; interface `ProcessorPluginInterface`; base `ProcessorPluginBase`; attribute
`#[Processor(id, label, description)]`; manager service `plugin.manager.batch_plugin_processor`
(`ProcessorPluginManager`, cache `processor_plugins`).

## The four shipped processors

| id | Class | Mechanism |
|---|---|---|
| `batch_api` | `Plugin/Processor/BatchApi` | Core Batch API (progress bar). Builds a `BatchBuilder` and calls `batch_set()`. |
| `drush` | `Plugin/Processor/Drush` | `extends BatchApi` — identical, for Drush batch runs. |
| `queue` | `Plugin/Processor/Queue` | Core Queue API. Extends `QueueProcessorPluginBase`. |
| `cron` | `Plugin/Processor/Cron` | Queue + cron-expression scheduling. Extends `CronProcessorPluginBase` → `QueueProcessorPluginBase`. |

## Manager: how a batch plugin is dispatched

`ProcessorPluginManager::processBatchPlugin($batch_plugin, $processor_plugin = NULL, $helpful_data)`:
1. Resolve the processor: given arg, else `$batch_plugin->getProcessorId()` (from a set processor,
   else config `processor_plugin_id`, else the first allowed id from the attribute, else `batch_api`).
2. For queue processors: default the queue id to the plugin definition's `queue_name`; if the
   queue is already building, return `STATUS_QUEUE_ALREADY_BUILDING`.
3. For cron processors: if not due, return `STATUS_CRON_NOT_DUE`.
4. `setupOperations()`; if none, return `STATUS_NO_OPERATIONS`.
5. `$processor->addOperations($batch_plugin)`.

`ProcessorPluginBase::addOperations()` normalises each operation into a row
(`batch_plugin_id`, `batch_plugin_configuration`, `operation_callback`, `operation_payload`,
`context`, `operations_count`, `persistable`) that each concrete processor then dispatches.

## Batch API / Drush (`BatchApi`)

`setupBatchBuilder()` strips array keys (Batch API needs positional args), builds a `BatchBuilder`
with the plugin's title/error message, sets the finish callback (`self::batchFinished`, or the
plugin's `getFinishedStaticCallback()` if set), and adds one operation per item calling the static
`BatchApi::processOperation(...)`. `processOperation()` **re-creates the batch plugin statically**
(`createBatchPlugin()`), restores `persistable`, tracks `sandbox` progress, and invokes the plugin's
`operation_callback`. `batchFinished()` re-creates the plugin and calls its `finished()`.

## Queue (`QueueProcessorPluginBase` + `Queue`)

`addOperations()` acquires a run lock via `logger.batch_plugin_cron` (unless `skipLock`), writes the
operations into `batch_plugin_queue_context` (json), then `\Drupal::queue($queueId)->createItem()`
per operation, plus a final `finished_callback` item (unless `skipFinishedQueueItem`), and releases
the lock. On any throwable it **breaks the lock and re-throws**. `Queue::addOperationToQueue($batch_
plugin, $operation, $skipFinishQueueItem = TRUE)` is a static helper to enqueue a single item.

Items are consumed by the queue worker `Plugin/QueueWorker/BatchPluginQueueWorker` (id
`batch_plugin_queue_worker`, `cron time = 90`, deriver `Derivative/BatchPluginQueueWorker`).
`processItem()` re-creates the plugin, restores/updates the running `context` from
`batch_plugin_queue_context`, and calls either the operation callback or `finished()`. The deriver
creates one queue per `cron`/`queue` plugin (and per enabled entity), named
`batch_plugin_queue_worker:<id>` (const `QUEUE_NAME_PREFIX`).

## Cron (`CronProcessorPluginBase` + `Cron`)

Adds due-time logic on top of the queue processor. `isCronDue()` reads the last run from
`batch_plugin_cron_log`: no log → due; `running` → not due; else compare
`CronExpression::getNextRunDate(lastStart)` to now. `getCronExpression()` reads the plugin config
`cronexpression`, else the attribute's `cronexpression`, else `@daily`. `Cron`'s config form exposes
a **Cron Expression** textfield validated by `Cron\CronExpression`. `hook_cron()` in
`batch_plugin.module` iterates every `cron`-type definition and processes it.

## Run log (`Logger\BatchPluginCronLog`, table `batch_plugin_cron_log`)

- `log($id, $start, $end, $running)` — insert or update the per-plugin row (also records `uid`).
- `getLog($id)` — fetch it. `breakLock($id)` — set `running = 0` (clears a stuck lock).

## Adding a custom processor

Extend `ProcessorPluginBase` (or `QueueProcessorPluginBase`), add `#[Processor(id, label,
description)]`, and implement `addOperations()`. Restrict which plugins may use it via each batch
plugin's `processors` attribute list; `getProcessorOptions($batchPlugin)` filters accordingly.
