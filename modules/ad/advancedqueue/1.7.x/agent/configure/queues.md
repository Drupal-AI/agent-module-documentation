<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue configuration & backends

## Install
`drush en advancedqueue`. No module dependencies. A `default` queue ships in
`config/install/advancedqueue.advancedqueue_queue.default.yml` (database backend,
cron processor, 300s lease, 90s processing time, `stop_when_empty: true`). Manage queues at
`admin/config/system/queues` (menu link `entity.advancedqueue_queue.collection`,
`configure` route).

## The queue config entity
`Drupal\advancedqueue\Entity\Queue` (`advancedqueue_queue`, config prefix
`advancedqueue_queue`, admin permission `administer advancedqueue`). Exported keys
(`config_export`): `id`, `label`, `backend`, `backend_configuration`, `processor`,
`processing_time`, `threshold`, `locked`, `stop_when_empty`. Backend config is held in a
`BackendPluginCollection` (`getPluginCollections()` → key `backend_configuration`); setting
`backend` or `backend_configuration` via `set()` resets the collection.

Lifecycle: `postSave()` calls the backend's `createQueue()` on insert; `postDelete()` calls
`deleteQueue()` (the database backend deletes all rows for that `queue_id`).

## Config schema keys
From `config/schema/advancedqueue.schema.yml` (`advancedqueue.advancedqueue_queue.*`):
- `backend` (string) — backend plugin id; `backend_configuration` typed as
  `advancedqueue.backend.[%parent.backend]`.
- `processor` (string) — `cron` or `daemon` (`QueueInterface::PROCESSOR_*`).
- `processing_time` (int) — seconds a processing run may last (0 = unlimited, but forced to
  90 off-CLI by `Processor`).
- `locked` (bool) — when true the entity cannot be deleted (see access handler).
- `stop_when_empty` (bool) — stop the processing loop once the queue drains.
- `threshold` mapping — `type` (int), `limit` (int), `state` (string) for auto-cleanup.

Backend config schema `advancedqueue_backend_configuration` defines `lease_time` (int).
The default `database` backend maps to `advancedqueue.backend.database`.

## Backends
- **Database** (`Plugin/AdvancedQueue/Backend/Database.php`, id `database`) — default. Stores
  jobs in the `advancedqueue` table (schema in `advancedqueue.install`: `job_id`, `queue_id`,
  `type`, `payload` JSON blob, `state`, `message`, `num_retries`, `available`, `processed`,
  `expires`, `fingerprint`, plus indexes). Implements every optional capability interface
  (list/load/release/delete/detect-duplicates). Claims are lease-based: a job is claimed by
  updating `state`→`processing` and `expires`→now+`lease_time` under a `WHERE expires = 0`
  guard, so only one worker wins. Concurrent write contention (deadlocks / SQLite busy) is
  retried via `executeWithDeadlockRetry()`.
- **Null** (`NullBackend.php`, id `null`) — discards jobs; useful to disable a queue.

Base class `BackendBase` supplies config handling and the `lease_time` form
(`buildConfigurationForm`, default 300s, min 1).

## Cleanup thresholds
`Database::cleanupQueue()` first re-queues expired (lease-timed-out) jobs, then
`cleanupQueueItems()` prunes old rows. `threshold.type` is `QUEUE_THRESHOLD_ITEMS` (1) or
`QUEUE_THRESHOLD_DAYS` (2); `limit` uses the `QUEUE_THRESHOLD_*_LIMITS` presets; `state`
`all` prunes success+failure, otherwise success only. No cleanup runs when type or limit is 0.

## Processors
- `cron` — `AdvancedqueueHooks::cron()` loads every queue with `processor = cron` and calls
  `Processor::processQueue()`.
- `daemon` — not run by cron; drive it with the Drush command or a long-running script,
  typically with `stop_when_empty: false`.
