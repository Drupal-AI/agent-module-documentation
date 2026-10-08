<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `queue:run-async` — parallel queue processing

## Install & enable

```bash
drush en afterburner_queue -y
```

Requires `afterburner` (and its `spatie/async`). CLI only.

## Command

`Commands\QueueCommands::run($name, $options)` — Drush `queue:run-async`:

```bash
drush queue:run-async my_queue \
  --items-limit=100 --lease-time=60 --concurrency=20 --timeout=300 --sleep-time=50000
```

- `$name` is validated with `@validate-queue`.
- Options (all `self::REQ` in the signature; defaults applied in code): `items-limit` (0/unset = no limit),
  `lease-time` (falls back to the queue definition's `cron.time`, else 30), `concurrency` (20), `timeout` (300),
  `sleep-time` (50000).
- Builds a Spatie `Pool` with those `concurrency`/`timeout`/`sleepTime`.
- Loops `while ((!$items_limit || $claimed < $items_limit) && ($item = $queue->claimItem($lease_time)))`, adding a
  `new QueueItemTask($name, $item)` to the pool with `->then()` (log success, increment `processed`) and
  `->catch()` handlers for `RequeueException` (log), `SuspendQueueException` (log + throw), and generic
  `\Exception` (log). Then `$pool->wait()` and logs `Processed N items … in T sec`.
- Known limitation (code `@TODO`s): it claims eagerly in the loop rather than via a generator, and `items-limit`
  counts *claimed* items, not core's *processed* semantics.

## `QueueItemTask::run()`

Extends `TaskBase`, so it re-boots Drupal in the worker. Then:

1. `$queue = \Drupal::service('queue')->get($this->queueName)`.
2. `$worker = \Drupal::service('plugin.manager.queue_worker')->createInstance($this->queueName)`.
3. `$worker->processItem($item->data)` then `$queue->deleteItem($item)` on success.
4. On `RequeueException` | `SuspendQueueException`: `$queue->releaseItem($item)` and rethrow (the pool's `catch`
   handlers act on it).
5. On `DelayedRequeueException`: if the queue is a `DelayableQueueInterface`, `$queue->delayItem($item,
   $e->getDelay())`.

## When to use

Use it for queues whose items are independent and safe to process out of order/concurrently (imports,
derivatives, notifications). For strictly ordered or shared-state queues, prefer core `drush queue:run`. Tune
`concurrency`/`timeout` to the host — each worker is a full Drupal bootstrap.
