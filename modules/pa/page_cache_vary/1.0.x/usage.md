<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends Drupal's Internal Page Cache so that cache-context variations are exposed to external caches/CDNs through the HTTP `Vary` header.

Drupal's internal page cache varies responses by cache contexts but does not surface those variations as `Vary` headers, so a CDN or reverse proxy in front of Drupal can't cache the variants correctly. This module replaces the core `page_cache` stack middleware with `PageCacheVary`, which extends core `PageCache`. It introduces a `VaryCacheContextInterface`: any cache context that implements it declares which request header(s) it varies on. A compiler pass (`VaryCacheContextPass` / `VaryCacheContextApplyServicePass`, wired via `PageCacheVaryServiceProvider`) collects those contexts, and the middleware computes and stores the appropriate `Vary` header per URL in a dedicated cache bin (`cache.page_vary_metadata`). Per the HTTP spec, a URL must return the same `Vary` regardless of the variant, so the metadata is stored once per URL and reused; the cache id is then derived from the varied header values.

Installation is just enabling the module (it depends on core `page_cache`) — "enable and profit". To make a context contribute a header, a developer implements `VaryCacheContextInterface` on a cache context service. There is no admin UI, routes, permissions, or config; it is a low-level cache-layer replacement. Care is warranted because it swaps a core middleware service — verify behavior with your CDN and any other page-cache-altering modules.
---
Adds HTTP Vary-header management to Drupal's internal page cache for CDN/proxy correctness.
---
- Emit correct `Vary` headers so a CDN caches per-variant responses.
- Let a reverse proxy vary its cache on the same headers Drupal does.
- Replace core Internal Page Cache with the Vary-aware middleware.
- Expose device/context variations to downstream caches.
- Implement `VaryCacheContextInterface` on a custom cache context.
- Declare which request header a cache context varies on.
- Store per-URL Vary metadata in the `page_vary_metadata` bin.
- Keep a single consistent `Vary` per URL as the spec requires.
- Improve CDN hit rates for context-varied pages.
- Front Drupal with Varnish/Fastly while respecting cache contexts.
- Add header-based variation for a custom "country" cache context.
- Vary cached HTML by a custom request header for A/B setups.
- Audit emitted `Vary` headers in page-cache responses.
- Combine with core page_cache without losing context correctness.
- Enable the module to activate Vary handling site-wide.
- Debug CDN mis-caching caused by missing Vary headers.
- Provide Vary hints for authenticated-vs-anonymous edge caching.
- Register a vary-aware context via a service tag/compiler pass.
- Verify interaction with other page-cache-replacing modules.
- Roll back by disabling the module to restore stock page_cache.