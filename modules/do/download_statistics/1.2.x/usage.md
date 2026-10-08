<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Download Statistics counts how often each managed (private) file is downloaded and surfaces those counts through a block, Views and tokens.

---

Download Statistics is a file-download analog of core's Statistics module. When "Count file downloads" is enabled, a route subscriber replaces the controllers behind Drupal's private/managed file download routes with a controller that records a download in the `download_statistics` table (fid, total count, day count, last-download timestamp, last downloader UID) after core's `hook_file_download` access checks pass. Because counting requires the request to pass through Drupal, it only works for files served from the **private** file system — public files are streamed by the web server and cannot be counted. You opt individual files in by choosing one of the module's field formatters ("File with Download Statistics recorded" for file fields, "File URI with Download Count" for the file URI) or by using the Popular file downloads block; those displays rewrite the file URL to `private://download-count/…` so it routes through the counting controller. Counts are viewable through the "Popular file downloads" block (top today / all time / most recent), through Views fields (Total file downloads, File downloads today, Most recent file download), and through file tokens. Reporting is gated by the `view file download statistics` permission; the settings form and the "clear counts" action are gated by `administer download statistics`. Cron resets the daily counter every 24 hours and updates a scale factor used by `hook_ranking` to boost popular downloads in core search results.

---

- See which files/documents on your site are downloaded most often (all-time popularity).
- Track today's most-downloaded files for a daily "trending downloads" view.
- Show the most recently downloaded files.
- Add a "Popular file downloads" block to any region listing top-day, top-all-time and last-downloaded files.
- Display a per-file download count on a node or media page by setting the field's format to "File with Download Statistics recorded" on Manage display.
- Show download counts inside a View by using the "File URI with Download Count" URI formatter and/or the module's Views fields.
- Build a custom Views report of downloads with Total file downloads, File downloads today and Most recent file download columns.
- Sort or filter a View of files by number of downloads (click-sortable numeric fields).
- Relate download statistics rows to the File entity and to the User who last downloaded each file in Views.
- Insert a file's download count into text/emails/metatags via the `[file:total-count]`, `[file:day-count]`, `[file:last-view]` and `[file:last-user]` tokens.
- Boost frequently downloaded content in core search ranking (via `hook_ranking`).
- Restrict who can see download counts using the "View file download statistics" permission.
- Restrict who can toggle counting and clear the counts table using the "Administer download statistics" permission.
- Clear/reset the entire download statistics table from the settings form.
- Automatically drop download rows when the underlying file entity is deleted (`hook_file_predelete`).
- Automatically reset the per-day counter once every 24 hours via cron.
- Provide a swappable storage backend (`download_statistics.storage.file`, tagged `backend_overridable`) for custom persistence.
- Programmatically read a file's stats with `download_statistics_get($fid)` or the storage service's `fetchDownload()` / `fetchDownloads()`.
- Migrate Drupal 7 "Download Count" behavior to Drupal 10/11/12.
- Measure demand for gated/premium private downloads (whitepapers, media, software).
