# Entity Registry — services, config, hooks, schema

## Services

| Service id | Class | Role |
|---|---|---|
| `entity_registry.tracker` | `Tracker` (`TrackerInterface`) | Low-level CRUD on the `entity_registry` table. Primitive args only, no entity/plugin awareness. |
| `entity_registry.processor` | `IndexProcessor` (`IndexProcessorInterface`) | Runs consumers: claims PENDING rows (atomic + `lock`), calls `processItem`/`deleteItem`, updates status. |
| `entity_registry.consumer_manager` | `EntityRegistryConsumerManager` | Attribute plugin manager (`getDefinitions()`, `createInstance()`). |
| `entity_registry.drush_commands` | `Drush\Commands\EntityRegistryDrushCommands` | CLI (see drush/commands.md). |

`Hook\EntityRegistryHooks` (injected with the manager, tracker, logger factory) implements the
entity insert/update/delete/translation_delete OOP hooks that populate the tracker.

## `TrackerInterface` (status constants + key methods)

Constants: `PROCESSED = 0`, `PENDING = 1`, `FAILED = 2`.

- `insert($consumer_id,$entity_type,$entity_id,$langcode)` — UPSERT; existing row resets to
  PENDING, `retry_count` 0, updates `changed`.
- `insertMultiple($consumer_id, array $items)` — chunked bulk UPSERT (`chunk_size`); items have
  keys `entity_type`, `entity_id`, `langcode`.
- `updateStatus($consumer_id,$entity_type,$entity_id,$langcode,$status)`.
- `delete($consumer_id, ...)` — delete tracking rows (used on entity delete and on provider
  module uninstall via `hook_modules_uninstalled`).
- status-count / claim helpers used by the processor and admin pages.

All queries use the parameterized Drupal DB API against the fixed `entity_registry` table (no
dynamic table names or string-built SQL).

## `IndexProcessorInterface` (main methods)

`processSingleItem(...)`, `processConsumer($consumer_id, $batch_size)`, `reindex(...)`,
`retryFailed(...)`, `populateConsumer($consumer_id)`, `clearConsumer($consumer_id)`,
`rebuildTracking($consumer_id)` / `rebuildTrackingStep($consumer_id, &$sandbox)` (Batch API step).

## Config

`entity_registry.settings` (global):

| Key | Default | Meaning |
|---|---|---|
| `cron_enabled` | `true` | Process async items on cron. |
| `batch_size` | `50` | Items per consumer per cron run. |
| `chunk_size` | `1000` | DB operation chunk size for bulk inserts. |

Per-consumer override object `entity_registry.consumer.<plugin_id>` with `batch_size` (used if
> 0, else falls back to the global `batch_size`).

## Cron

`hook_cron` returns early if `cron_enabled` is false; otherwise loops all consumer definitions and
calls `IndexProcessor::processConsumer()` with the effective (per-consumer or global) batch size,
logging any `\Throwable` to the `entity_registry` channel. A `QueueWorker`
(`EntityRegistryQueueWorker`) handles the async `cron` phase.

## Schema (`entity_registry` table)

PK `(consumer_id, entity_type, entity_id, langcode)`; columns `status` (tinyint, default 1=PENDING),
`retry_count` (int), `changed` (int timestamp). Indexes: `consumer_status`,
`consumer_status_changed`, `entity_lookup` (entity_type, entity_id), `changed`.

## Permission

`administer entity registry` (`restrict access: true`) gates all admin routes and bulk operations.
