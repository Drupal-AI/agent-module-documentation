CacheAlter changes how Drupal's anonymous page cache is keyed: it strips UTM/click-id query parameters so ad-referral URLs share one cache entry, and it appends a `cache_context` cookie value to the cache id so a site can serve different anonymous static caches per cookie.

---

The module ships two HTTP stack middlewares and a service provider — no admin UI, routes, permissions, config, or database. `ClearRequest` (an `http_middleware` at priority 450, so it runs before core's page cache at priority 200) removes the marketing query keys `utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`, `gclid`, `yclid`, `ysclid` from both `$request->query` and the rebuilt `REQUEST_URI`/`QUERY_STRING`; because this happens at the very start of the request, the cleaned query flows through the whole render pipeline (including `dynamic_page_cache`). `CacheAlterServiceProvider` swaps core's `http_middleware.page_cache` class for `CacheAlter`, which overrides `getCacheId()` to build the anonymous page-cache id from scheme+host+`REQUEST_URI`, the request format, and the value of a `cache_context` cookie. The net effect: better cache hit-rate for campaign traffic, plus a lightweight per-cookie cache-variation mechanism (for example, "selected city"). It only affects the anonymous page cache (`page_cache`); authenticated users, who bypass that cache, are unaffected. Note the module declares no `dependencies` in its info.yml even though `CacheAlter` extends `page_cache`'s `PageCache` class, so the cookie-key feature is only active when the core Internal Page Cache module is enabled.

---

- Serve one shared `page_cache` entry for a page reached via many different UTM-tagged ad links.
- Improve anonymous cache hit-rate for landing pages linked from Google/Yandex ads.
- Strip `gclid` (Google click id) from the URL used as the cache key.
- Strip `yclid` / `ysclid` (Yandex click ids) from the cache key.
- Prevent campaign-parameter URL fragmentation from bloating the page-cache backend.
- Keep `dynamic_page_cache` from varying on tracking parameters by cleaning the query early.
- Vary the anonymous static cache by a `cache_context` cookie value (e.g. a chosen city/region).
- Serve region-specific anonymous pages from cache by setting `cache_context=paris` vs `=berlin`.
- Give an anonymous "store locator" or "current city" banner distinct cached variants per cookie.
- Reduce origin render load for high-traffic anonymous marketing campaigns.
- Normalize referral URLs so analytics-tagged and untagged visits hit the same cached HTML.
- Deploy a UTM-stripping cache layer without writing custom middleware.
- Add a cookie-based cache dimension without registering a custom Drupal cache context and render-cache plumbing.
- Consolidate cache entries for newsletter links that append `utm_*` parameters.
- Reduce cache-key cardinality caused by paid-search and social-share query strings.
- Pair with a CDN by having Drupal's own page cache ignore tracking params.
- Run as a drop-in performance module on Drupal 10 or 11 with no configuration step.
- Understand or audit how an inherited site rewrote its anonymous page-cache key.
- Decide whether to keep the module: it is only useful when the core Internal Page Cache (page_cache) module is enabled and the site relies on cookie-based anonymous variation.
