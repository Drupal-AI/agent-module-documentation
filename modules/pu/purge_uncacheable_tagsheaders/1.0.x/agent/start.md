<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge Uncacheable Tags Headers (purge_uncacheable_tagsheaders) — agent index

**Emits Purge's cache-tags response headers on uncacheable (no-cache) responses so an upstream shared cache can still invalidate them.**

- **Version:** 1.0.x  •  core: `^9.5 || ^10 || ^11`  •  depends on `purge (>= 8.x-3.3)`.
- **Service:** `purge_uncacheable_tagsheaders.tagsheaders.uncacheable_response_subscriber` (`UncacheableResponseSubscriber`, arg `@purge.tagsheaders`) — an `event_subscriber` on `KernelEvents::RESPONSE`.
- **Behaviour:** on the main request, if the response is `CacheableResponseInterface` with a `no-cache` Cache-Control directive, iterates enabled Purge tags-header plugins and sets each plugin's header from the response's cache tags. Throws `LogicException` on an empty header name.
- **No config, routes, permissions, or admin UI.** Just enable it after configuring a Purge tags-header plugin.
- **Security:** no request-data handling, no external calls, no mutating endpoint; it only adds response headers already computed by Purge plugins. (Exposes tag headers on more responses than core — restrict at the edge if tags are sensitive.) No security findings.
