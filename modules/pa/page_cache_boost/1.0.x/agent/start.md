<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Cache Boost (page_cache_boost) — agent index

**Serves stale anonymous page-cache entries with a low TTL and rebuilds them behind a lock (stampede protection).**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 — requires core `page_cache`.
- **Mechanism:** decorates `http_middleware.page_cache` with `StackMiddleware\PageCacheBoost`.
- **Tuning (`$settings`):** `page_cache_boost.stale_response_ttl` (10s), `page_cache_boost.lock_timeout` (30s).
- No routes, permissions, or admin UI.

**Security:** Middleware only affects anonymous page caching; no user-input sinks or endpoints. No security findings.
