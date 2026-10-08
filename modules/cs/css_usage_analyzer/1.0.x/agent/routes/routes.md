<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report pages, routes & the CSS scanner

All served by `Controller\CssUsageAnalyzerController` (ctor: `css_usage_analyzer.analyzer`,
`request_stack`, `http_client`). Report pages live under **`/admin/reports/css-usage`**; menu
links (`*.links.menu.yml`) and local tasks (`*.links.task.yml`) hang the sub-pages off the
overview.

## Routes (`css_usage_analyzer.routing.yml`)

| Route | Path | Method/handler | Permission |
|---|---|---|---|
| `css_usage_analyzer.overview` | `/admin/reports/css-usage` | `::overview` (dashboard) | `access css usage analyzer` |
| `css_usage_analyzer.page_analysis` | `…/page-analysis` | `::pageAnalysis` | `access css usage analyzer` |
| `css_usage_analyzer.unused_css` | `…/unused` | `::unusedCss` | `access css usage analyzer` |
| `css_usage_analyzer.component_map` | `…/components` | `::componentMap` | `access css usage analyzer` |
| `css_usage_analyzer.critical_css` | `…/critical` | `::criticalCss` | `access css usage analyzer` |
| `css_usage_analyzer.generate_critical` | `…/critical/generate` | `::generateCritical` | `access css usage analyzer` |
| `css_usage_analyzer.css_stats` | `…/stats` | `::cssStats` (print_r debug) | `access css usage analyzer` |
| `css_usage_analyzer.scan_view` | `…/scan/{scan_id}` | `::scanDetail` (→ pageAnalysis) | `access css usage analyzer` |
| `css_usage_analyzer.settings` | `/admin/config/development/css-usage-analyzer` | `Form\SettingsForm` | `administer css usage analyzer` |
| `css_usage_analyzer.scan` | `…/scan` | `::scan` (message + link) | `administer css usage analyzer`, `_csrf_token: TRUE` |
| `css_usage_analyzer.bulk_scan` | `…/bulk-scan` | `Form\BulkScanForm` | `administer css usage analyzer` |
| `css_usage_analyzer.sitemap_urls` | `…/bulk-scan/sitemap-urls` | `::sitemapUrls` (JSON) | `administer css usage analyzer` |
| `css_usage_analyzer.delete_scan` | `…/scan/{scan_id}/delete` | `Form\DeleteScanForm` | `administer css usage analyzer` |
| `css_usage_analyzer.ajax_save` | `/css-usage-analyzer/save` | `::ajaxSave` (JSON in → save) | `access content` + `_access: TRUE` |

`{scan_id}` is constrained to `\d+`.

## Report pages

- **overview** — `#theme => css_usage_dashboard`; aggregates `getOverallStats()`, `getRecentScans()`,
  `getTopOffenders()`, `getScanHistory(7)`; builds trend chart data (encoded as JSON in
  `drupalSettings`, drawn by `js/css-charts.js`). Attaches `css_usage_analyzer/admin`.
- **page_analysis / scan_view** — `#theme => css_usage_page_analysis`; scan chosen by `?scan_id`
  (default = latest). Shows per-scan totals, `getScanStylesheets()`, top `getUnusedRules()`,
  `getCategoryBreakdown()`, `estimateCriticalCssSize()`, and a scan selector (`getRecentScans(30)`).
- **unused_css** — paged unused-rule table (`buildUnusedCssTable()`), 50/page, most-recent scan.
- **component_map** — `#theme => css_usage_component_map`; `getComponentMap()` groups
  `category = 'component'` rules by stylesheet.
- **critical_css / generate_critical** — overview page then a generated inline critical-CSS output.
  `generateCritical()` reads `?theme` (default active theme), calls
  `CssAnalyzerService::generateCriticalCss()`, and renders the result via
  `#type => inline_template` with `{{ content|raw }}` (see "Critical CSS" below).
- **css_stats** — debug dump of `getOverallStats()` via `print_r`.

## Critical CSS generation (server-side)

`generateCriticalCss($theme)` enumerates the theme's CSS with `getThemeCssFiles()` (searches
`css/`, `dist/css/`, `components/` under the theme path; skips `.min.`/`.map`), parses each with
`CssParserService::parseFile()` (regex rule extraction), keeps selectors matched by
`isCriticalSelector()` against `CRITICAL_PATTERNS` (`:root`, `html`, `body`, `h1`–`h3`, `header`,
`nav`, `main`, hero/banner/jumbotron, `@font-face`, `.container`/`.wrapper`, `#page`, …), groups
declarations per selector, and returns `css_text` + `size_bytes` + `sources`. Input is the theme's
own files, not request data. The generated output page offers copy/download buttons
(`js/critical-css.js`).

## Front-end scanner & save endpoint

- `hook_page_attachments()` (`.module`) attaches library `css_usage_analyzer/scanner`
  (`js/css-analyzer.js`) on **non-admin** routes when the current user has
  `access css usage analyzer` AND (`auto_scan` is on OR `?css_force_scan=1`). It passes
  `drupalSettings.cssUsageAnalyzer` = `{ saveEndpoint, pageUrl, enabled, forceMode, sampleRate }`.
  The scanner measures used/unused CSS in the browser and POSTs JSON to the save endpoint.
- `::ajaxSave()` (`css_usage_analyzer.ajax_save`, path `/css-usage-analyzer/save`) json-decodes the
  request body, requires a `totalRules` key, and calls `CssAnalyzerService::saveScan()`; returns
  `{status, scan_id}`.

## Bulk scanning

`Form\BulkScanForm` accepts URLs (one per line; root-relative resolved against the host,
validated with `FILTER_VALIDATE_URL`) or imports them from a sitemap via `::importSitemap()`
(`httpClient->get($sitemap_url)` → `simplexml_load_string` → `<loc>` values). On submit it renders
a hidden sandboxed iframe runner (`buildBulkScanRunner()`, URLs escaped with `Html::escape()`) that
`js/bulk-scanner.js` steps through, loading each URL with `?css_force_scan=1`. The controller's
`::sitemapUrls()` provides the same sitemap parsing as a JSON endpoint for the JS.
