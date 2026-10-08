Cache Exclude lets an administrator stop specific pages, paths, or entire content types from being stored in Drupal's anonymous page cache, so genuinely dynamic content stays dynamic.

---

Cache Exclude solves the common problem where Drupal's page cache serves stale output for anonymous users on pages that should change on every request (rotating banners, random quotes, live counters, personalized or time-sensitive blocks). It ships a single settings form at `/admin/config/system/cacheexclude` where you list Drupal paths (one per line, with `*` wildcards and the `<front>` token) and/or tick content types to exclude. A `KernelEvents::REQUEST` event subscriber (`CacheexcludeSubscriber`) runs on every request: it resolves the current path and its URL alias, matches them against your path list with the core path matcher, and also inspects the routed `node` parameter's bundle against your excluded content types. When either matches it fires the core page-cache kill switch (`page_cache_kill_switch`), which prevents that response from being cached — the rest of the site keeps its full caching. The excluded-path list is also checked against the site's configured 404 page. Settings are stored in the `cacheexclude.settings` config object (keys `cacheexclude_list` and `cacheexclude_node_types`) with a fully-validatable schema, and saving the form triggers a full cache flush. The module only requires `path_alias` core, defines no permissions of its own (the form is gated by the core `administer site configuration` permission), and includes Drupal 7 migrate source/process plugins so a legacy site's cacheexclude variables carry over on upgrade.

---

- Keep a page with a rotating promotional banner or hero image uncached so anonymous visitors see fresh content each visit.
- Exclude a "random quote" or "featured item of the day" page from the page cache.
- Prevent caching of a live dashboard, scoreboard, or counter page for anonymous users.
- Stop a personalized landing page from being served identically to every anonymous user.
- Exclude a whole content type (e.g. `event` or `offer`) from caching by ticking it on the settings form.
- Use a wildcard like `blog/*` to exclude every personal blog page from the cache at once.
- Exclude the front page from caching with the `<front>` token when it shows time-sensitive content.
- Exclude a specific path such as `contact` while leaving the rest of the site fully cached.
- Keep A/B-tested or geo-targeted pages out of the anonymous page cache so per-request logic runs.
- Ensure a page that reads request-time data (query string, cookies, headers) is not served from cache.
- Exclude a lottery, giveaway, or countdown page whose content depends on the exact request time.
- Prevent caching of a status/health page that must reflect live system state.
- Keep a currency/exchange-rate or stock-ticker page uncached.
- Exclude API-like or JSON endpoints served through a normal page route from being cached.
- Preserve caching for the entire site while surgically excluding one or two problem URLs.
- Match both a Drupal internal path and its URL alias so an excluded page works under either.
- Exclude the site's configured 404 page from caching.
- Migrate legacy Drupal 7 `cacheexclude_list` / `cacheexclude_node_types` settings into Drupal 11 config during an upgrade.
- Flush all caches automatically whenever exclusion rules change (the form does this on save).
- Give a content editor a simple UI to mark content types as "never cache" without touching code.
- Avoid writing a custom event subscriber/kill-switch just to exclude a handful of pages.
- Combine path-based and node-type-based exclusion rules in a single configuration.
- Troubleshoot "why is my dynamic block stuck" by excluding the offending path from page cache.
- Exclude a coupon or discount-code page whose displayed value must always be current.
