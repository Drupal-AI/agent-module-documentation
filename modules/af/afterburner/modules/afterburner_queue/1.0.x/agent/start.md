<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Afterburner queue (afterburner_queue) — agent index

Submodule of **afterburner** adding a Drush command to process a Drupal queue in **parallel** Afterburner
workers. Depends on `afterburner`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

## What it provides

- **Drush command** `queue:run-async <name>` (`Commands\QueueCommands`, `drush.services.yml`; args
  `@plugin.manager.queue_worker`, `@queue`). Options: `--items-limit`, `--lease-time`, `--concurrency` (20),
  `--timeout` (300), `--sleep-time` (50000). Uses `@validate-queue`. Claims items from the named queue and runs
  each in a Spatie `Pool`, deleting on success and logging per-item + a final summary.
- **Task `Task\QueueItemTask`** — extends Afterburner's `Task\TaskBase`. `run()` re-boots Drupal in the worker,
  gets the queue and its worker plugin (`plugin.manager.queue_worker->createInstance($queueName)`), calls
  `worker->processItem($item->data)`, then `deleteItem()`; on `RequeueException`/`SuspendQueueException`
  releases the item and rethrows; on `DelayedRequeueException` delays it on `DelayableQueueInterface` queues.

No routes, permissions, config, config schema or services beyond the Drush command. CLI only.

## Solution docs

- The `queue:run-async` command, options, and `QueueItemTask` behaviour →
  [drush/queue-run-async.md](drush/queue-run-async.md)
