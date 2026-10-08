<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Replaces Drupal's lock service with a database lock that hands out contended locks in first-in-first-out order.
---
Core's default lock backend does not guarantee ordering: when several requests wait on the same lock, any waiter may win next. `fifo_lock` provides `\Drupal\fifo_lock\FIFODatabaseLock` (service id `fifo_lock`, tagged `backend_overridable`, `lazy`) which stores each acquisition attempt as a row in a dedicated `fifo_lock` table with an auto-increment `id`; a request only holds the lock when its row has the minimum `id` for that name, so the earliest requester acquires first.

You opt in per call site by swapping `\Drupal::lock()` for `\Drupal::service('fifo_lock')` (or injecting the `fifo_lock` service); it implements the standard `LockBackendInterface`, so `acquire()`, `release()`, `wait()`, and `releaseAll()` work as usual. The table is created on demand via `ensureTableExists()`, and `hook_cron` deletes expired rows and truncates the table (resetting the auto-increment) when it is empty. All SQL uses parameterised queries; lock names longer than 255 chars or non-ASCII are hashed via `Crypt::hashBase64`. Because it is `backend_overridable`, you can also set it as the site-wide lock backend in `services.yml`.
---
- Serialise a long-running operation so callers run strictly in arrival order.
- Prevent thundering-herd reordering on a hot cron/queue lock.
- Swap `\Drupal::lock()` for `\Drupal::service('fifo_lock')` in a service.
- Override the default `lock` backend site-wide in `services.yml`.
- Guard a non-idempotent external API call with an ordered lock.
- Ensure fair scheduling among concurrent workers.
- Acquire a lock with a custom timeout.
- Extend an already-held lock's expiry.
- Release a specific named lock.
- Release all locks held by the current request on shutdown.
- Wait for a busy lock and retry a bounded number of times.
- Rely on automatic creation of the `fifo_lock` table on first use.
- Let cron clean expired locks and reset the table's auto-increment.
- Handle very long or non-ASCII lock names safely (hashed).
- Coordinate batch processes that must run sequentially.
- Avoid duplicate processing of the same entity across parallel requests.
- Provide FIFO fairness for import/migration steps.
- Use as a drop-in `LockBackendInterface` implementation in tests.