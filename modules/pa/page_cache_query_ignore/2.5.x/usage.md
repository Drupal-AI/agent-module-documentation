Page Cache Query Ignore makes Drupal's anonymous Internal Page Cache treat URLs that differ only by certain query parameters (e.g. `?gclid=…`, `?utm_source=…`) as the same page, so tracking/marketing query strings no longer fragment the cache.

---

The module swaps core's `http_middleware.page_cache` service (the `page_cache` module's `PageCache` stack middleware) for its own `PageCacheIgnore` subclass via a `ServiceProvider::alter()`. `PageCacheIgnore` overrides `getCacheId()` so that, before the cache key is computed, the request URI's query string is normalized: parameters are parsed with `UrlHelper`, filtered according to the configured list, re-sorted (`ksort`) to minimize variants, and rebuilt. The single settings form (route `page_cache_query_ignore.admin`, under *Configuration → Development → Performance*) stores three keys in `page_cache_query_ignore.settings`: `query_parameters` (a newline list of parameter names), `ignore_action` (`exclude` = strip the listed params, or `include` = keep only the listed params and drop everything else), and `ignore_redirects` (a boolean). Two extension points let other modules adjust the list dynamically: the `hook_page_cache_query_ignore_parameters_alter()` alter hook and two events, `PageCacheQueryIgnoreEvents::PARAMETERS` (mutate the parameter list) and `PageCacheQueryIgnoreEvents::QUERY` (normalize the parsed query, e.g. filter values inside bracket arrays like `?f[0]=alias:value`). When `ignore_redirects` is on, redirect responses are cached under core's original (unstripped) cache key so modules that depend on the real query string to compute a redirect target keep working. The effect applies only to the anonymous page cache; it is not a replacement for a properly configured CDN.

---

- Stop Google Ads `gclid` query parameters from creating a separate cache entry for every ad click.
- Collapse all UTM-tagged variants (`utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`) of a landing page into one cached page.
- Ignore Facebook's `fbclid` click identifier so social traffic hits the same cached page as direct traffic.
- Ignore Microsoft/Bing `msclkid` tracking parameters in the page cache key.
- Shrink the anonymous page cache footprint by removing high-cardinality tracking parameters from cache keys.
- Improve cache hit-rate on marketing campaign pages that are heavily linked with tracking query strings.
- Configure an allowlist instead: keep *only* meaningful parameters (e.g. `page`, `sort`) in the cache key and drop all others by setting the action to "include".
- Normalize parameter ordering so `?a=1&b=2` and `?b=2&a=1` share one cache entry (the module `ksort`s the query).
- Reduce origin load where a CDN is not available or not desired.
- Ignore HubSpot tracking parameters (`_hsenc`, `_hsmi`, `hsCtaTracking`, …) for cache purposes.
- Ignore LinkedIn (`li_fat_id`) and generic `ref` referral parameters.
- Keep redirect responses correct while stripping query params by enabling "Ignore redirects".
- Let a custom module add tracking parameters to the ignore list at runtime via `hook_page_cache_query_ignore_parameters_alter()`.
- Contribute a dynamic, environment-specific parameter list by subscribing to `PageCacheQueryIgnoreEvents::PARAMETERS`.
- Filter values inside faceted-search bracket arrays (`?f[0]=…`) for cache keys by subscribing to `PageCacheQueryIgnoreEvents::QUERY`.
- Deploy a curated ignore list as exported config (`page_cache_query_ignore.settings.yml`) across environments.
- Prevent cache-busting from arbitrary appended query strings on shared/emailed links.
- Serve a single cached homepage regardless of appended analytics parameters.
- Cut cache storage growth on high-traffic anonymous sites drowning in query-string variants.
- Standardize which query parameters are cache-relevant across a multisite via shared config.
- Combine with core Internal Page Cache to boost anonymous throughput without a reverse proxy.
- Whitelist pagination and filter parameters while ignoring everything else on a catalog/listing page.
- Audit and document exactly which query parameters affect the anonymous cache on a site.
