<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PostHogClient — the HogQL service

`Drupal\analyze_posthog\Service\PostHogClient` (service **`analyze_posthog.client`**). Ctor args:
`@config.factory`, `@cache.default`, `@logger.factory`, `@http_client` (Guzzle), `@key.repository`.
It is the only thing that talks to PostHog; every report path funnels through it.

## Connection

- `resolveKey($keyId)` — loads the Key entity via `key.repository` and returns
  `->getKeyValue()`; the config stores only the key id.
- `isConfigured()` — TRUE when resolved key + `host` + `project_id` are all set.
- `testConnection()` — runs `hogqlQuery('SELECT 1')` and checks it is non-NULL.
- `hogqlQuery(string $query)` — the single HTTP call. Builds
  `POST {host}/api/projects/{project_id}/query/` with header
  `Authorization: Bearer {apiKey}`, JSON body `{query:{kind:'HogQLQuery', query:<sql>}}`,
  `timeout: 30`, over the standard Guzzle client (TLS verification left at Guzzle's secure
  default). Returns `['columns'=>…, 'results'=>…]` or NULL; on any exception it logs
  `PostHog API error: @message` and returns NULL. **The API key is never logged or echoed.**

## Metrics API (used by the plugin, controller, Drush)

- `getEntityUrl(EntityInterface)` — `$entity->toUrl()->toString()` or NULL.
- `getPageMetrics($path, $days=28)` / `getPageMetricsWithComparison(...)` — pageviews, visitors,
  sessions, bounce_rate, avg_time for a path, with a previous-period block + `change`.
- `getSitewideMetrics($days, $country='')` / `getSitewideMetricsWithComparison(...)` — same,
  no path filter, optional country.
- `getDimensionData($path, $days, $dimension, $limit)` and the `getPrevious…`,
  `getSitewide…`, `getSitewidePrev…` variants — grouped rows `{key, pageviews, visitors}` for a
  dimension. `DIMENSION_MAP` maps `referrer→$referring_domain`, `country→$geoip_country_name`,
  `device→$device_type`, `browser→$browser`, `page→$pathname`.
- Conversions: `getPageConversions*`, `getSitewideConversions*`, `getSitewideConversionTotals*`
  — build `CASE` revenue expressions from goal config (`buildRevenueExpression()`), using a fixed
  `value` or reading an event `value_property`.
- `getAvailableEvents($days=30)` — top-50 custom events (`event NOT LIKE '$%'`) with counts, used
  to populate the goal-event dropdown.
- `formatDuration($seconds)` — mm:ss helper.

## Query building & escaping

Queries are HogQL strings assembled by `buildMetricsQuery()`, `buildDimensionQuery()`,
`buildSitewideBounceQuery()`, `buildTimeFilter()`, `buildPathFilter()`, `buildCountryFilter()`,
plus join-alias helpers `prefixTimeFilter()`. `$days` is an int and dimensions are whitelisted
upstream. Any string value interpolated inside a `'…'` literal (pathname, country, goal event,
value_property) is passed through `escapeHogql()` = `addcslashes($value, "'\\")` first. These
queries run **read-only against the site's own PostHog project**, not Drupal's database.

## Caching

- `getCacheKey()` namespaces keys by `md5(host)` + `md5(path)` + type + days; sitewide keys add
  `md5(country)` / goal hashes.
- `cacheSet()` stores each result in `cache.default` with TTL = config `cache_ttl` (default
  21600 s) under the cache tag **`analyze_posthog`**. NULL results are cached too (negative
  caching). Invalidate everything with the `analyze_posthog` tag (see the `:cache-clear` Drush
  command).
