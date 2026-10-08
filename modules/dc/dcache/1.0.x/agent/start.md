<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deterministic Cache API (dcache) — agent index

**Developer API that chains cache backends (memory + persistent) for coordination-free lookup-or-generate caching.**

- **Version:** 1.0.x · **Core:** ^9 || ^10 || ^11 · **PHP:** 7.4+
- **Factory:** `dcache.factory` (`DCacheFactory::get(...backends)`) → `DCache` (`src/DCache.php`).
- **Ready service:** `dcache.bin.default_memory_persistent` chains `cache.dcache_default_memory` + `cache.dcache_default_persistent` (database).
- **API:** `lookupOrGenerate(CacheItemGeneratorInterface)`, `lookupOrGenerateMultiple(CacheItemListGeneratorInterface)`; item models `CacheItem` / `CacheItemList`.
- Includes `CoreFix\MemoryCacheFactory` workaround for core issue 2973286.

**Security:** pure developer/service API — no routes, forms, permissions, or external calls; nothing user-facing to expose.

See [api/dcache.md](api/dcache.md)