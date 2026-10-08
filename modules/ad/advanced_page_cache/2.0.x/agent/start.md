<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Internal Page Cache (advanced_page_cache) — agent index

**Extends core `page_cache` so modules can append contextual parts to the anonymous page cache id**, letting one URL cache multiple variants.

- **Version:** 2.0.x
- **Core:** `^9 || ^10 || ^11`  · package Performance and scalability
- **Requires:** `drupal:page_cache`.
- **Service:** `advanced_page_cache.service` (`AdvancedPageCacheService`, service collector for tag `advanced_page_cache_cid`); `AdvancedPageCache` stack middleware; `AdvancedPageCacheServiceProvider`.
- **Extension point:** implement `AdvancedPageCacheInterface::getAdditionalCacheIdPart()` and tag your service `advanced_page_cache_cid`.
- **Submodules:** `cookie_page_cache`, `ip_page_cache` (examples).

**Security:** no routes, no permissions, no forms — a pure caching-infrastructure module. Note operationally that a high-cardinality cache-id part (e.g. raw client IP via `ip_page_cache`) can multiply cache entries and reduce hit rates; key on bounded values. No security findings.

See [extend/cache-id.md](extend/cache-id.md)
