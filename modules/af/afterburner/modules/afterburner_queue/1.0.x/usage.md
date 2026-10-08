<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Afterburner queue adds a Drush command that processes a Drupal queue in parallel using Afterburner workers.

---

Afterburner queue is a submodule of Afterburner that adds the Drush command `queue:run-async` for processing a
Drupal queue with concurrency. It claims items from the named queue and runs each inside a Spatie Async worker
pool as a `QueueItemTask` (a subclass of Afterburner's `TaskBase`), with configurable items-limit, lease-time,
concurrency, timeout and sleep-time. Each task re-boots Drupal in its worker, instantiates the queue's worker
plugin, calls `processItem()` on the item data, and then deletes, releases or delays the item according to the
queue exceptions the worker throws. It is a drop-in parallel alternative to core's sequential `drush queue:run`
for queues whose items are independent. Depends on `afterburner`.

---

- Process a Drupal queue concurrently instead of one item at a time.
- Run `drush queue:run-async <queue>` in place of `drush queue:run`.
- Cap how many items to process with `--items-limit`.
- Set the claim lease time with `--lease-time`.
- Control the number of parallel workers with `--concurrency`.
- Bound each worker with `--timeout`.
- Tune the pool poll interval with `--sleep-time`.
- Speed up large import queues by parallelising item processing.
- Reuse existing queue worker plugins unchanged.
- Honour `RequeueException` by releasing the item for a later run.
- Honour `SuspendQueueException` (logs and stops).
- Honour `DelayedRequeueException` by delaying the item on delayable queues.
- Delete items only after successful processing.
- Log per-item success and a final processed/elapsed summary.
- Run it from cron/CI as a faster queue drainer.
- Parallelise webhook, email or derivative queues.
