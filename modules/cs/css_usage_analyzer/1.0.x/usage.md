CSS Usage Analyzer scans rendered Drupal pages, records which CSS rules, selectors, and stylesheets go unused, and reports the results as admin dashboards with per-page analysis, a component map, and critical-CSS suggestions.

---

The module attaches a client-side scanner (`js/css-analyzer.js`) to non-admin pages for users who hold the *access css usage analyzer* permission, either automatically (when `auto_scan` is enabled) or on demand via a `?css_force_scan=1` query parameter. The scanner measures used vs. unused CSS in the browser and POSTs the results to a save endpoint; the `CssAnalyzerService` stores each scan in three custom tables (`css_analyzer_scans`, `css_analyzer_stylesheets`, `css_analyzer_rules`) and prunes old records beyond a configurable retention limit. Admin report pages under `/admin/reports/css-usage` present an overview dashboard, a page-analysis view, an unused-CSS rule explorer, a component map, per-scan detail, and a stats debug page. A separate server-side path parses the active theme's CSS files (`CssParserService`) to estimate and generate inline critical CSS. A bulk-scan form drives multiple pages through a hidden iframe and can import URLs from an XML sitemap. All configuration lives in the `css_usage_analyzer.settings` config object and the settings form at `/admin/config/development/css-usage-analyzer`. The module ships no submodules, no Drush commands, and no plugin types.

---

- Find dead CSS in a custom theme by scanning representative page types and reviewing the unused-rule explorer.
- Measure the used-vs-unused CSS ratio for a single page on the page-analysis view.
- See which stylesheets contribute the most unused bytes via the dashboard's "top offenders" list.
- Estimate potential payload savings before a theme CSS cleanup.
- Generate an inline critical-CSS block for the active theme to improve First Contentful Paint.
- Identify above-the-fold selectors (`:root`, `body`, `header`, `nav`, hero/banner classes, `@font-face`) collected as critical.
- Track unused-CSS trends over the last 7 days on the dashboard trend chart.
- Break down unused CSS by category (layout / component / utility / plugin) for a scan.
- Map component-level CSS bloat by grouping unused rules per source stylesheet (component map).
- Bulk-scan a list of URLs entered one per line through the hidden iframe runner.
- Import a site's public URLs from `sitemap.xml` and queue them for scanning.
- Force a one-off scan of a specific front-end page with `?css_force_scan=1`.
- Sample only a percentage of page loads (`sample_rate`) to keep auto-scan overhead low on busy sites.
- Exclude sensitive or irrelevant paths (e.g. `/user/*`, `/admin/*`) from automatic scanning.
- Audit CSS usage across multiple themes by scanning pages that render each theme.
- Keep a rolling window of the most recent scans by tuning `scan_retention`.
- Review per-stylesheet metrics (total/used/unused bytes, rule counts, external flag) for a scan.
- Compare recent scans from the page-analysis scan selector to spot regressions.
- Delete a single stale scan through the confirm form, or wipe all scan data from settings.
- Support Core Web Vitals (LCP/FCP) work by quantifying render-blocking CSS.
- Provide front-end developers a Drupal-native alternative to browser-devtools coverage reports.
- Prioritize CSS refactoring by rule size, since the explorer orders unused rules by byte weight.
- Produce a copy/downloadable critical.css file from the generate-critical page for manual inlining.
- Inspect raw aggregate stats via the CSS Stats debug page during troubleshooting.
