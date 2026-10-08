<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# file_download_user_track_export — agent orientation

Tracks private-file downloads per user; dashboard + CSV export of downloader emails. (On-disk dir `private_file_download_statistics_and_export_the_data`; machine name `file_download_user_track_export`.)

- Version 1.0.x, core `^8||^9||^10`. Dashboard `/admin/files/statistics` = administrator-only via `statisticsAccess()`.
- Item routes: `/admin/file/get/{fileId}`, `/admin/file/delete/{fileId}`, `/admin/file/export/{Id}`, `/export/csv/{uid}` (see routing.yml + FileDownloadUserTrackExportController).
- Exports are written to `public://file_statistics_report_download/`.
