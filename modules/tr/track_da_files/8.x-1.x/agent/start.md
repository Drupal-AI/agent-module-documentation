<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Track displayed files (track_da_files) — agent index

**Counts file displays/downloads by proxying delivery through tracking routes and recording IP/browser/timestamp data.**

- **Version:** 8.x-1.x (8.x-1.0) · **Core:** ^9.4 || ^10 || ^11 · **Depends:** field, file, browscap
- **Configure:** `track_da_files.settings` (`administer track da files`, restricted).
- **Report routes:** `/admin/reports/track_da_files[...]` — `_permission: 'access site reports'`.
- **Delivery routes:** `track_da_files.files` `/system/tdf/{scheme}` and `track_da_files.public_file_download` `/system/tdf/{filepath}` — `_access: 'TRUE'`; `track_da_files.tracking_private` `/system/files/{file_uri}/{uritest}` — `access content`.
- **Services:** `Tdf` tracking service, inbound/outbound path processors, `TdfRequestSubscriber` (serves BinaryFileResponse); field formatters `Tdf{Image,GenericFile,UrlPlain,Table}Formatter`.
- **Permissions:** `administer track da files`, `initialize tracked files displays datas` (both restricted).
- **Security:** public delivery routes are anonymous but limited to the hardcoded `public://` scheme (`Tdf.php:29,115`); core stream-wrapper realpath prevents traversal outside the public files dir, so only already-public files are served (served even if unmanaged). Private-route controller is an empty placeholder. No path escapes public dir; no private leak observed. Reports/config are permission-gated.

See [configure/tracking.md](configure/tracking.md)
