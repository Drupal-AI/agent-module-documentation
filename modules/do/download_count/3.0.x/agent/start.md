<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download Count (download_count) — agent index

Counts downloads of files stored in **private** file fields. It observes core's private-file
delivery route (`system.files`) and records one row per download (file, user, host entity, IP,
referrer, time), aggregates per-file daily totals on cron, and reports the numbers through an
admin report, two blocks, a field formatter with an inline chart, and Views.

- Dependencies: `drupal:field`, `drupal:file`. Core `^10.3 || ^11`. No Composer requirements.
- Configure: `download_count.file_settings` → `/admin/config/media/download-count`.
- Defines permissions: yes. Drush commands: no. Config schema: yes. Plugin *types*: none
  (it ships plugin instances — a field formatter, two blocks, a queue worker).

## Why private files only
Public files are served directly by the web server without bootstrapping Drupal, so nothing
runs to count them. Private files stream through Drupal, and `DownloadCountSubscriber` observes
that stream. If counts stay at zero, confirm the field uses the **private** file system.

## Solution docs
- **How counting works (subscriber, flood, exclusions, storage, cron cache, Rules event)** → [events/tracking.md](events/tracking.md)
- **Settings form + config keys + clear-cache** → [configure/settings.md](configure/settings.md)
- **Permissions and what each gates** → [permissions/permissions.md](permissions/permissions.md)
- **Field formatter that shows a per-file count** → [fields/formatter.md](fields/formatter.md)
- **Top / Recent download blocks** → [blocks/blocks.md](blocks/blocks.md)
- **Views integration (fields, filters, relationships)** → [views/views.md](views/views.md)

## Report routes (admin)
| Route | Path | Permission |
|---|---|---|
| `download_count.reports` | `/admin/reports/download-count` | `view download counts` |
| `download_count.details` | `/admin/reports/download-count/{download_count_entry}/details` | `view download counts` |
| `download_count.reset` | `/admin/reports/download-count/{download_count_entry}/reset` | `view download counts` |
| `download_count.export` | `/admin/reports/download-count/{download_count_entry}/export` | `view download counts` |

`{download_count_entry}` is a `dcid` (a numeric download-count row id) or the literal `all`.
`reports` renders the per-file summary table (controller `DownloadCountController::downloadCountReport`);
`details` shows daily/weekly/monthly/yearly breakdowns with sparklines; `reset` is a confirm form
that deletes counter rows for one file or truncates all; `export` streams a CSV of the raw
per-download log for one file or all.

## Key facts (machine names)
- Config object: `download_count.settings`. Settings route `download_count.file_settings`,
  cache-clear route `download_count.clear` (both require `administer site configuration`).
- Service: `download_count_subscriber` → `Drupal\download_count\EventSubscriber\DownloadCountSubscriber`
  (subscribes to `KernelEvents::RESPONSE`, acts only on route `system.files`).
- Tracking function: `_download_count_track_file_download($file, 'download', $account)` in `download_count.module`.
- Tables (from `download_count.install` `hook_schema()`): `download_count` (raw events),
  `download_count_cache` (per-file per-day totals).
- Cron: `download_count_cron()` fills the `download_count` queue; queue worker `DownloadCountCacheProcessor`
  (plugin id `download_count`, cron time 60) merges rows into `download_count_cache`.
  State key `download_count_last_cron`.
- Permissions: `view download counts`, `skip download counts`, `reset download counts`,
  `export download counts`. Block access strings: `access top download`, `access recent download`.
- Field formatter: id `FieldDownloadCount` (label "Generic file with download count", field type `file`).
  Theme `download_count_file_field_formatter`, template `download-count-file-field-formatter.html.twig`.
- Blocks: `top_download` (Top Downloaded Files), `recent_download` (Recently Downloaded Files).
- Libraries: `download_count/chart`, `download_count/export-form-styling`,
  `download_count/peity_vanilla`, `download_count/global-styling-css`.
- Rules event: `download_count_file_download` (`download_count.rules.inc`), fired only if the
  contrib `rules` module is enabled.
