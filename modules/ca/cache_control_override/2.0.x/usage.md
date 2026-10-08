<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Control Override makes Drupal's `Cache-Control: max-age` header reflect the **cacheability metadata that actually bubbled up** during the response, instead of always emitting the global "Browser and proxy cache maximum age" value, and it stops responses whose bubbled max-age is `0` from being stored in the internal page cache.

---

The module has no UI, no permissions and no plugins — it is two services. `CacheControlOverrideSubscriber` subscribes to `KernelEvents::RESPONSE`; on the main request, for responses implementing `CacheableResponseInterface` that core's `FinishResponseSubscriber` already marked `public` with a `max-age` directive, it reads `$response->getCacheableMetadata()->getCacheMaxAge()` and rewrites the header to `Cache-Control: public, max-age=<bubbled value>`. A bubbled max-age of `Cache::PERMANENT` (`-1`) is treated as "no opinion" and left alone, so pages with fully permanent cacheability keep the site-wide `system.performance:cache.page.max_age`. When the bubbled value is greater than `0` it is clamped by two settings: `cache_control_override.settings:max_age.minimum` raises it (`max()`) and `max_age.maximum` lowers it (`min()`, unless it is `-1`, which disables the ceiling). The second service, `DenyOnCacheControlOverride`, is tagged `page_cache_response_policy` and returns `DENY` whenever the bubbled max-age is exactly `0`, keeping uncacheable responses out of the Internal Page Cache. Default config is `max_age: {minimum: 0, maximum: -1}` — i.e. clamping effectively disabled, so out of the box the module only *propagates* the real max-age. Both classes are marked `@internal`; the documented extension route is decorating the service or subscribing to `kernel.response` at a higher priority and calling `stopPropagation()`.

---

- Let a node with a `max-age: 300` render element actually be cached for 300 seconds at the CDN instead of the site default.
- Emit a short `Cache-Control` for pages containing time-sensitive content (countdowns, stock levels, live scores).
- Emit the full site-wide max-age for pages whose cacheability is permanent, without hand-tuning routes.
- Stop pages that bubbled `max-age: 0` from being stored in Drupal's Internal Page Cache.
- Give a Varnish or Fastly layer per-page TTLs derived from real Drupal cacheability metadata.
- Prevent a badly behaved contrib module's `max-age: 60` from shrinking every page's TTL below a floor you choose.
- Enforce a floor of 300 seconds on all dynamic pages so a CDN is never hammered.
- Enforce a ceiling of one hour so no page can be cached longer than your purge tooling can guarantee.
- Debug which pages are actually uncacheable by watching for `max-age=0` in the response headers.
- Combine with `system.performance:cache.page.max_age` so permanent pages get the long TTL and dynamic pages get a short one.
- Make a personalised block's `max-age` visible at the edge instead of being silently swallowed.
- Give an anonymous-only marketing site aggressive edge caching while keeping cart pages uncached.
- Ship a per-environment ceiling (short in staging, long in production) via config split.
- Let a Views page with a "published in the last hour" filter advertise a matching short TTL.
- Ensure a page rendering a countdown timer with `max-age` from a lazy builder does not get cached for a day.
- Ensure an API-ish controller returning a `CacheableResponse` propagates its own max-age to proxies.
- Combine with Purge so that TTL and invalidation strategies agree.
- Avoid writing a custom `kernel.response` subscriber in every project that needs this behaviour.
- Diagnose "why is my page cached for 31536000 seconds?" by reading the bubbled metadata the module now surfaces.
- Keep the internal page cache from serving a stale personalised page after a module bubbles `max-age: 0`.
- Provide a deterministic, config-driven Cache-Control policy that can be reviewed in code review.
- Decorate the subscriber in a custom module to add per-route exceptions on top of the global clamps.
