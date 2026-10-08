<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Download Counter is a submodule of File Download that records how many times each file is downloaded through the download route, and exposes those counts to Views and a "Popular content" block.

> Compatibility note: this submodule declares `core_version_requirement: ^9 || ^10` and therefore
> **cannot be enabled on Drupal 11** (`drush en file_download_counter` reports "incompatible with
> this version of Drupal core"). The parent `file_download` module works on D11; only this counter
> submodule is gated to D9/D10.

---

The submodule installs a database table `file_download_counter` (columns `fid`, `totalcount`,
`daycount`, `timestamp`, primary key `fid`) and hooks into File Download's download controller: when
its setting `count_downloads` is enabled, each successful download calls
`file_download_counter_increment_file($fid)`, a MERGE that bumps `daycount` and `totalcount` and sets
the last-download `timestamp`. `hook_cron()` resets `daycount` to 0 once every 24 hours and
recomputes a ranking scale for search integration (`hook_ranking()`, gated on `count_content_views`).
Configuration lives at `/admin/config/system/file-download-counter`
(route `file_download_counter.settings`, permission `administer file download counter`) — a single
"Count downloads" checkbox saved to `file_download_counter.settings:count_downloads`. It also provides
two Views field handlers (numeric count and last-download timestamp), a "Popular content" block
(`statistics_popular_block`, showing today's / all-time / most-recent downloaded content, only
available when `count_content_views` is on), a `file` predelete hook that purges rows for deleted
files, and helper functions `file_download_counter_get()` / `file_download_counter_title_list()`.
Permissions: `administer file download counter` and `view file download counter`.

---

- Count how many times each downloadable file has been fetched, site-wide.
- Track a per-day download count (`daycount`) that resets every 24 hours via cron.
- Record the timestamp of the last time each file was downloaded.
- Show a "Popular content" block listing today's most-downloaded content.
- Show an all-time most-downloaded content list in a block.
- Show a "recently downloaded" list of content in a block.
- Add a Views field displaying a file's total download count.
- Add a Views field displaying a file's last-download timestamp.
- Build a "Top downloads" View sorted by download count.
- Turn download counting on or off with the `count_downloads` setting.
- Feed download popularity into search ranking (`hook_ranking`) when content-view counting is enabled.
- Automatically clean up counter rows when a file entity is deleted.
- Read a file's counts programmatically via `file_download_counter_get($fid)`.
- Report download totals on a dashboard built from the Views field.
- Identify unused/never-downloaded files (count of 0).
- Measure engagement with gated resources (whitepapers, brochures).
- Compare downloads today vs all time for a resource.
- Surface trending downloads on a homepage block.
- Give editors visibility into which attachments are popular.
- Provide analytics for a downloads library without a third-party tracker.
- Reset daily counters automatically so "today" figures stay accurate.
- Restrict who can view download hit data with the `view file download counter` permission.
