<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Track displayed files counts how often managed files are shown or downloaded by rewriting file URLs through tracking routes and recording each display with optional metadata (IP, browser via browscap, timestamps, filesize, mime).

---

File links are rewritten to `/system/tdf/<path>` (public scheme) by `track_da_files_create_url()` and an outbound path processor; an inbound path processor plus a kernel request subscriber (`TdfRequestSubscriber`) then serves the file with a `BinaryFileResponse` and records the display via the `Tdf` service. Reports live under `/admin/reports/track_da_files` (per-file and per-user breakdowns, `access site reports`), configuration under `/admin/config/media/track_da_files` (`administer track da files`), and dedicated field formatters (`TdfImageFormatter`, `TdfGenericFileFormatter`, `TdfUrlPlainFormatter`, `TdfTableFormatter`) emit tracked links. It also provides D7 migrate source plugins.

Security review: the public delivery routes `track_da_files.files` and `track_da_files.public_file_download` are `_access: 'TRUE'`, and the private route `/system/files/{file_uri}/{uritest}` uses `access content`. The public proxy builds a `public://` URI from the request path (`Tdf.php:115`) and serves any existing file there — but the scheme is hardcoded to `public` and Drupal's local stream wrapper (`FileSystem::realpath`) blocks traversal outside the public files directory, so it exposes only already-world-readable public files (note: it serves them even if unmanaged/not in `file_managed`). No path escapes the public dir and no private data is leaked by that route; the private-route controller method is an empty placeholder. Setup: enable the module, choose which datas to record on the settings form, and use the TDF field formatters on file/image fields.

---
- Count how many times a file is downloaded.
- Track image displays across the site.
- Record the IP address of each file display.
- Capture the browser/user-agent via browscap for each display.
- Report per-file display totals and last-display time.
- Show a per-user file-activity report.
- Compute average displays per IP.
- Use tracked field formatters on file/image fields.
- Force download (attachment) for tracked files.
- Configure which display datas are stored.
- Configure which file datas (size, mime, created) are stored.
- Reset/initialize report data with the dedicated permission.
- Restrict report viewing to `access site reports`.
- Migrate D7 track-da-files data via migrate source plugins.
- Serve public files through a counted proxy URL.
- Embed tracked images in content.
- Audit popular downloads for a site.
- Distinguish displays by entity id/type parameters.
- Provide a downloadable report table of tracked files.
- Theme tracked file links via a link template.
