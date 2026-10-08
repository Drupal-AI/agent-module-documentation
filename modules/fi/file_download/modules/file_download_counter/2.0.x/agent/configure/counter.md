<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Download Counter — settings, storage, Views, block

> Reminder: this submodule is `^9 || ^10` only and cannot be enabled on Drupal 11.

## Settings

Config object: `file_download_counter.settings`. The settings form
(`FileDownloadSettingsForm`, route `file_download_counter.settings`,
`/admin/config/system/file-download-counter`, permission `administer file download counter`)
exposes one checkbox:

- **`count_downloads`** (boolean) — when true, every successful download increments the file's
  counter. This is the key the download controller checks.

The `config/install/file_download_counter.settings.yml` also ships `access_log`,
`max_lifetime`, `count_content_views` and `display_max_age`. `count_content_views` gates
`hook_ranking()` (search) and whether the "Popular content" block is available
(`hook_block_alter()` removes the block when it is off).

```bash
drush cset file_download_counter.settings count_downloads 1 -y
```

## Storage & increment

`hook_schema()` creates table **`file_download_counter`**:

| Column | Meaning |
|---|---|
| `fid` (PK) | the file id |
| `totalcount` | total downloads of that file |
| `daycount` | downloads today (reset by cron every 24h) |
| `timestamp` | last download time |

On download, File Download's controller calls `file_download_counter_increment_file($fid)` (only when
`count_downloads` is on): a `merge()` that does `daycount = daycount + 1`, `totalcount = totalcount + 1`,
`timestamp = REQUEST_TIME`. `file_download_counter_file_predelete()` deletes a file's row when the file
entity is deleted.

## Cron

`hook_cron()` resets `daycount` to 0 once per 24 hours (tracked in state
`file_download_counter.day_timestamp`) and recomputes `file_download_counter.node_counter_scale` for
search ranking.

## Views integration

`file_download_counter.views.inc` adds two Views field handlers against the `file_download_counter`
table:

- **`FileDownloadNumeric`** — a download count (`totalcount` / `daycount`).
- **`FileDownloadCounterTimestamp`** — the last-download timestamp.

Use them to build "Top downloads" listings.

## Popular content block

Block plugin `statistics_popular_block` ("Popular content", class `FileDownloadPopularBlock`) shows
configurable top-N lists for **today**, **all time** and **most recently** downloaded content
(built from `file_download_counter_title_list($dbfield, $n)`). It is only offered when
`count_content_views` is enabled. Access requires `access content`.

## Helper functions

- `file_download_counter_get(int $fid): array` — returns `['totalcount','daycount','timestamp']` for a file.
- `file_download_counter_title_list(string $dbfield, int $dbrows)` — top content by
  `totalcount` | `daycount` | `timestamp`.

## Permissions

- `administer file download counter` — reach the settings form.
- `view file download counter` — view download hit data.
