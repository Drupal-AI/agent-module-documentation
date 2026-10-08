<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Dead Letter Queue

## Concept
A drop-in database queue that adds a `tries` counter. Once an item's `tries` reaches `max_tries` it is "dead": it is no longer counted by `numberOfItems()` nor served by `claimItem()`, so cron stops looping on it.

## Wire it up
- Service: `dead_letter_queue.queue.database` (`DeadLetterQueueDatabaseFactory::get($name)` → `DeadLetterDatabaseQueue`), built from `@database`, `@plugin.manager.queue_worker`, `@config.factory`, `@logger.channel.dead_letter_queue`.
- Point a queue at this factory (or use it as the queue backend for the queue names you want protected). The schema mirrors core `DatabaseQueue` plus a `tries` column (`schemaDefinition()`).

## Worker disposition
From your `QueueWorker::processItem()` you can throw:
- `DiscardDeadLetterException` — drop the item permanently.
- `RestoreDeadLetterException` — return it for another attempt.
Otherwise a failure increments `tries`; when `tries >= max_tries` the item becomes a dead letter.

## Configuration
- `max_tries` is read via `getMaxTries()` (config factory). Lower it to sideline flaky items faster; raise it to be more forgiving.
- `resetItemTries(int $itemId)` revives a dead item (also exposed in the UI submodule).

## Inspect / replay (dead_letter_queue_ui)
Enable `dead_letter_queue_ui` (needs `queue_ui >= 3.0`):
- `admin/config/system/queue-ui/dead-letters/{queueName}` — `DeadLettersForm` lists dead letters.
- reset-tries route → `ConfirmItemResetTriesForm`.
Both require the **admin queue_ui** permission.

## Unique variant
`dead_letter_queue_unique` provides `UniqueDeadLetterDatabaseQueue` for the `queue_unique` module (dedupes items while keeping dead-letter behaviour).

## Security note
Item payloads use `serialize()`/`unserialize()` exactly like core `DatabaseQueue`; data originates from site queue producers, not HTTP input.