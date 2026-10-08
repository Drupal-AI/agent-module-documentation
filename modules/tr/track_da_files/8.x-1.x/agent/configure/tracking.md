<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring file tracking & reports

## Enable delivery
File URLs for **public** files are rewritten to `/system/tdf/<relative-path>` automatically:
- `track_da_files_create_url()` (in `.module`) builds the tracking URL for `public://` files.
- `TdfOutboundPathProcessor` / `TdfInboundPathProcessor` translate between the pretty path and the internal `/system/tdf` route + `file_path` query param.
- `TdfRequestSubscriber::onRequest` intercepts the request, calls `Tdf::track()`, and returns a `BinaryFileResponse` (adds `Content-Disposition: attachment` when `force` is set).

Use the TDF field formatters (`TdfImageFormatter`, `TdfGenericFileFormatter`, `TdfUrlPlainFormatter`, `TdfTableFormatter`) on file/image fields so their links point at the tracked endpoint.

## Choose what to record
At `/admin/config/media/track_da_files` (`administer track da files`) select:
- **displays_datas:** `total_ips`, `average_by_ip`, `last_display`, etc.
- **files_datas:** `timestamp` (created), `filesize`, `filemime`.

`Tdf::registerNewDisplay()` writes a row per display; browser info comes from the `browscap` service.

## View reports
- `/admin/reports/track_da_files` — per-file totals (`access site reports`).
- `/admin/reports/track_da_files/file_report/{fid}/{pid}` — one file's detail.
- `/admin/reports/track_da_files/user_report/{uid}` — one user's activity.
- Reset data with the `initialize tracked files displays datas` permission.

## Access notes
The `/system/tdf/*` delivery routes are open (`_access: TRUE`) but resolve only `public://` URIs; core's stream wrapper blocks any `..` traversal outside the public directory, so no non-public file is reachable through them.
