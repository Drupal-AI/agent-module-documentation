<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download Statistics (download_statistics) — agent index

Counts downloads of **managed (private) files** — total, today, last-download timestamp and last
downloader UID — and shows them via a block, Views and tokens. Package `Administration`. Depends on
core **`node`**, **`field`**, **`file`**. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.2.1 (dir `1.2.x`). No Composer/library deps, no Drush.

## Solution docs

- **Enable counting, the settings form, config object + schema, permissions** →
  [config/settings.md](config/settings.md)
- **How a download is counted: route subscriber, controller, storage service, DB table, the two
  field formatters, cron & search ranking** → [api/counting.md](api/counting.md)
- **Displaying counts: Popular file downloads block, Views data/fields, file tokens** →
  [display/block-views-tokens.md](display/block-views-tokens.md)

## What it actually is (from source)

- A **route subscriber** `Routing\FileDownloadAlterRouteSubscriber` (event_subscriber) that — only
  when config `count_file_downloads` is TRUE — repoints the core routes `system.files` and
  `system.private_file_download` to `Controller\DownloadStatisticsFileController::download`.
- That controller extends core `system\FileDownloadController`; it records a download **after**
  `hook_file_download` grants access (same access model as core private-file serving).
- A **storage service** `download_statistics.storage.file`
  (`DownloadStatisticsDatabaseStorage`, tagged `backend_overridable`, interface
  `DownloadStatisticsStorageInterface`) that MERGEs/reads the `download_statistics` DB table
  (schema in `download_statistics.install`).
- Two **field formatters** to mark files for counting: `counted_downloads_file`
  ("File with Download Statistics recorded", file fields) and `file_uri_download_count`
  ("File URI with Download Count", the `uri`/`file_uri` field). Both rewrite the URL to
  `private://download-count/…`.
- A **block** `download_statistics_popular_block` ("Popular file downloads").
- **Views** integration (`download_statistics.views.inc`) + two field handlers
  (`download_statistics_numeric`, `download_statistics_timestamp`).
- **Tokens** on the `file` token type (`download_statistics.tokens.inc`).
- Hooks in `Hook\DownloadStatisticsHooks` (autowired): `help`, `cron`, `preprocess_file_link`,
  `file_predelete`, `ranking`, `preprocess_block`, `block_alter`,
  `form_views_ui_config_item_form_alter`. Legacy `.module` wrappers use `#[LegacyHook]`.

## Routes & permissions

- Settings form `download_statistics.settings` → `/admin/config/system/download-statistics`,
  requires **`administer download statistics`** (form `DownloadStatisticsSettingsForm`).
- Permissions (`download_statistics.permissions.yml`): `administer download statistics`,
  `view file download statistics` (gates the block, Views fields, tokens display).
- No routes of its own for serving files — it hijacks the core file routes.

## Key facts

- **Only private files can be counted** — public files bypass Drupal. Counting also requires a
  file to be "marked" (formatter used / block placed) in the current render.
- Config object **`download_statistics.settings`**: `count_file_downloads` (bool, default 0),
  `display_max_age` (int, default 3600). Schema in `config/schema/`.
- Toggling `count_file_downloads` triggers `drupal_flush_all_caches()`.
- DB table `download_statistics`: `fid` (PK), `totalcount`, `daycount`, `timestamp`, `uid`.
- `download_statistics_get(int $fid): array|false` is the public procedural read helper.
