# Queue manager UI — inspect, process, release, clear queues

Queue UI has **no config object of its own** (`README`: "There are no configuration
provided"). It operates on the queues that core's Queue API registers. The one persisted
setting is a State flag `queue_ui.features` (e.g. `derivatives` grouping), toggled from the
overview form's "Queue Manager Features" section — not exported config.

## Routes (all require `admin queue_ui`)

Base path `admin/config/system/queue-ui`.

| Route | Path | Purpose |
|---|---|---|
| `queue_ui.overview_form` | `/` | Queue manager overview (the `configure` route) |
| `queue_ui.overview_form.derivative` | `/derivative/{derivative_worker_id}` | Overview filtered to one derivative worker |
| `queue_ui.cron_form` | `/cron/{queue}` | Edit the cron time limit for one queue |
| `queue_ui.confirm_clear_form` | `/clear` | Confirm deleting all items in selected queues |
| `queue_ui.inspect` | `/inspect/{queueName}` | List items in a queue (needs a matching QueueUI plugin) |
| `queue_ui.inspect.view` | `/{queueName}/view/{queueItem}` | View one item's data |
| `queue_ui.inspect.release` | `/{queueName}/release/{queueItem}` | Confirm releasing one item's lease |
| `queue_ui.inspect.delete` | `/{queueName}/delete/{queueItem}` | Confirm deleting one item |
| `queue_ui.process` | `/{queueName}/process` | Controller entry to process a queue |

Menu link `queue_ui.overview_form` sits under `system.admin_config_system`.

## Overview form (`OverviewForm`)

Table columns: **Title, Machine name, Number of items, Class, Cron time limit, Operations**.
Queue rows come from `plugin.manager.queue_worker` definitions; item counts from
`QueueFactory::get($name)->numberOfItems()`.

Bulk **Action** select applied to table-selected rows (`submitBulkForm`):

| Action value | Method | Effect |
|---|---|---|
| `submitBatch` | Batch process | Runs `queue_ui.batch`->`batch()` (Batch API) over selected queues |
| `submitRelease` | Remove leases | `QueueUIInterface::releaseItems()` resets lease timestamps |
| `submitClear` | Clear | Stashes selection in tempstore, redirects to `queue_ui.confirm_clear_form` to delete all items |

Per-row **Operations** links: **Cron settings** (always), **Inspect** (only when
`QueueUIManager::fromQueueName()` returns a plugin for the queue's backend class), and
**Overview** for grouped derivatives.

**Features** (State `queue_ui.features`): `derivatives` groups derivative queues by main
worker ID. If the suggested `queue_order` module is installed, a drag-and-drop **Weight**
column appears and weights save to `queue_order.settings`.

Programmatic access: item counts and processing use core services — `@queue`
(`QueueFactory`), `@plugin.manager.queue_worker`, and the module's `@queue_ui.batch`
(`QueueUIBatchInterface`) and `@plugin.manager.queue_ui` (`QueueUIManager`).
