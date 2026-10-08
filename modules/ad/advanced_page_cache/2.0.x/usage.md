<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Internal Page Cache lets modules extend Drupal core's internal page cache by adding contextual parts to the cache id used for anonymous users.

---
Core's `page_cache` module caches a full HTML response per URL for anonymous visitors, but the cache id is essentially just the URL — there is no supported hook to make one path cache several variants based on request context. This module adds that extension point.

It uses the service-collector pattern: `AdvancedPageCacheService` collects every service tagged `advanced_page_cache_cid`, and each such service's `getAdditionalCacheIdPart()` output is folded into the id built by the `AdvancedPageCache` stack middleware. A custom module implements `AdvancedPageCacheInterface`, returns a string part (a cookie value, a country, a device class…), and registers the tagged service. Two example submodules ship with it: `cookie_page_cache` varies the cache by a cookie, and `ip_page_cache` varies it by client IP. Because each added part multiplies the number of cached variants per URL, high-cardinality parts (like raw IP) can bloat the bin and lower hit rates, so parts should key on bounded, normalized values.

Setup: ensure core `page_cache` is enabled, enable this module, then either enable an example submodule or add your own service tagged `advanced_page_cache_cid`.
---
- Cache multiple anonymous variants of a single URL
- Vary the anonymous page cache by a cookie value (cookie_page_cache)
- Vary the anonymous page cache by client IP (ip_page_cache)
- Add a custom contextual part to the page cache id
- Cache per country or region for anonymous users
- Cache per device or browser class for anonymous users
- Cache per A/B-test bucket held in a cookie
- Cache per currency or locale cookie
- Extend core `page_cache` without patching core
- Register a cache-id contributor via a tagged service
- Implement `AdvancedPageCacheInterface::getAdditionalCacheIdPart()`
- Reuse the service-collector pattern for cache variation
- Keep full-page caching for anonymous traffic while adding context
- Enable the bundled `cookie_page_cache` example submodule
- Enable the bundled `ip_page_cache` example submodule
- Combine several cache-id parts from different modules
- Normalize a high-cardinality value before using it as a cache part
- Study the example submodules as reference implementations
- Improve anonymous cache hit rates on context-sensitive pages
- Avoid disabling page cache just to support one contextual variation
