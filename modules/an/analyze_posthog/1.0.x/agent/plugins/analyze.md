<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Analyze plugin, sitewide page, filter form & rendering

## The Analyze plugin

`Drupal\analyze_posthog\Plugin\Analyze\PostHog` — annotation `@Analyze(id="posthog_analytics",
label="PostHog Analytics")`, extends `analyze\AnalyzePluginBase`. It plugs into the **analyze**
module's per-entity Analyze tab; the analyze module owns the entity route
(`analyze.<entity_type>.posthog_analytics`).

- `isApplicable()` / `isEnabled()` — TRUE only when `PostHogClient::isConfigured()` (and the base
  enablement). Applies to any entity type/bundle once configured.
- `access(EntityInterface)` — requires permission **`access posthog analytics`**.
- `renderSummary(entity)` — resolves the entity path via `client->getEntityUrl()` (its
  `toUrl()->toString()`), then `client->getPageMetricsWithComparison($path, $days)`; renders a
  `#theme => 'analyze_table'` with Pageviews / Unique visitors / Sessions / Bounce rate / Avg time
  on page, each suffixed with its change (e.g. `(+12.3%)`). Appends Conversions / Conv. value rows
  when goals exist. Falls back to a status table if not configured / no URL / no data.
- `renderFullReport(entity)` — builds the shared `ReportFilterForm` (with the entity's action
  URL, `show_country = FALSE`), a KPI table via `ReportBuilder::buildKpiTable()`, and a dimension
  table. Reads `dimension`, `days`, `status`, `q` from query params; valid dimensions here are
  `referrer, country, device, browser` (+ `conversion` when goals exist). 20 rows/page via
  `pager.manager`.
- `getFullReportUrl()` — returns the full-report URL only if the page currently has metrics.
- `extraSummaryLinks()` — "View in PostHog" (`{host}/web`) and "Watch sessions"
  (`{host}/replay?...` with a JSON `properties` filter on `$pathname`), both `target=_blank
  rel=noopener`.

## Sitewide page controller

`Drupal\analyze_posthog\Controller\ReportController::report(Request)` at
**`/admin/reports/posthog`** (route `analyze_posthog.report`, permission
`access posthog analytics`). If not configured → a message (with a "Configure settings" link when
the user has `administer analyze settings`). Otherwise it:

1. Reads query params `dimension` (default `referrer`), `days`, `status` (default `all`), `q`,
   `country`. Valid dimensions: `referrer, country, device, browser, page` (+ `conversion` when
   goals exist); invalid values fall back to `referrer`. `days` is whitelisted to
   `[7,14,28,90,180,365]`, else the configured default.
2. Renders a header, the `ReportFilterForm`, a KPI table
   (`getSitewideMetricsWithComparison()`), then either a conversion table or a dimension table
   (`getSitewideDimensionData()` + `getSitewidePrevDimensionData()` enriched by
   `ReportBuilder::enrichWithComparison()`), paginated 20/page.
3. Adds "Open in PostHog" (`{host}/web`) and "Watch sessions" (`{host}/replay`) buttons. Sets
   `#cache max-age = 0` (the underlying HogQL calls are cached in the client instead).

## Filter form

`Drupal\analyze_posthog\Form\ReportFilterForm` (form id `analyze_posthog_report_filter`,
`FormBase`). Rendered as a **GET** exposed-filter bar (`#method = get`), so selections live in the
URL; `submitForm()` is a no-op and `form_build_id/form_token/form_id` are hidden. Args:
`$action_url` (defaults to the sitewide page) and `$show_country`. Elements: Dimension, Period,
Country (sitewide only, populated from `getSitewideDimensionData(..., 'country', 20)` and hidden
when the dimension itself is `country`), Status (all/up/down/new/lost), Search text, a Filter
submit and a Reset link.

## Rendering / comparison logic — `ReportBuilder`

`Drupal\analyze_posthog\Service\ReportBuilder` (service `analyze_posthog.report_builder`, a
`final` class, no state) is shared by the controller, the plugin, and the Drush commands so all
three render identically.

- `buildKpiTable()` / `formatKpiCell()` — the KPI card row; each cell shows a `number_format`ed
  value plus a color-coded ▲/▼ change span (up/down/neutral) with an aria-label.
- `enrichWithComparison()` / `enrichConversionComparison()` — join current vs previous rows by
  key, add `status` (new/lost/up/down/stable, ±10% threshold) and `pct_change`.
- `filterRows()` — in-memory status + case-insensitive substring filter on the dimension key.
- `buildDataTable()` / `buildConversionTable()` — sortable `#theme => 'table'` render arrays;
  rows are sorted in PHP by the `order`/`sort` query params. Dimension **key values coming from
  PostHog are `htmlspecialchars()`-escaped** before going into `Markup::create()`.
- Helpers: `goalsHaveRevenue()`, `buildDateCaption()`, `getDimensionLabel()` /
  `getDimensionPluralLabel()`, plus `printConversionKpi()` / `printConversionTable()` for Drush.

All tables attach the `analyze_posthog/report` CSS library.
