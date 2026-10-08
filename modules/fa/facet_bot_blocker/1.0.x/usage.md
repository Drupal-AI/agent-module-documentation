Facet Bot Blocker stops crawlers that hammer a site with ever-deeper faceted-search URLs (`f[0]`, `f[1]`, `f[2]`, …) by returning a 403 or 410 response once the `f[]` query array reaches a configured depth.

---

The module registers a single kernel `REQUEST` event subscriber (priority 101) that runs early on every main request. It reads the configured facet-parameter limit and, if the incoming request has a `f[<limit>]` query-array index set (i.e. the visitor has drilled at least `limit` facets deep), it short-circuits the request with a `Response` — HTTP 403 Forbidden by default, or 410 Gone if `facet_bot_blocker_return_gone` is enabled — carrying a configurable HTML message, and stops propagation so Drupal never renders the expensive faceted page. Users with the `bypass facet bot blocker` permission are never blocked. When either the Memcache or Redis module is installed, the module additionally caches its config values and keeps lightweight counters (blocked/allowed request totals, last blocked IP/path/User-Agent, metrics start time) that a dashboard at `/admin/reports/facet-bot-blocker` displays; without an in-memory cache backend those counters are not tracked. Settings live in `facet_bot_blocker.settings` and are edited at `/admin/config/system/facet-bot-blocker`. The module ships no default config, no schema, and no Drush commands; it defines three permissions.

---

- Block bots that crawl deep facet combinations like `?f[0]=…&f[1]=…&f[2]=…`.
- Cap faceted-search URL depth to protect Search API / Facets pages from crawler load.
- Return `410 Gone` for excessive facet URLs so search engines drop them from their index.
- Return `403 Forbidden` (default) for over-limit facet requests.
- Reduce database/CPU load caused by bots requesting endless facet permutations.
- Improve SEO by discouraging indexing of low-value deep-facet URLs.
- Set the block threshold to `1` to allow only a single active facet at a time.
- Allow two facets but block the third by setting the limit to `2`.
- Show a custom branded "Excessive crawling detected" HTML message to blocked clients.
- Let trusted users or roles keep browsing deep facets via the `bypass facet bot blocker` permission.
- Grant editors read-only access to blocking metrics via the dashboard permission.
- Monitor how many requests are being blocked vs allowed on the dashboard (with Memcache/Redis).
- See the last blocked IP, path, and User-Agent for tuning (with Memcache/Redis).
- Store counters and config in memory with Redis/Memcache for high-traffic sites.
- Protect a faceted product catalog from crawler-induced slowdowns.
- Mitigate a facet-based denial-of-service crawl without editing robots.txt.
- Keep legitimate shallow faceting working while cutting off deep drill-downs.
- Deploy the block sitewide without touching individual Views or facet configs.
- Tune the depth per environment by overriding `facets_bot_blocker_limit` in config.
- Combine with rate limiting for layered crawler defense.
- Swap the response code between 403 and 410 depending on SEO strategy.
- Provide a maintenance-friendly toggle by uninstalling to remove the block entirely.
- Export the block threshold as config for repeatable deployments.
