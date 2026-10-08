<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crawlers cache context registers a Drupal cache context (`crawlers_cache_context`) so rendered output can be cached and varied depending on whether the current request comes from a detected crawler/bot.

---

Crawlers cache context is a small performance/caching primitive. It registers one calculated cache
context, tagged `cache.context`, backed by the `jaybizzle/crawler-detect` library. Attach the context
`crawlers_cache_context` to any render array (or block) and Drupal will cache and serve one variant for
detected crawlers and another for regular visitors. The parameterised form `crawlers_cache_context:<name>`
(for example `crawlers_cache_context:googlebot`) narrows the variant to a single named crawler, so you can
render an element only for that bot. The context value is one of a small, fixed set (`crawler`,
`crawler.<name>`, or `not-crawler`) computed by normalising the request User-Agent through CrawlerDetect —
it is not the raw header. The module ships no UI, routes, permissions, or configuration; it is used entirely
from code via the `#cache['contexts']` render-array key. Detection is User-Agent-based, so it is a heuristic
(a client can send any User-Agent); use it for benign, index-friendly variations and take care not to serve
crawlers materially different content than users (cloaking), which search engines penalise.

---

- Register the `crawlers_cache_context` cache context for use in render arrays.
- Cache one rendered variant for crawlers and another for regular visitors.
- Vary a block's output depending on whether the visitor is a bot.
- Attach `crawlers_cache_context` to a render array's `#cache['contexts']`.
- Narrow a variant to a single bot with `crawlers_cache_context:googlebot`.
- Show a "next page" pager link to crawlers only while keeping infinite scroll for users.
- Serve a simplified, crawl-friendly version of a page to search engines.
- Omit interactive/JS-heavy elements for detected crawlers.
- Add a crawler-only element for SEO indexing while caching each variant separately.
- Detect crawlers using the maintained `jaybizzle/crawler-detect` User-Agent database.
- Distinguish general crawlers from a specific named crawler in caching.
- Keep the anonymous page cache and dynamic page cache correct across crawler/visitor variants.
- Use `getContext()` values `crawler`, `crawler.<name>`, and `not-crawler` as cache keys.
- Avoid duplicating crawler-detection logic across custom modules.
- Condition render-array output on crawler status without writing UA-parsing code.
- Combine with other cache contexts (route, user.roles) on the same element.
- Provide crawler-aware caching for custom blocks and formatters.
- Support multilingual/multisite setups since it only adds a cache context.
- Serve full paginated result sets to crawlers for better index coverage.
- Understand detection is a spoofable heuristic, not an access-control mechanism.
