<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue Processor drains configured queue workers at the end of page requests — after the response is sent to the visitor — as a traffic-driven alternative to cron for sites with steady traffic.

---

The whole engine is a `KernelEvents::TERMINATE` subscriber (`QueueProcessorSubscriber`, priority -100). On each eligible request it reads `queue_processor.settings`, and if processing is enabled (and, unless `run_on_admin_routes` is on, the path is not under `/admin`) it sorts the configured queues by priority (lower number = higher priority), fires `hook_queue_processor_queues_alter()`, then walks the list within a global `max_execution_time` budget: for each enabled queue it claims items, calls the worker's `processItem()`, deletes processed items, honours `SuspendQueueException` (releases the item and stops that queue), logs worker exceptions, and stops when the per-queue or global time limit is hit. A configurable `logging` level (errors/warnings, summary, all) controls how much is written to the `queue_processor` logger channel.

The admin form at `/admin/config/system/queue-processor` (`QueueProcessorSettingsForm`) is gated by the core `administer site configuration` permission; it lists discovered queue workers and lets you toggle each, set its priority (0–100) and per-queue time limit, plus the global enable flag, logging level, max execution time (1–60s) and the admin-route toggle. Security-wise there is **no route or endpoint that triggers queue processing on demand** — processing only happens implicitly on kernel terminate of normal requests, and the only exposed route is the admin-permission-gated settings form. Because workers run on front-end requests (not just cron/admin), any code path a worker executes runs in the context of arbitrary anonymous page hits; the module itself adds no privileged trigger. Setup: enable the module, open the settings form, enable the desired queues with priorities/limits, and tune the time budget for your traffic level.
---
- Process queues on every eligible page request instead of waiting for cron
- Drain an email-notification queue promptly on active sites
- Prioritise order-confirmation queues ahead of search indexing
- Set a global time budget so processing never blocks responses noticeably
- Give a critical queue a guaranteed per-queue time limit
- Let low-priority queues use only leftover global time (limit 0)
- Skip queue processing on /admin/* routes to keep the backend snappy
- Opt into processing on admin routes when desired
- Cap how many items each queue processes per request via time limits
- Boost a queue's priority during business hours with the alter hook
- Programmatically set queue configuration from custom code
- Tune max execution time by site traffic level (2–3s high, 10–15s low)
- Handle SuspendQueueException gracefully (release item, stop that queue)
- Log processing summaries to the queue_processor channel
- Choose a logging verbosity (errors/warnings, summary, or all)
- View queue processing logs and errors in dblog
- Integrate with Queue UI for enhanced queue management
- Discover and toggle each registered queue worker from the settings form
- Reorder queue processing by adjusting priority values
- Use as a lightweight background-processing layer without a system cron
