<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preserve page cache keeps anonymous page-cache entries alive longer by discarding most cache tags when storing them, so pages expire on a time basis (max-age) instead of being invalidated by tag flushes.

---

On high-traffic sites, broad cache-tag invalidations (e.g. any config or menu change) can wipe large swaths of the anonymous page cache, causing traffic spikes to the backend. This module swaps the core `http_middleware.page_cache` service class for its own `NoTagsPageCache` (via a `ServiceProvider::alter()`), overriding `set()` so that when a cached response is written, the cache tags are dropped. If the response has a positive `max-age`, the entry's expiry is set to request time plus that max-age, so entries expire on a timer rather than via tag invalidation. To preserve the most common editorial workflow, it inspects the request path (resolving aliases through `path_alias`) and, if it matches `node/<id>`, keeps just that single `node:<id>` tag so editing a node still clears its page.

Operational/security consideration: because most tags are removed, changes that would normally invalidate anonymous pages (permissions, blocks, config, menus, other entities) will NOT immediately clear cached pages — those pages remain served until their max-age expires. Only the node-page case retains tag-based invalidation. Evaluate this trade-off carefully on sites where anonymous visibility of a change must be immediate. There are no routes, permissions, forms, or user input — configuration is simply enabling the module (and tuning your responses' max-age/Cache-Control).
---
- Reduce backend load from frequent cache-tag invalidations
- Serve anonymous pages from cache until max-age expiry
- Prevent a config/menu change from flushing the whole page cache
- Keep node-page invalidation working when editing a node
- Stabilize cache hit rates on high-traffic anonymous sites
- Trade instant invalidation for cache longevity intentionally
- Pair with sensible max-age / Cache-Control on responses
- Smooth traffic spikes after content or config edits
- Offload origin during campaigns or news events
- Use behind a reverse proxy/CDN as an origin-shield strategy
- Avoid thundering-herd cache clears
- Keep the standard page_cache module behavior otherwise
- Enable purely via module install (no config UI)
- Audit which content must invalidate immediately before enabling
- Keep node-edit invalidation while dropping other tags
- Reduce cache-clear churn on config-heavy editorial sites
- Tune longevity by adjusting response max-age headers
