<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Command: `queue:run-all`

Source: `src/Drush/Commands/QueueRunAllCommands.php`, class `QueueRunAllCommands extends DrushCommands`
(uses `AutowireTrait`). All behavior below is from `runAll()` and its helpers.

## Install / enable

```bash
composer require drupal/drush_queue_run_all   # pulls drush/drush ^12.5 || ^13.0
drush en drush_queue_run_all -y
drush help queue:run-all                       # verify
```

No config, no permissions, no admin page. The command is the entire feature.

## Signature

- Command: `queue:run-all` (`const RUN_ALL`), alias `queue-run-all`. Method `runAll()`, returns void.
- No arguments (unlike core `queue:run`, which takes a queue name).

## Options (`#[CLI\Option]`)

- `--time-limit` — max seconds allowed, counted **across all queues**. Cast to int in the hook.
- `--items-limit` — max items processed, **across all queues**. Cast to int in the hook.
- `--memory-limit` — max memory before exit; a `memory_limit`-style size (`g`/`m`/`k`) or a percentage
  (`%`) of the Drush memory limit. Parsed by `parseMemoryLimit()` into bytes.
- `--lease-time` — seconds an item stays claimed. Default per queue: `$info['cron']['time'] ?? 30`.
- `--daemon` (flag, default FALSE) — keep looping; between passes it `sleep(1)`s. Exits when a limit is
  reached, or never if no limit is set.
- `--queues` — comma-separated machine names to include.
- `--exclude-queues` — comma-separated machine names to exclude.
- `--progress` (flag, default FALSE) — render a Symfony progress bar (`io()->progressStart/Advance/Finish`).

`postInitRunAll()` (`#[CLI\Hook(POST_INITIALIZE)]`) casts `time-limit`/`items-limit` to int, parses
`memory-limit`, and throws `\InvalidArgumentException` if **both** `--queues` and `--exclude-queues` are set.

## How queues are discovered and filtered

- `getQueues()` returns `QueueWorkerManagerInterface::getDefinitions()` (every `@QueueWorker` plugin),
  static-cached in `self::$queues`.
- `filterQueues()`: with `--queues`, `array_intersect_key` against the trimmed include list; with
  `--exclude-queues`, `array_diff_key` against the exclude list; otherwise all. (So only names that
  actually exist as worker definitions are ever processed/instantiated.)

## Processing loop

- Outer `do { … } while ($options['daemon'] && !hasReachedLimit(...))`.
- For each queue: skip if a delay for it is stored and not yet elapsed
  (`keyvalue` store `queue_run_all_delays`); if elapsed, delete the delay.
- `$queue = QueueFactory::get($name)`; `$worker = workerManager->createInstance($name)`;
  `garbageCollection()` if the queue is a `QueueGarbageCollectionInterface`.
- Inner `while`: until `hasReachedLimit()` or no more `claimItem($lease_time)`, call `processItem()`.
- `hasReachedLimit()` is true when: `time-limit` set and time is up; OR `items-limit` reached; OR
  `memory-limit` set and `memory_get_usage()` at/over it.
- On success logs "Processed N items from the @name queue in @elapsed sec"; at the end logs the grand total.

## Per-item error handling (`processItem()`)

- Success → `worker->processItem($item->data)`, `queue->deleteItem($item)`, returns TRUE.
- `RequeueException` → `queue->releaseItem($item)` (immediate requeue).
- `SuspendQueueException` → `releaseItem`, then **rethrown** so the outer loop skips to the next queue;
  if `isDelayable()`, a delay of `min(getDelay(), suspendMaximumWait)` is stored in
  `queue_run_all_delays` keyed by queue name.
- `DelayedRequeueException` → `queue->delayItem($item, getDelay())` only if the queue is a
  `DelayableQueueInterface`; otherwise the item's expiry is left alone.
- Any other `\Exception` → logged to both the Drush logger and the `drush_queue_run_all` logger channel;
  item is left in the queue for a later attempt. Returns FALSE.

## Suspend-delay cap (`queueConfig`)

`suspendMaximumWait` defaults to `30.0`. In the constructor, if the container has a `queue.config`
parameter it is merged over the default (`$this->container->getParameter('queue.config') + $this->queueConfig`).
This caps how long a delayable suspended queue is skipped. (This is a service-container parameter, not a
Drupal config object — the module ships no config or config schema.)

## Examples

```bash
drush queue:run-all                                   # drain all queues once
drush queue:run-all --time-limit=60 --items-limit=500 # bounded run
drush queue:run-all --queues=cron_example,my_worker   # only these
drush queue:run-all --exclude-queues=aggregator_feeds # all but this
drush queue:run-all --daemon --memory-limit=60%       # long-running under a supervisor
drush queue:run-all --daemon --items-limit=1000       # exit after 1000 so a supervisor restarts it
```

Under a process manager (systemd/Supervisord/RoadRunner) run the `--daemon` form; restart runners after
every deploy or they keep executing old in-memory code. See the module README for unit examples.
