<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Usage Analyzer (css_usage_analyzer) — agent index

Scans rendered pages for unused CSS and reports it through admin dashboards, a component map, an
unused-rule explorer, and critical-CSS generation. Package **Frontend Optimization**. Core
`^10.3 || ^11`, license GPL-2.0-or-later, version 1.0.1 (dir `1.0.x`). Depends only on core
`system` and `user`. No submodules, no Drush, no plugin types, no config schema.

- **Report pages, routes, permissions, the front-end scanner & critical CSS** → [routes/routes.md](routes/routes.md)
- **Settings, config object, and data model** → [config/settings.md](config/settings.md)

## What it actually is

- Two services (`css_usage_analyzer.services.yml`):
  - `css_usage_analyzer.analyzer` → `Service\CssAnalyzerService` — persists scans, queries reports,
    parses theme CSS, generates critical CSS. Ignores several injected args (`...$extra`).
  - `css_usage_analyzer.css_parser` → `Service\CssParserService` — regex-based CSS rule extractor
    (`parseFile()`), used server-side against theme files only.
- One controller `Controller\CssUsageAnalyzerController` serving all `/admin/reports/css-usage/*`
  report pages plus two non-admin endpoints (`ajaxSave`, `sitemapUrls`).
- Three forms: `Form\SettingsForm` (config + "delete all"), `Form\BulkScanForm` (iframe runner +
  sitemap import), `Form\DeleteScanForm` (confirm delete one scan).
- `hook_page_attachments()` attaches library `css_usage_analyzer/scanner` (`js/css-analyzer.js`)
  to non-admin pages for permitted users when `auto_scan` is on or `?css_force_scan=1` is present.
- Four theme hooks / templates (dashboard, page analysis, component map, bulk scan) in
  `hook_theme()`.

## Data model (`css_usage_analyzer.install`, `hook_schema`)

- `css_analyzer_scans` — one row per scanned page (URL, theme, byte/rule/selector totals, created).
- `css_analyzer_stylesheets` — per-stylesheet metrics per scan.
- `css_analyzer_rules` — individual unused rules (selector, property, value, stylesheet, size, line,
  category). `hook_uninstall()` deletes the settings config object.

## Permissions (`css_usage_analyzer.permissions.yml`)

- `access css usage analyzer` (`restrict access: false`) — view report pages, gate for the
  front-end scanner attach.
- `administer css usage analyzer` (`restrict access: true`) — run scans, configure, delete data,
  bulk scan.

## Routes (`css_usage_analyzer.routing.yml`)

Report pages under `/admin/reports/css-usage` require `access css usage analyzer`
(overview, page-analysis, unused, components, critical, stats, scan/{scan_id}). Settings, scan
trigger, bulk-scan, sitemap-urls and delete require `administer css usage analyzer`. See
[routes/routes.md](routes/routes.md) for the full list, including the two non-admin endpoints
(`css_usage_analyzer.ajax_save`, and the front-end scanner attach).

## Config

Single config object `css_usage_analyzer.settings` (`auto_scan`, `sample_rate`, `scan_retention`,
`excluded_paths`); form at `/admin/config/development/css-usage-analyzer`. Details in
[config/settings.md](config/settings.md).
