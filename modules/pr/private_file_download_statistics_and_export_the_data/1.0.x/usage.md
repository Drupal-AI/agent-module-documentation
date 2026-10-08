<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private file download statistics and export the data

On-disk directory `private_file_download_statistics_and_export_the_data`; the real Drupal machine name is `file_download_user_track_export`. The module records private-file download events per user in `file_statistics_reports`, presents a dashboard with per-file download counts and downloader lists, and can export the list of downloading users (with selected user fields) to CSV.

---

# Installing & configuring

- Enable the module; configure which user fields are exported at `/admin/file-statistics/config` and view config menu at `/admin/private-files-statistics/config` (permission `access administration pages`).
- The statistics dashboard is at `/admin/files/statistics` (custom access — administrator role only).
- Data is stored in the `file_statistics_reports` table (serialized `users` list).
- Requires private file downloads to be routed through the site to be tracked.

---

- The dashboard route `/admin/files/statistics` uses `statisticsAccess()` which allows only authenticated users in the `administrator` role.
- `fileStatisticsExportCsv()` reads files from `public://file_statistics_report_download/` by a name built from the current uid + route arg.
- The exported CSV is written into the public files directory (`public://...`).
- Config form and menu use `access administration pages`.
- The install file defines the `file_statistics_reports` schema.
- Deletion redirects to the dashboard after running.
- Intended for admins auditing who downloads gated/private files.
