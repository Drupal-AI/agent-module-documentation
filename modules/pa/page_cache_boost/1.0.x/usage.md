<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Cache Boost improves anonymous page-cache hit rates by serving slightly stale cached pages with a short TTL and regenerating the entry in the background, with lock-based stampede protection.

---


It decorates core's `http_middleware.page_cache` service (`StackMiddleware\PageCacheBoost`) so that when a cache entry is stale it is still served (best-effort) and rebuilt afterwards, while a lock prevents many concurrent requests from rebuilding the same page at once. There is no admin UI — behavior is tuned via `$settings` in settings.php: `page_cache_boost.stale_response_ttl` (default 10s) and `page_cache_boost.lock_timeout` (default 30s). Requires core Page Cache (Internal Page Cache) to be enabled.

Setup: enable core Page Cache + this module; optionally tune the two `$settings` values.
---
- Raise anonymous page-cache hit ratios.
- Serve a stale page while a fresh one is generated.
- Protect against cache stampedes with locks.
- Tune the stale response TTL via `$settings`.
- Tune the rebuild lock timeout via `$settings`.
- Reduce origin load for anonymous traffic spikes.
- Smooth traffic after a cache flush.
- Keep TTLs low while still absorbing bursts.
- Decorate the core page cache middleware transparently.
- Run with zero configuration out of the box.
- Improve perceived performance for anonymous users.
- Combine with a reverse proxy/CDN layer.
- Avoid thundering-herd rebuilds on popular pages.
- Rely on core Page Cache as the storage backend.
- Adjust behavior per environment via settings.php.
- Regenerate entries after serving them stale.
