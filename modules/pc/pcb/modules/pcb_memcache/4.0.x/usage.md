<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
pcb_memcache is a submodule of Permanent Cache Bin that provides a Memcache-backed permanent cache backend, so a bin stored in Memcache is not wiped by `drush cr`.

---

The submodule is a thin glue shim: it registers one service, `cache.backend.permanent_memcache`, whose factory `PermanentMemcacheBackendFactory` extends the Memcache module's backend factory and produces a `PermanentMemcacheBackend`. That backend combines the Memcache module's cache implementation with pcb's `PermanentBackendTrait`, meaning `deleteAll()` (called during a cache rebuild) is a no-op while `deleteAllPermanent()` explicitly clears the Memcache bin. You use it exactly like the database variant but point the bin at `cache.backend.permanent_memcache` instead of `cache.backend.permanent_database`. It requires the contrib **Memcache** module (`memcache:memcache >= 2.0`) and the parent **pcb** module, and of course a working Memcache server configured for Drupal. It adds no config, no UI, no permissions, and no Drush commands of its own — the parent pcb Drush commands (`pcbf`, `pcb:flush-all`, `pcb-list`) operate on its bins.

---

- Store an external-data cache in Memcache that survives `drush cr`.
- Back a high-traffic permanent bin with Memcache instead of the database for speed.
- Register a `cache.<bin>` service using `default_backend: cache.backend.permanent_memcache`.
- Point an existing bin at Memcache permanence via `$settings['cache']['bins']['<bin>'] = 'cache.backend.permanent_memcache'`.
- Keep expensive API-response caches in Memcache across deployments.
- Combine Memcache speed with pcb's survive-a-rebuild behavior.
- Flush a Memcache permanent bin explicitly with `drush pcbf <bin>` (parent command).
- List Memcache permanent bins with `drush pcb-list`.
- Clear a Memcache permanent bin from the Performance admin page button.
- Programmatically clear with `\Drupal::service('cache.<bin>')->deleteAllPermanent()`.
- Avoid recomputing costly data after each cache clear on a Memcache-based stack.
- Use cache tags/expiry on Memcache-stored permanent data as normal.
- Offload permanent caches off the database onto Memcache to reduce DB load.
- Share a permanent cache across multiple web nodes via a central Memcache server.
- Keep inventory/pricing lookups warm in Memcache independent of Drupal cache rebuilds.
- Migrate a database permanent bin to Memcache by changing only the backend service.
- Ensure Memcache-stored integration state persists through routine `drush cr`.
- Provide predictable, explicit purging of Memcache permanent bins for ops.
