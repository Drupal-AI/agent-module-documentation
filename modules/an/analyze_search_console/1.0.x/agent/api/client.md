<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, sitewide report & Drush

Two services (`analyze_search_console.services.yml`):

- **`analyze_search_console.client`** = `Service\SearchConsoleClient` — all Google Search Console
  (Webmasters) API access, token handling, caching, property detection. Args: `config.factory`,
  `cache.default`, `logger.factory`, `request_stack`, `state`, `key.repository`.
- **`analyze_search_console.report_builder`** = `Service\ReportBuilder` — shared render/table logic
  (no constructor args). Used by the plugin, the report controller, and Drush so all three render
  identically.

## `SearchConsoleClient`

Auth/status helpers: `getKeyValue()` (resolve a Key entity value), `isConfigured()`,
`hasCredentials()`, `isAuthorized()`, `getAccountEmail()` (decodes the stored id_token payload for
display), `testConnection()`, `listAvailableProperties()`, `detectPropertyUrl($siteBaseUrl)`,
`getEntityUrl($entity)`.

Data methods (all cached under key prefix `analyze_search_console:…`, tag
`analyze_search_console`, TTL = `cache_ttl` or 21600s):

- Per-page: `getPageMetrics($url,$days,$searchType)`, `getPageMetricsWithComparison(...)`,
  `getDimensionData($url,$days,$dimension,$limit,$searchType,$filters)`,
  `getPreviousPeriodDimensionData(...)`.
- Sitewide (no page filter): `getSitewideMetrics(...)`, `getSitewideMetricsWithComparison(...)`,
  `getSitewideDimensionData(...)`, `getSitewidePrevDimensionData(...)` — the last two take a
  3-letter `country` code filter.

Request building: `buildRequest()` sets start/end dates and `dataState('all')`; `addPageFilter()`
builds an AND `ApiDimensionFilterGroup` of `page equals <url>` plus any extra filters.
`calculateChange()` / `formatPercentageChange()` compute the prior-period deltas.

**Google client** (`getWebmastersService()`): constructs `Google\Client`, sets client
ID/secret (from Key) and the stored access token, and — when expired and a `refresh_token` exists —
calls `fetchAccessTokenWithRefreshToken()`, re-storing the new token in state (preserving the
refresh token). Returns a `Google\Service\Webmasters`, or NULL (logged) on failure. TLS is handled
by the Google API client's own HTTP stack (no custom transport, no verification disabled).

`countryCodeToFlag($alpha3)` (static) maps ISO alpha-3 → alpha-2 via
`commerceguys/addressing` and builds an emoji flag + full name for the country dimension.

## `ReportBuilder`

`buildKpiTable($data,$caption)` + `formatKpiCell()` render the 4-metric KPI table with color-coded,
ARIA-labeled up/down indicators (position: lower is better, so a positive delta is "bad").
`enrichWithComparison($current,$prev,$useCompositeKey=false)` tags each row `new`/`lost`/`up`/
`down`/`stable` and adds `pos_change`. `buildDataTable($rows,$dimension,$request,$showCountryCol,
$days)` builds a sortable `#theme=table` (dimension key `htmlspecialchars`-escaped), with
`formatPositionChange()` / `formatStatusBadge()` and a date-range caption from `buildDateCaption()`.
`getDimensionLabel()` / `getDimensionPluralLabel()` provide human labels.

## Sitewide report (`Controller\ReportController::report()`)

Route `analyze_search_console.report` (`/admin/reports/search-console`, perm
`access search console reports`). Not configured → a message (with a settings link for admins).
Otherwise: reads validated `dimension`/`days`/`search_type`/`status`/`q`/`country` query params,
renders the `ReportFilterForm` (with `show_country`), a KPI table
(`getSitewideMetricsWithComparison()`), an enriched dimension table
(`getSitewideDimensionData()` + `getSitewidePrevDimensionData()` → `enrichWithComparison()`),
PHP `q`/`status` filtering, a 20/page pager, and a GSC deep link. `#cache => ['max-age' => 0]`.

`Form\ReportFilterForm` is a **GET** exposed-filter bar (`#method = get`, form token/build_id/id
suppressed) shared by the entity plugin and this controller; filters live in the URL query string.
Its country dropdown is populated from `getSitewideDimensionData(...,'country',...)`.

## Drush commands (`src/Drush/Commands/SearchConsoleCommands.php`)

| Command | Alias | Purpose |
|---|---|---|
| `analyze:search-console:status` | `analyze-sc-status` | Connection status, account email, config, and available properties. |
| `analyze:search-console:query <url>` | `analyze-sc-query` | Per-URL KPI + dimension table (mirrors the entity report). Options: `--days --dimension --search-type --status --search --limit`. |
| `analyze:search-console:report` | `analyze-sc-report` | Sitewide KPI + dimension table. Adds `--country`. |
| `analyze:search-console:cache-clear` | `analyze-sc-cc` | Invalidates the `analyze_search_console` cache tag. |

`query`'s `resolveUrl()` turns a `/path` into a full URL using `base_url_override`, else the
property URL, else the request host for `sc-domain:` properties. `printKpiTable()` /
`printDimensionTable()` reuse `ReportBuilder` labels and the `countryCodeToFlag()` helper.
