<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Purge Uncacheable Tags Headers makes Drupal emit Purge's cache-tags response headers even on responses Drupal itself marks uncacheable, so an upstream shared cache (CDN/reverse proxy) that overrides the caching decision can still see and later invalidate those tags.

---

By default Purge's own response subscriber only attaches its tags-header plugins to cacheable responses. This module adds a `RESPONSE`-event subscriber (`UncacheableResponseSubscriber`, wired with `@purge.tagsheaders`) that runs on the main request and, when the response is a `CacheableResponseInterface` carrying a `no-cache` Cache-Control directive, iterates every enabled Purge tags-header plugin and sets its header from the response's cacheable metadata tags. Each plugin decides its own header name and value formatting; the subscriber sanity-checks that the header name is a non-empty string (throwing a `LogicException` otherwise). The typical use cases are `POST` GraphQL requests (never cacheable in Drupal) and setups where the real caching decision is made in an upstream shared cache.

It has no configuration, routes, permissions, or admin UI — install Purge, configure a tags-header plugin (e.g. the Cache-Tags header for your proxy), enable this module, and the headers begin appearing on no-cache responses. Note this exposes cache-tag headers on more responses than core does; if your tags-header plugin's output is considered sensitive, restrict it at the edge as you would for cacheable responses. There is no request-data handling, external calls, or mutating endpoint.
---
- Emit cache-tags headers on POST GraphQL responses for edge invalidation
- Let an upstream CDN cache and later purge Drupal no-cache responses
- Surface Purge tags headers when caching is overridden upstream
- Attach the Cache-Tags header to uncacheable responses
- Support a reverse-proxy that makes its own caching decisions
- Reuse existing Purge tags-header plugin configuration on no-cache responses
- Enable tag-based invalidation for dynamic/personalised endpoints at the edge
- Keep header naming/formatting driven by the chosen Purge plugin
- Add tags headers only to main requests (not sub-requests)
- Only act on responses explicitly marked no-cache
- Pair with a Varnish/Fastly tags-header plugin
- Provide invalidation metadata for decoupled front-end API calls
- Avoid custom code to expose tags on uncacheable responses
- Debug which cache tags a dynamic response carries via headers
- Extend Purge's header behaviour without patching Purge
- Support GraphQL-driven decoupled sites needing tag invalidation
- Ensure LogicException surfaces a misconfigured tags-header plugin
- Keep behaviour config-free (just enable the module)
- Complement, not replace, Purge's cacheable-response header handling
- Restrict tag-header exposure at the edge if tags are sensitive
