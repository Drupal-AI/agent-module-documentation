<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pcb_redis — agent index

Submodule of [Permanent Cache Bin](../../../../4.0.x/agent/start.md). Adds a **Redis-backed
permanent** cache backend so a Redis bin survives `drush cr`.

- **The `cache.backend.permanent_redis` service + how to point a bin at it** →
  [configure/backend.md](configure/backend.md)

Key facts: registers service `cache.backend.permanent_redis`
(`PermanentRedisBackendFactory` extends the Redis module's `CacheBackendFactory` →
`PermanentRedisBackend`, which mixes Redis with pcb's `PermanentBackendTrait`: `deleteAll()`
no-op, `deleteAllPermanent()` clears). Depends on the **redis** contrib module and the **pcb**
parent, plus a real Redis server. No config, UI, permissions, or Drush of its own; uses the
parent's `pcbf`/`pcb-list` commands. For the permanence mechanism see the parent's
[api/backend.md](../../../../4.0.x/agent/api/backend.md).
