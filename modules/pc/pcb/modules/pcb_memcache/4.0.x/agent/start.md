<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pcb_memcache — agent index

Submodule of [Permanent Cache Bin](../../../../4.0.x/agent/start.md). Adds a **Memcache-backed
permanent** cache backend so a Memcache bin survives `drush cr`.

- **The `cache.backend.permanent_memcache` service + how to point a bin at it** →
  [configure/backend.md](configure/backend.md)

Key facts: registers service `cache.backend.permanent_memcache`
(`PermanentMemcacheBackendFactory` → `PermanentMemcacheBackend`, which mixes the Memcache
module's backend with pcb's `PermanentBackendTrait`: `deleteAll()` no-op, `deleteAllPermanent()`
clears). Depends on the **memcache** contrib module and the **pcb** parent, plus a real Memcache
server. No config, UI, permissions, or Drush of its own; uses the parent's `pcbf`/`pcb-list`
commands. For the permanence mechanism see the parent's
[api/backend.md](../../../../4.0.x/agent/api/backend.md).
