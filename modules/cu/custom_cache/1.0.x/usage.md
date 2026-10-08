<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom cache provides a database cache backend that imposes a maximum lifetime on items Drupal marks as permanent, configured entirely from settings.php.

---

Drupal's `CACHE_PERMANENT` means "keep until invalidated", and it is correct when invalidation is correct. The failure mode is a cache tag that never fires — a hook that was supposed to invalidate and does not, a third-party integration whose data changed without Drupal knowing, a bug — and the result is a permanent item that is permanently wrong. Nothing expires it, so the only fix is a manual cache clear, and the symptom is stale content nobody can explain.

Custom cache ships a single service, `cache.backend.custom_cache` (`Drupal\custom_cache\CustomCacheBackendFactory` returning `CustomCacheDatabaseBackend`), that you assign to specific cache bins in `settings.php`. On write it caps any permanent item's lifetime to `custom_cache_melt_time` seconds (default 86400 / one day), so a missed invalidation self-corrects within the cap instead of never. A `custom_cache_exclude_cids` list lets you keep chosen cids at their original (permanent) lifetime, and a `hook_custom_cache_cid_alter` hook lets modules adjust cache IDs. There is no admin UI, no permissions, no routes, and no module dependencies — installation is `composer require drupal/custom_cache`, enable the module, then add the settings.

**It is a mitigation, not a fix, and should be described as one.** A site relying on a cap to hide broken invalidation has a bug it is no longer seeing, and the cap makes it intermittent rather than absent — which is harder to diagnose, not easier. The right use is as a safety net on a site where some data comes from outside Drupal's invalidation reach, with the cap set long enough that it does not mask a real problem. The performance trade is straightforward: a shorter cap means more recomputation, so set it against how long stale data is acceptable, not against how often you want cache misses.

---

- Cap how long a permanent cache item is allowed to live.
- Set the TTL cap with `$settings['custom_cache_melt_time'] = 86400;`.
- Assign the backend to a bin: `$settings['cache']['bins']['render'] = 'cache.backend.custom_cache';`.
- Apply it to the `dynamic_page_cache` and `page` bins as well.
- Keep chosen cids permanent with `$settings['custom_cache_exclude_cids'] = ['/node/', '/user/'];`.
- Shrink an ever-growing `cache_*` table on a site with many nodes.
- Self-correct after a missed cache-tag invalidation.
- Hedge against a cache tag that never fires.
- Handle data that changes outside Drupal's knowledge (third-party integrations).
- Avoid permanently wrong cached content on a long-lived site.
- Adjust cache IDs from another module via `hook_custom_cache_cid_alter()`.
- Choose the cap against acceptable staleness rather than cache-miss frequency.
- Trade extra recomputation for bounded staleness.
- Roll the backend out per bin without touching module code.
- Remove the cap cleanly by reverting the settings.php lines (no schema/config to undo).
- Audit which bins currently use the custom backend during a site review.
- Investigate why a cached item never invalidated on its own.
- Plan caching strategy for content sourced from external systems.
- Bound database cache growth without switching to Redis/Memcache.
- Document the backend swap and its cap for the team.
- Verify the cap's assumptions after a Drupal core upgrade.
- Understand that the backend extends core `DatabaseBackend`, so it stores in the same cache tables.
