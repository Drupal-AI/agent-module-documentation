<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fifo_lock — using the lock service

## Get the backend
```php
$lock = \Drupal::service('fifo_lock');        // or inject service id 'fifo_lock'
```
It implements `\Drupal\Core\Lock\LockBackendInterface`, so the API matches core:
- `acquire(string $name, float $timeout = 30.0): bool`
- `lockMayBeAvailable(string $name): bool`
- `wait(string $name, int $delay = 30): bool` (from `LockBackendAbstract`)
- `release(string $name): void`
- `releaseAll(?string $lockId = NULL): void`

## Ordered acquisition
Each `acquire()` inserts a row `(name, value=lockId, expire)`; the caller holds the
lock only when its `id` equals `MIN(id)` for that name. Earliest requester wins → FIFO.

## Make it the site-wide lock backend
In a `sites/*/services.yml` you can alias the core `lock` service to this backend
(it is tagged `backend_overridable`).

## Housekeeping
- Table `fifo_lock` is created on demand (`ensureTableExists()`).
- `hook_cron` deletes rows with `expire <= now` and `TRUNCATE`s the table when empty.
