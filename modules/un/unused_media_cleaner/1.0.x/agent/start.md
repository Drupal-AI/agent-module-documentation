<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unused Media Cleaner (unused_media_cleaner) — agent index

**Admin report + CSV export + batch delete for large/unused media entities.**

- **Version:** 1.0.x  •  core `^9 || ^10 || ^11`  •  package Custom  •  deps: media, file
- **Routes:** `.report` (`/admin/config/media/cleaner/report`, form, perm `access unused media cleaner`); `.export_csv` (`/admin/config/media/cleaner/export-csv`, perm `export unused media report`); `.delete_unused` (`/admin/config/media/cleaner/delete-unused`, perm `delete unused media`). All three permissions `restrict: TRUE`.
- **Storage:** report kept in `state` (`unused_media_cleaner.report_data`); deletion + report run via Batch API.
- **Access:** all routes permission-gated; queries use `accessCheck(TRUE)`; deletion is gated by `delete unused media` and asks for a JS `confirm()`. See [configure/report.md](configure/report.md).