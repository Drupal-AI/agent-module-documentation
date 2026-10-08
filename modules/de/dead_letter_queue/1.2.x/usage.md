<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a dead-letter database queue for Drupal: items that keep failing are set aside (past a max-tries threshold) instead of being retried indefinitely.

---
Drupal's core reliable queue retries a failed item forever, which can wedge a queue behind one poison item. This module supplies a drop-in `DeadLetterDatabaseQueue` (via `DeadLetterQueueDatabaseFactory`, service `dead_letter_queue.queue.database`) that tracks a `tries` count per item and treats items whose `tries` reach the configured `max_tries` as "dead" — `numberOfItems()` and `claimItem()` only count/claim items with `tries < max_tries`, so cron stops re-serving exhausted items. Worker code can throw `DiscardDeadLetterException` (drop the item) or `RestoreDeadLetterException` (send it back for another chance) to control disposition, and `resetItemTries()` can revive an item.

The queue schema mirrors core's `DatabaseQueue` with the added `tries` column, and item data is stored/read with `serialize()`/`unserialize()` exactly as core does — queue payloads are written by the site's own producers, not by request input. The `dead_letter_queue_ui` submodule integrates with Queue UI to list dead letters (`admin/config/system/queue-ui/dead-letters/{queueName}`) and reset an item's tries, gated by the `admin queue_ui` permission. The `dead_letter_queue_unique` submodule provides a unique-item variant for the queue_unique module.

Typical setup: enable the module, point a queue worker at the dead-letter factory (or configure it as the queue backend), set `max_tries`, and use the UI submodule to inspect/replay dead items.
---
- Stop a poison queue item from blocking a whole queue.
- Cap retries per item with a `max_tries` threshold.
- Set aside repeatedly-failing items as "dead letters".
- Inspect dead letters via the Queue UI submodule.
- Reset an item's try count to replay it.
- Discard an item explicitly with `DiscardDeadLetterException`.
- Restore an item for another attempt with `RestoreDeadLetterException`.
- Keep cron moving past exhausted items.
- Count only still-eligible items with `numberOfItems()`.
- Claim only items under the try limit.
- Use a unique-item dead-letter queue (queue_unique submodule).
- Diagnose why a background job keeps failing.
- Preserve failed payloads for later analysis.
- Integrate with existing queue workers with minimal code.
- Gate dead-letter inspection behind `admin queue_ui`.
- Replay a batch of failed items after a fix is deployed.
- Track per-item `tries` in the database.
- Swap in as the database queue backend for specific queues.
- Avoid infinite retry loops on transient-but-persistent failures.
- Audit dead letters per queue name.