<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crawlers cache context (crawlers_cache_context) — agent index

A single **calculated cache context** that varies rendered/cached output depending on whether the
current request is from a **detected crawler/bot**. No UI, no routes, no permissions, no config, no
hooks, no submodules. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 8.x-1.x (installed 8.x-1.1).

- **The context service, its values, how to attach it, and the parameterised form** →
  [api/cache-context.md](api/cache-context.md)

## What it actually is

- One service `cache_context.crawlers_cache_context` → class `CrawlersCacheContext`
  (`src/CrawlersCacheContext.php`), tagged `{ name: cache.context }`, so the context token is
  **`crawlers_cache_context`**. Implements `CalculatedCacheContextInterface` and
  `CacheContextInterface` — the calculated form accepts a parameter (`crawlers_cache_context:<name>`).
- A second service `crawlers_cache_context.crawler_detect` wraps `Jaybizzle\CrawlerDetect\CrawlerDetect`
  (Composer lib `jaybizzle/crawler-detect ^1.2`) and is injected as the detector.
- Constructor args: `@request_stack`, `@crawlers_cache_context.crawler_detect`.

## Mechanism (from source)

- `getContext($parameter = NULL)` reads `request_stack->getCurrentRequest()->headers->get('user-agent')`.
  - No parameter: returns **`crawler`** if `crawlerDetect->isCrawler($ua)`, else **`not-crawler`**.
  - With a parameter: only when `isCrawler($ua)` is true, it takes `crawlerDetect->getMatches()`
    (the matched crawler substring), lower-cases it, and returns **`crawler.<name>`** *only if*
    that lower-cased match `== $parameter`; otherwise **`not-crawler`**.
- `getCacheableMetadata()` returns an empty `CacheableMetadata` (the context adds no extra tags/max-age).
- `getLabel()` → t('Crawlers cache context').
- The returned context value is one of a **bounded set** (`crawler`, `not-crawler`, or
  `crawler.` + the developer-supplied `$parameter`) — it is a normalised token, not the raw header.

## How to use (from code)

```php
$build['next'] = [
  '#type' => 'link',
  '#url' => $some_url,
  '#title' => $this->t('Next page'),
  '#access' => $access,
  '#cache' => [
    // General crawlers vs. everyone else.
    'contexts' => ['crawlers_cache_context'],
    // …or narrow to one bot: 'crawlers_cache_context:googlebot'.
  ],
];
```

## Notes / caveats

- Detection is **User-Agent-based** (a heuristic; any client can send any UA) — it is a
  performance/SEO primitive, **not** access control. Do not gate security-sensitive logic on it.
- Varying content for crawlers should stay benign to avoid **cloaking** (serving search engines
  materially different content than users), which search engines penalise.
- Tests: `tests/src/Kernel/ContextMatchTest.php` (asserts `googlebot`→`crawler`, `crawler.googlebot`,
  and mismatch→`not-crawler`) and `EnableTest.php`.
