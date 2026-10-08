<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
pcb_redis is a submodule of Permanent Cache Bin that provides a Redis-backed permanent cache backend, so a bin stored in Redis is not wiped by `drush cr`.

---

The submodule is a thin glue shim: it registers one service, `cache.backend.permanent_redis`, whose factory `PermanentRedisBackendFactory` extends the Redis module's `CacheBackendFactory` and returns a `PermanentRedisBackend`. That backend combines the Redis module's cache implementation with pcb's `PermanentBackendTrait`, so `deleteAll()` (invoked on a cache rebuild) is a no-op while `deleteAllPermanent()` explicitly clears the Redis bin. You use it like the database variant but point the bin at `cache.backend.permanent_redis` instead of `cache.backend.permanent_database`. It requires the contrib **Redis** module (`redis:redis >= 8.x-1.0-rc2`) and the parent **pcb** module, plus a working Redis server configured for Drupal. It ships no config, UI, permissions, or Drush commands of its own — the parent pcb Drush commands (`pcbf`, `pcb:flush-all`, `pcb-list`) operate on its bins.

---

- Store an external-data cache in Redis that survives `drush cr`.
- Back a high-traffic permanent bin with Redis instead of the database for speed.
- Register a `cache.<bin>` service using `default_backend: cache.backend.permanent_redis`.
- Point an existing bin at Redis permanence via `$settings['cache']['bins']['<bin>'] = 'cache.backend.permanent_redis'`.
- Keep expensive API-response caches in Redis across deployments.
- Combine Redis speed with pcb's survive-a-rebuild behavior.
- Flush a Redis permanent bin explicitly with `drush pcbf <bin>` (parent command).
- List Redis permanent bins with `drush pcb-list`.
- Clear a Redis permanent bin from the Performance admin page button.
- Programmatically clear with `\Drupal::service('cache.<bin>')->deleteAllPermanent()`.
- Avoid recomputing costly data after each cache clear on a Redis-based stack.
- Use cache tags/expiry on Redis-stored permanent data as normal.
- Offload permanent caches off the database onto Redis to reduce DB load.
- Share a permanent cache across multiple web nodes via a central Redis server.
- Keep inventory/pricing lookups warm in Redis independent of Drupal cache rebuilds.
- Migrate a database permanent bin to Redis by changing only the backend service.
- Ensure Redis-stored integration state persists through routine `drush cr`.
- Provide predictable, explicit purging of Redis permanent bins for ops.
