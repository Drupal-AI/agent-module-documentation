Cache URL Query Ignore alters Drupal's 'url' cache context so that configured query parameters are excluded from (or are the only ones included in) the cache key, improving cache hit rates.

---

The module decorates Drupal core's `cache_context.url` service. Every place that varies content by the `url` cache context (internal page cache, dynamic page cache, and render/block caching) computes its key from the request path plus query string. Query parameters that do not change the rendered output — most commonly marketing/tracking params such as `gclid`, `fbclid`, and `utm_*` — otherwise multiply cache entries: `/` and `/?gclid=abc` become two separate entries even though they render identically. By listing such parameters (mode "exclude"), or by declaring the small set of parameters that actually matter (mode "include"), the module collapses those variants to a single cache entry, raising hit rates and shrinking the cache. It ships no dependencies, no permissions of its own, and a single admin config form under Performance. This is the sibling of Page Cache Query Ignore, but affects all usages of the URL cache context rather than only the internal page cache. Correctness depends on configuring it with parameters that genuinely do not affect output for the cached response.

---

- Improve cache hit rates on landing pages that receive lots of `?gclid=...` (Google Ads) traffic.
- Ignore Facebook click IDs (`fbclid`) so paid-social landings share one cache entry.
- Ignore UTM campaign parameters (`utm_source`, `utm_medium`, `utm_campaign`, `utm_term`, `utm_content`) that only feed analytics, not rendering.
- Reduce total cache size on a site whose URLs carry many tracking parameters.
- Serve the same cached homepage regardless of the marketing query string appended by ad networks.
- Ignore an affiliate/referral token (e.g. `ref`, `aff`) that has no effect on the rendered page.
- Ignore an email-tracking parameter (e.g. `mc_cid`, `mc_eid` from Mailchimp) on content pages.
- Consolidate cache entries for social-share links that append their own tracking suffixes.
- Keep only the parameters that matter (mode "include") on a page where nearly every query string is noise except, say, `page`.
- Switch to "include" mode for a listing route so only `page` and `sort` participate in the cache key.
- Lower origin load behind a reverse proxy/CDN by matching Drupal's cache key policy to params you already strip upstream.
- Free up memory in Redis/Memcache render-cache bins by eliminating tracking-param duplicates.
- Reduce dynamic_page_cache bin bloat on high-traffic content pages.
- Improve time-to-first-byte for repeat campaign visitors whose URLs differ only by tracking params.
- Apply one site-wide policy for tracking-parameter handling via a single config object.
- Complement Page Cache Query Ignore by also covering render/block-level caching keyed on `url`.
- Ship the parameter policy as configuration (`cache_url_query_ignore.settings`) so it can be exported and deployed across environments.
- Tune the ignore list per environment (e.g. add a debugging param on staging) through config overrides.
- Prevent cache fragmentation from bot/crawler traffic that appends spurious query parameters.
- Keep analytics intact (parameters still reach the browser/JS) while removing them only from the cache key.
