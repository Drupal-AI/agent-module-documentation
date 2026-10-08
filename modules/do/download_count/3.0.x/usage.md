<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Download Count records every download of a file held in a **private** file field and reports the totals through an admin report, blocks, Views and a field formatter with an inline chart.

---

The private-files constraint is the whole design. Drupal serves public files directly from the web server, where PHP never runs and nothing can be counted; private files are streamed through Drupal, so a subscriber can observe each delivery. `DownloadCountSubscriber` is that observer — it acts on core's `system.files` route, resolves the served URI back to a managed file, and calls `_download_count_track_file_download()`, which records one row per download: the file id, user id, the entity type and id the file was attached to, IP address, referrer and a timestamp. Counting is skippable by extension (`download_count_excluded_file_extensions`), throttled by optional flood control, and suppressed for users holding `skip download counts`. A second `download_count_cache` table aggregates counts per file per day, kept current by `download_count_cron()` and the `DownloadCountCacheProcessor` queue worker so reports read aggregates instead of scanning the raw log. The reporting surface is generous for a module this size: two blocks (`TopDownload`, `RecentDownload`), a `FieldDownloadCount` field formatter with a Peity sparkline and a dedicated Twig template, full Views integration via `download_count.views.inc` (fields, filters, sorts, and File/User relationships), an admin report at `/admin/reports/download-count` with per-entry daily/weekly/monthly/yearly detail, per-file and bulk reset, CSV export, and a `download_count_file_download` Rules event fired when the contrib Rules module is present. Permissions separate the roles: `view download counts`, `reset download counts`, `export download counts`, and `skip download counts`.

---

- Count downloads of a private file attached to a node.
- Show the most-downloaded files in a block.
- Show recently downloaded files in a block.
- Display a download count next to a file field.
- Render a sparkline of downloads over time on the details page.
- Build a Views report of download activity.
- Exclude staff from download statistics by role.
- Exclude image files from counts by extension.
- Throttle repeated counts with flood control.
- Reset the counter for a single file.
- Reset all download counters at once.
- Export download figures to CSV for reporting.
- Measure demand for a document library.
- Prove distribution numbers for a publication.
- Identify files nobody downloads.
- Report downloads per attached entity.
- Restrict who can see download reports.
- Trigger a Rules action on download activity.
- Keep counting accurate behind a page cache.
- Aggregate daily totals without scanning raw events.
- Track a paywalled file's usage.
- Support a funder's usage-reporting requirement.
- Decide which resources deserve promotion.
