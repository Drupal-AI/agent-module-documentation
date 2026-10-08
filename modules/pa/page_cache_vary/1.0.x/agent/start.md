<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internal Page Cache Vary (page_cache_vary) — agent index

**Replaces core Internal Page Cache middleware so cache-context variations are emitted as HTTP `Vary` headers for CDNs/proxies.**

- **Version:** 1.0.x · **Package:** Cache
- **Core:** ^10 || ^11 · **Depends on:** page_cache (core)
- **Mechanism:** `StackMiddleware\PageCacheVary` extends core `PageCache`; `VaryCacheContextInterface` lets a cache context declare varied header(s); compiler passes `VaryCacheContextPass`/`VaryCacheContextApplyServicePass` via `PageCacheVaryServiceProvider`; dedicated cache bin `cache.page_vary_metadata` (`page_vary_metadata`).
- **Config/routes/permissions:** none (enable and it works).

**Security:** no routes, forms, or permissions; a low-level cache-layer replacement. It swaps a core middleware service — validate against your CDN and other page-cache modules. No security findings.

See [extend/vary-context.md](extend/vary-context.md).