<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Download Count

- Settings form: `Drupal\download_count\Form\DownloadCountSettingsForm`
  (form id `download_count_admin_settings_form`), route `download_count.file_settings`
  at `/admin/config/media/download-count`. Requires `administer site configuration`.
- Config object: `download_count.settings` (schema `config/schema/download_count.schema.yml`,
  defaults `config/install/download_count.settings.yml`).
- Cache-clear confirm form: `DownloadCountClearForm`, route `download_count.clear` at
  `/admin/config/media/download-count/clear` (same permission). Truncates
  `download_count_cache` and sets state `download_count_last_cron` to 0.

## Config keys
| Key | Type | Default | Meaning |
|---|---|---|---|
| `download_count_excluded_file_extensions` | string | `jpg jpeg gif png` | Space-separated extensions never counted (e.g. private image fields). |
| `download_count_flood_limit` | int | `0` | Max counts per file per window. `0` = flood control off. |
| `download_count_flood_window` | int | `5` | Flood window in seconds. |
| `download_count_export_range` | int | `0` | Last-used export mode on the CSV export form (0 = all data, 1 = date range). |
| `date_first_day` | int | `0` | First day of week for details grouping (0 = Sunday → `%U`, else `%u`). |
| `download_count_details_daily_limit` | int | `30` | Rows on the daily details table. |
| `download_count_details_weekly_limit` | int | `25` | Rows on the weekly details table. |
| `download_count_details_monthly_limit` | int | `12` | Rows on the monthly details table. |
| `download_count_details_yearly_limit` | int | `5` | Rows on the yearly details table. |
| `download_count_recent_files_block_limit` | int | `10` | (Legacy default; the Recent block reads its own per-instance limit.) |
| `download_count_top_files_block_limit` | int | `10` | (Legacy default; the Top block reads its own per-instance limit.) |
| `download_count_view_page_title` | string | `Download Counts` | Title of the report page. |
| `download_count_view_page_items` | int | `25` | Items per page on the report (0 = no pager). |
| `download_count_view_page_limit` | int | `0` | Total rows cap on the report (0 = no limit). |
| `download_count_view_page_header` | text_format | `''` | HTML shown above the report table. |
| `download_count_view_page_footer` | text_format | `''` | HTML shown below the report table. |
| `download_count_sparklines` | string | `line` | Sparkline chart type (peity). |
| `download_count_sparkline_min` | int | `0` | Sparkline minimum. |
| `download_count_sparkline_height` | string | `150px` | Sparkline height. |
| `download_count_sparkline_width` | string | `50%` | Sparkline width. |

Note: `download_count_update_91001()` removes the four `sparkline*`/`sparklines` keys from
existing sites (comment: "the sparkline library is no longer used"), but the settings-form
`submitForm()` still re-saves `download_count_sparklines`/`_min`/`_height`/`_width` from
`$form_state` (they have no form widgets, so they save empty). The details page still reads
`download_count_sparklines` and the peity data spans.

## Set via drush / PHP
```bash
# Exclude PDFs from counting and turn on flood control (max 1 count / 30s per file).
ddev drush config:set download_count.settings download_count_excluded_file_extensions 'jpg jpeg gif png pdf' -y
ddev drush config:set download_count.settings download_count_flood_limit 1 -y
ddev drush config:set download_count.settings download_count_flood_window 30 -y
```
```php
\Drupal::configFactory()->getEditable('download_count.settings')
  ->set('download_count_view_page_items', 50)
  ->set('download_count_view_page_title', 'File downloads')
  ->save();
```
