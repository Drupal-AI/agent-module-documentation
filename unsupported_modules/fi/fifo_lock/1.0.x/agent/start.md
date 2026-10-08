<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FIFO Lock (fifo_lock) — agent index

**Database lock backend granting contended locks in first-in-first-out order via a dedicated `fifo_lock` table.**

- **Version:** 1.0.x
- **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Service:** `fifo_lock` → `\Drupal\fifo_lock\FIFODatabaseLock` (tagged `backend_overridable`, `lazy`); implements `LockBackendInterface`.
- **Ordering:** earliest row (`MIN(id)`) for a lock name wins; table auto-created; cron purges expired rows and truncates when empty.
- **Routes/permissions:** none.
- **Security:** no routes or endpoints; all queries parameterised (`:name` placeholders), no raw concatenation of user input; lock names hashed if >255 chars/non-ASCII.

See [api/lock.md](api/lock.md).