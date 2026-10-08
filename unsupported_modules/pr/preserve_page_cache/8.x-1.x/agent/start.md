<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preserve page cache (preserve_page_cache) — agent index

**Overrides the core page-cache middleware so anonymous cache entries expire by max-age and drop most cache tags (keeping only `node:<id>` for node pages).**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Dependencies:** page_cache, path_alias
- **Mechanism:** `NoTagsPageCacheServiceProvider::alter()` sets `http_middleware.page_cache` class to `NoTagsPageCache`.
- **Behavior:** `NoTagsPageCache::set()` drops tags; if response max-age > 0, expiry = request time + max-age; if path resolves to `node/<id>`, retains only `node:<id>`.
- **Config:** none — enable the module.

**Security:** No routes, permissions, forms, or user input. Operational caveat (not a vuln): removing cache tags means most changes (permissions, blocks, config, non-node entities) will not immediately invalidate anonymous cached pages — they persist until max-age expiry; only node pages keep tag invalidation. Review before enabling where immediate anonymous visibility of changes is required.

See [extend/middleware.md](extend/middleware.md)
