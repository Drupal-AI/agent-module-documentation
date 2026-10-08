<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Queue Processor

## Settings form
`/admin/config/system/queue-processor` (permission: `administer site configuration`).
Writes config object `queue_processor.settings`.

### Global settings
- `enabled` (bool) — master on/off for post-response processing.
- `logging` — `errors` (errors+warnings), `summary` (INFO summaries), `all`.
- `max_execution_time` (int, 1–60s) — total per-request budget across all queues.
- `run_on_admin_routes` (bool) — if false, skip processing when path starts with `/admin`.

### Per-queue settings (`queues` sequence)
The form lists every discovered queue worker (`plugin.manager.queue_worker` definitions).
For each enabled queue it stores `{id, enabled, priority, time_limit}`:
- `priority` 0–100, **lower = processed first** (default 50).
- `time_limit` seconds, `0` = use remaining global time; otherwise `min(limit, remaining)`.

Only enabled queues are persisted.

## Processing model
`QueueProcessorSubscriber::onKernelTerminate` (event `kernel.terminate`, priority -100):
1. Bail if disabled, or on `/admin/*` when `run_on_admin_routes` is false.
2. Sort queues by priority; invoke `hook_queue_processor_queues_alter($queues)`.
3. For each enabled queue within the global budget: claim → `processItem()` → delete;
   `SuspendQueueException` releases the item and stops that queue; other exceptions are
   logged (item deleted). Stops on per-queue or global time limit.

## Alter hook
```php
function mymodule_queue_processor_queues_alter(array &$queues): void {
  foreach ($queues as &$queue) {
    if ($queue['id'] === 'email_queue' && date('H') >= 9 && date('H') <= 17) {
      $queue['priority'] = max(0, $queue['priority'] - 20);
    }
  }
}
```
Each item: `id`, `enabled`, `priority` (0–100), `time_limit` (0 = remaining global).
