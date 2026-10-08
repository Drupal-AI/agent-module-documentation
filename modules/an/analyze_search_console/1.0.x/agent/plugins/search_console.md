<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `search_console` Analyze plugin

`src/Plugin/Analyze/SearchConsole.php` — `@Analyze(id="search_console", label="Search Console
Reports")`, extends `Drupal\analyze\AnalyzePluginBase`. It adds a Search Console section to the
Analyze tab of any entity that has a canonical URL. Enable it per entity type/bundle at
`/admin/config/content/analyze-settings` (Analyze base module).

## Applicability & access

- `isApplicable()` / `isEnabled()` → true only when `SearchConsoleClient::isConfigured()` (see
  config doc). Not configured → a status table with a link to settings (for users holding
  `administer analyze settings`).
- `access(EntityInterface $entity)` → requires permission **`access search console reports`**.
- `getEntityUrl($entity)` maps the entity to the URL Search Console knows: strips the request base
  path, then applies `base_url_override` if set, else prefixes the property URL (or the current
  scheme+host for `sc-domain:` properties). Returns NULL when the entity has no URL → a "no URL
  path" status table.

## Summary (`renderSummary()`)

Fetches `getPageMetricsWithComparison($fullUrl, $days, $searchType)` and renders a
`#theme => analyze_table` titled "Search Console (Last N Days)" with four rows — Clicks,
Impressions, Click-through rate, Average position — each appending the formatted prior-period
change (e.g. `1,234 (+12.3%)`). If the page has no data yet it shows "This page hasn't appeared in
search results yet." `getFullReportUrl()` returns the entity's full-report URL only when the page
has metrics.

## Full report (`renderFullReport()`)

Reads overrides from query params (`dimension`, `days`, `search_type`, `status`, `q`, plus stacked
`filter_{i}_dim|_op|_val`) and validates them (`dimension` ∈ query/page/country/device;
`days` ∈ 7/14/28/90). Then it:

1. Renders the shared `Form\ReportFilterForm` with an entity-specific action URL and
   `show_country = FALSE`.
2. Builds the KPI table via `ReportBuilder::buildKpiTable()` from
   `getPageMetricsWithComparison()`.
3. Shows removable **filter chips** for any active dimension filters (`buildFilterChips()`).
4. Fetches current + previous dimension rows (`getDimensionData()` /
   `getPreviousPeriodDimensionData()`, limit 100), enriches them with status/position-change
   (`ReportBuilder::enrichWithComparison()`), applies the `status` and `q` filters in PHP,
   paginates 20/page via `pager.manager`, and renders `ReportBuilder::buildDataTable()`.
5. Adds a "View in Google Search Console" source link (deep-links with `resource_id` + `page`).

`extraSummaryLinks()` adds the same GSC deep link beside the summary.

## Stacked dimension filters

`buildFiltersFromRequest()` reads up to 10 `filter_{i}_dim` / `_op` / `_val` query triples, keeping
only whitelisted dimensions and operators (`equals`, `contains`, `notEquals`, `notContains`,
`includingRegex`, `excludingRegex`). Valid triples become `ApiDimensionFilter`s added (AND group)
to the API request in `SearchConsoleClient::addPageFilter()`. Chips link to the report with one
filter removed.

## Rendering notes

All value/label output flows through `ReportBuilder`; dimension keys (search queries, page URLs,
country names) are `htmlspecialchars()`-escaped before being wrapped in `Markup::create()`. See
[../api/client.md](../api/client.md) for the client and builder internals.
