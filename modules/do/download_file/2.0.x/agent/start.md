<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download File (download_file) — agent index

Adds one file-field formatter (**Direct Download**) whose links point at a small controller that
serves the file bytes with attachment headers, so PDFs/images/docs save to disk instead of opening
inline. No config form, no permissions of its own, no config schema, no Drush. Depends only on core
`file`.

- Core: `^10.0 || ^11`. Package: `Fields`. `configure`: none.
- One field formatter, one route+controller, one alter hook, one theme hook/template. That is the
  whole module.

## What you'd do → where

- **Turn on direct download for a file field (select the formatter, its class/style settings)** →
  [fields/formatter.md](fields/formatter.md)
- **Understand/call the download route, the controller, the access check and the response headers** →
  [api/download-route.md](api/download-route.md)
- **Change the response headers per file (e.g. `Expires`, `Cache-Control`)** →
  [hooks/headers-alter.md](hooks/headers-alter.md)

## Key facts (real machine names)

- Formatter: `direct_download` (label "Direct Download"), field types `file` only, class
  `Drupal\download_file\Plugin\Field\FieldFormatter\DirectDownloadFormatter` (extends core
  `FileFormatterBase`). Settings keys: `class`, `styles` (both plain text, `Xss::filterAdmin`-ed).
- Route: `download_file.download_file_path` → `/download/file/{file}`; `{file}` upcast
  `type: entity:file` (numeric file id); controller
  `Drupal\download_file\Controller\DownloadFileController::downloadFileDirectDownload`; access
  callback `DownloadFileController::access` (`_custom_access`).
- Access body: `return $file->access('download', $account, TRUE);` — delegates entirely to core
  File access (private files stay protected; public files are public by core design).
- Response: `new BinaryFileResponse($file->getFileUri(), 200, $headers)` with `Content-Disposition:
  attachment`, `application/octet-stream`, `Accept-Ranges: bytes`, no-cache headers.
- Alter hook: `hook_download_file_headers_alter(array &$headers, FileInterface $file): void`
  (`download_file.api.php`).
- Theme hook `direct_download_file_link` + template `templates/direct-download-file-link.html.twig`;
  preprocess builds `link` from `link_text` + `url`.
