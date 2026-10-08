<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `crawlers_cache_context` cache context

## Install / enable

- `composer require drupal/crawlers_cache_context` (pulls `jaybizzle/crawler-detect ^1.2`), then
  `drush en crawlers_cache_context`. No configuration, no permissions, no settings form.
- Once enabled, the cache-context token **`crawlers_cache_context`** is available to any render array
  or block. Nothing else needs wiring.

## Services (`crawlers_cache_context.services.yml`)

- `cache_context.crawlers_cache_context` — class `Drupal\crawlers_cache_context\CrawlersCacheContext`,
  args `['@request_stack', '@crawlers_cache_context.crawler_detect']`, tag `{ name: cache.context }`.
  The `cache_context.` service-name prefix + the `cache.context` tag are what make the token usable as
  `crawlers_cache_context` in `#cache['contexts']`.
- `crawlers_cache_context.crawler_detect` — class `Jaybizzle\CrawlerDetect\CrawlerDetect` (the injected
  detector). No arguments; uses the library's bundled crawler User-Agent list.

## Class `CrawlersCacheContext` (`src/CrawlersCacheContext.php`)

Implements both `CalculatedCacheContextInterface` (parameterised) and `CacheContextInterface`.

- `getContext($parameter = NULL)`:
  - `$user_agent = requestStack->getCurrentRequest()->headers->get('user-agent')`.
  - `$parameter === NULL`: `crawlerDetect->isCrawler($user_agent)` → `'crawler'`, else fall through to
    `'not-crawler'`.
  - `$parameter` given: if `isCrawler(...)`, compute `$matches = crawlerDetect->getMatches()` (the matched
    crawler substring, per the library), `$lower_name = mb_strtolower($matches)`; return
    `'crawler.' . $lower_name` **only if** `$matches && $lower_name == $parameter`; otherwise `'not-crawler'`.
- `getCacheableMetadata($parameter = NULL)` → empty `CacheableMetadata` (no added cache tags or max-age;
  the context itself is not time- or entity-sensitive).
- `getLabel()` (static) → `t('Crawlers cache context')`, shown in cache-context listings.

### Returned values (the cache keys)

| Call | Detected crawler? | Result |
|------|-------------------|--------|
| `crawlers_cache_context` | yes | `crawler` |
| `crawlers_cache_context` | no  | `not-crawler` |
| `crawlers_cache_context:googlebot` | yes, match lower-cases to `googlebot` | `crawler.googlebot` |
| `crawlers_cache_context:googlebot` | yes, but match is a different bot | `not-crawler` |
| `crawlers_cache_context:googlebot` | no  | `not-crawler` |

The value is always one of `crawler`, `not-crawler`, or `crawler.` + your own `$parameter`. It is a
normalised token derived from the CrawlerDetect match, not the raw User-Agent — so the cache-key space
this context can produce is bounded and does not echo arbitrary request input.

## Usage patterns

- General split (crawler vs. everyone):
  ```php
  '#cache' => ['contexts' => ['crawlers_cache_context']],
  ```
- Single named bot (only Googlebot gets the crawler variant; the `:name` must match the CrawlerDetect
  match lower-cased):
  ```php
  '#cache' => ['contexts' => ['crawlers_cache_context:googlebot']],
  ```
- Combine with other contexts on the same element, e.g.
  `['url.path', 'crawlers_cache_context']`, so each crawler/visitor variant is still cached per path.

## Operational notes

- Detection is a User-Agent heuristic (spoofable by any client). Treat it as an SEO/performance aid,
  never as access control or authentication.
- Keep crawler variants benign to avoid cloaking penalties.
- Verify the exact `:name` value against the CrawlerDetect match for your target bot; a wrong name simply
  falls back to `not-crawler` (the element is cached/served as for a normal visitor).

## Tests

- `tests/src/Kernel/ContextMatchTest.php` — sets `user-agent` on the request and asserts
  `getContext()` results: plain UA → `not-crawler`; `googlebot` → `crawler`; `googlebot` with parameter
  `bingbot` → `not-crawler`; `googlebot` with parameter `googlebot` → `crawler.googlebot`.
- `tests/src/Kernel/EnableTest.php` — module install/enable smoke test.
