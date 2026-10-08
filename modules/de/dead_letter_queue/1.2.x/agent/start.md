<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dead Letter Queue (dead_letter_queue) — agent index

**A database queue backend that sidelines items exceeding `max_tries` so failing jobs stop retrying forever and can be inspected/replayed.**

- **Version:** 1.2.x
- **Core:** ^10.3 || ^11.0 · **PHP:** 8.1
- **Submodules:** `dead_letter_queue_ui` (Queue UI integration), `dead_letter_queue_unique` (queue_unique variant).
- **Service:** `dead_letter_queue.queue.database` (`DeadLetterQueueDatabaseFactory` → `DeadLetterDatabaseQueue`). Adds a `tries` column; `numberOfItems()`/`claimItem()` filter `tries < max_tries`; `resetItemTries()`, `getMaxTries()`.
- **Exceptions:** `DiscardDeadLetterException`, `RestoreDeadLetterException` for worker disposition control.
- **UI routes (submodule):** `admin/config/system/queue-ui/dead-letters/{queueName}` and reset-tries — permission `admin queue_ui`.

**Security:** Not a finding — SQL is parameterized; `unserialize($item->data)` mirrors core `DatabaseQueue` (payloads are site-written by queue producers, not request input). UI routes gated by `admin queue_ui`. No security findings.

See [configure/queue.md](configure/queue.md).