<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & data model

## Install & enable

```bash
composer require drupal/css_usage_analyzer
drush en css_usage_analyzer -y
```

Only core `system` + `user` are required. Grant the two permissions
(`access css usage analyzer`, `administer css usage analyzer`) to the appropriate roles.

## Settings form

`Form\SettingsForm` (`ConfigFormBase`, form id `css_usage_analyzer_settings`) at
**`/admin/config/development/css-usage-analyzer`** (route `css_usage_analyzer.settings`,
permission `administer css usage analyzer`; also the `configure` link in `.info.yml`). It edits the
single config object **`css_usage_analyzer.settings`** and provides a `::deleteAllScans` submit
button that calls `CssAnalyzerService::deleteAllScans()` (truncates all three tables).

### Config object `css_usage_analyzer.settings`

Install defaults from `config/install/css_usage_analyzer.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `auto_scan` | `false` | Attach the front-end scanner automatically on non-admin pages (permitted users only). |
| `sample_rate` | `100` | Percent of page loads scanned when auto-scan is on (form range 1–100). Ignored in force mode (always 100). |
| `scan_retention` | `500` | Max scan records kept; `pruneOldScans()` deletes older scans + their stylesheet/rule rows (form range 10–10000). |
| `excluded_paths` | `['/user/*', '/admin/*']` | Textarea, one glob per line; consumed by the front-end scanner JS. |

There is **no `config/schema/`** in this module, so strict config-schema tooling will flag the
settings object. `hook_uninstall()` deletes the config object on uninstall.

## Data model (`hook_schema` in `css_usage_analyzer.install`)

Three custom tables, written by `CssAnalyzerService::saveScan()` and read by the report queries:

- **`css_analyzer_scans`** — one row per scanned page. Fields: `scan_id` (serial PK), `url`
  (varchar 2048), `page_template`, `theme`, `total_css_bytes`, `used_css_bytes`,
  `unused_css_bytes`, `total_rules`, `unused_rules`, `total_selectors`, `unused_selectors`,
  `stylesheets_count`, `scan_type` (default `full`), `load_time_impact` (float), `created`
  (unix ts). Indexes on `url`(255), `created`, `theme`.
- **`css_analyzer_stylesheets`** — per-stylesheet metrics per scan (`scan_id` FK, `href`, `label`,
  `total_bytes`, `used_bytes`, `unused_bytes`, `total_rules`, `unused_rules`, `is_external`,
  `is_critical`). Index on `scan_id`.
- **`css_analyzer_rules`** — individual rules flagged unused (`rule_id` serial PK, `scan_id`,
  `selector` text, `property`, `value` text, `stylesheet`, `rule_size`, `line_number`, `is_used`,
  `category` = `layout|component|utility|plugin`). Indexes on `scan_id`, `is_used`,
  `stylesheet`(255).

`saveScan()` truncates each incoming string to the column length, caps inserted unused rules at
**5000 per scan**, then calls `pruneOldScans()` to enforce `scan_retention`.

## Service surface (`CssAnalyzerService`)

Constructor args: `config.factory`, `theme.manager`, `extension.list.theme`, `logger.factory`,
`datetime.time`, `database`, plus two asset services collected into `...$extra` and unused. Key
methods: `saveScan()`, `getOverallStats()`, `getScanStats()`, `getScanStylesheets()`,
`getUnusedRules()`, `getRecentScans()`, `getScanHistory()`, `getTopOffenders()`,
`getCategoryBreakdown()`, `getComponentMap()`, `estimateCriticalCssSize()`, `getThemeCssFiles()`,
`generateCriticalCss()`, `deleteScan()`, `deleteAllScans()`, `getActiveTheme()`, static
`formatBytes()`.
