<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Download Counter — agent index

Submodule of **File Download**. Records per-file download counts (in a `file_download_counter` DB
table) when a file is fetched through File Download's download route, and exposes them via Views
fields and a "Popular content" block. Configure route: `file_download_counter.settings`.

> **Not enableable on Drupal 11.** It declares `core_version_requirement: ^9 || ^10`, so
> `drush en file_download_counter` fails with "incompatible with this version of Drupal core". The
> parent `file_download` module is D11-compatible; this counter is not.

- **The `count_downloads` setting, the DB table & increment, cron reset, Views fields, the popular
  block, permissions and helper functions** → [configure/counter.md](configure/counter.md)

Key facts:
- Enable counting: `file_download_counter.settings:count_downloads` = true (form at
  `/admin/config/system/file-download-counter`).
- Each download runs `file_download_counter_increment_file($fid)` (bumps `daycount`/`totalcount`,
  sets `timestamp`).
- Permissions: `administer file download counter`, `view file download counter`.
- Views field handlers + `statistics_popular_block` block (block needs `count_content_views` on).
