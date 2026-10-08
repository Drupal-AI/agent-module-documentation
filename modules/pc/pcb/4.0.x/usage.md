<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permanent Cache Bin (pcb) provides cache backends whose data is NOT wiped by a normal cache rebuild (`drush cr`), so you can cache expensive external/computed data without it being thrown away on every deploy or cache clear.

---

The module adds a database-backed permanent cache backend, `cache.backend.permanent_database`, plus (via submodules) memcache and redis variants. A permanent backend behaves like a normal cache bin for `get`/`set`/`invalidate`/`delete`, but overrides `deleteAll()` to be a **no-op** — the operation Drupal calls during a full cache rebuild — while adding a separate `deleteAllPermanent()` method that actually clears the bin when you explicitly ask. You opt a bin into permanence either by defining a `cache.<bin>` service tagged with `default_backend: cache.backend.permanent_database`, or in `settings.php` with `$settings['cache']['bins']['<bin>'] = 'cache.backend.permanent_database'`. Once a bin uses pcb, `drush cr` leaves its entries intact; to clear it you use the Drush command `drush pcbf <bin>` (alias of `pcb:flush`), `drush pcb:flush-all` for every permanent bin, or the per-bin "Clear permanent cache for <bin>" buttons that pcb adds to the Performance settings page (`admin/config/development/performance`), or programmatically `\Drupal::service('cache.<bin>')->deleteAllPermanent()`. Cache tags, expiration and normal invalidation all continue to work as usual; only the blanket "delete everything on rebuild" is suppressed. `drush pcb-list` reports which registered bins are using a permanent backend.

---

- Cache data fetched from an external system (stock levels, pricing, API responses) so it survives `drush cr`.
- Keep an expensive computed cache warm across deployments instead of rebuilding it every clear.
- Define a custom cache bin backed by the permanent database backend via a `cache.<bin>` service.
- Point an existing cache bin at the permanent backend from `settings.php`.
- Avoid a thundering-herd of recomputation right after every cache rebuild.
- Explicitly flush one permanent bin with `drush pcbf <bin>` when its source data actually changes.
- Flush every permanent bin at once with `drush pcb:flush-all`.
- List which bins currently use a permanent backend with `drush pcb-list`.
- Clear a permanent bin from the admin UI via the button pcb adds to the Performance page.
- Programmatically clear a permanent bin with `deleteAllPermanent()`.
- Store third-party integration data that should persist independently of Drupal's own caches.
- Cache remote catalog/inventory data that only changes on a schedule, not on every deploy.
- Preserve a warmed render/computed cache for a heavy report between cache rebuilds.
- Use cache tags/expiry on permanent data exactly as with a normal bin.
- Combine with cron to refresh a permanent bin on a controlled cadence.
- Back the permanent bin with memcache instead of the database (pcb_memcache submodule).
- Back the permanent bin with redis instead of the database (pcb_redis submodule).
- Reduce load on a slow upstream API by caching responses permanently until invalidated.
- Keep session-independent, environment-specific caches stable across `drush cr`.
- Ensure a critical lookup table cache is not lost during routine cache clears.
- Give operations a predictable, explicit way to purge external-data caches without a full rebuild.
