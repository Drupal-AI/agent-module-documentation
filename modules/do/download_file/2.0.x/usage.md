<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Download File adds a *Direct Download* formatter for file fields: instead of linking to the file so the browser decides whether to display it, links point at a controller that serves the bytes with download headers, so PDFs and images save to disk rather than opening in a tab.

---

Core's file formatters produce a link straight to the file URL, and what happens next is the browser's business — PDFs, images and text files typically render inline. This module routes downloads through Drupal instead. The `direct_download` field formatter renders links to `/download/file/{file}` using the `direct-download-file-link.html.twig` template, and `DownloadFileController::downloadFileDirectDownload()` returns a `BinaryFileResponse` built from `$file->getFileUri()` with headers that force a download. Access is not an afterthought: the route uses a `_custom_access` callback that simply defers to `$file->access('download', $account, TRUE)`, so the module inherits whatever download access rules apply to that file — private-file access checks included — rather than inventing its own. A `hook_download_file_headers_alter(array &$headers, FileInterface $file)` hook lets other modules adjust the response headers per file, the documented example being `Expires`. There is no configuration form, no permissions of its own, no config schema and no Drush; the only setting is choosing the formatter on a file field's display.

---

- Force a PDF to download instead of opening in the browser.
- Make image attachments save to disk rather than display.
- Serve document downloads consistently across browsers.
- Keep a download counter or log by routing through Drupal.
- Force downloads for private files while preserving access checks.
- Add custom cache headers per file with the alter hook.
- Provide a "download" link distinct from a "view" link.
- Ensure spreadsheets download rather than open in a viewer plugin.
- Serve files with a predictable Content-Disposition.
- Use a themable link template for download links.
- Give editors a per-display choice between inline and download.
- Prevent inline rendering of files that could be risky to display.
- Apply download behaviour only to selected view modes.
- Keep file access enforcement in Drupal's hands.
- Serve large binaries efficiently via BinaryFileResponse.
- Add expiry headers to downloads for CDN behaviour.
- Provide direct download links inside a view.
- Support both public and private file schemes.
- Avoid custom controller code for a common requirement.
- Keep the download URL stable regardless of the file's storage path.
