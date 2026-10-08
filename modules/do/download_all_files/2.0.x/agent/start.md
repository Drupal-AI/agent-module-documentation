<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Download All Files (download_all_files) — agent index

Adds a "download all" link to a core **File**/**Image** field. The field formatter
`file_download_all` ("Table of files with download all link") renders the field as a table of its
files plus one link to a route that zips every file in the field and streams it as an attachment.
Zipping is on demand — the archive is built from the field itself at request time, so it never drifts
out of step with the files the way a hand-maintained second zip would. Depends only on core `file`.

Mechanism: the formatter builds `Url::fromRoute('download_all_files.download_path', {entity_type,
entity, field_name})`; that route resolves to `DownloadController::downloadAllFiles()`, which loads
each referenced `file` entity, adds it to a `\ZipArchive` (via the module's `Zip` archiver plugin)
under a temp path, and returns a `BinaryFileResponse` with a `Content-Disposition: attachment`.

- Depends on: `drupal:file`.
- Core: `^10.2 || ^11`. Package: `Files`.
- **No settings page / `configure` route.** All configuration is per field-display (the formatter's
  settings on Manage display). No permissions, no drush, no config schema shipped.
- One field formatter (`file_download_all`) and one archiver plugin (`DownloadAllFileZip`). There is
  **no block plugin** despite the info.yml description mentioning one — it is not in the code.

## What you'd do → where

- **Understand / call the download route and controller (archiver included)** →
  [api/download.md](api/download.md)
- **Turn on the "download all" link for a file/image field and tune its display** →
  [fields/download-all-formatter.md](fields/download-all-formatter.md)

## Key facts (real machine names)

- Route: `download_all_files.download_path` —
  `/download_all_files/{entity_type}/{entity}/{field_name}`, controller
  `Drupal\download_all_files\Controller\DownloadController::downloadAllFiles`, access callback
  `::access` (`_custom_access`). Route option `parameters.entity.type: entity:{entity_type}`.
- Controller service args: `file_system`, `event_dispatcher`.
- Field formatter: id `file_download_all`, label "Table of files with download all link", field
  types `file`, `image`; class `Plugin\Field\FieldFormatter\DownloadAllFormatter` (extends
  `EntityReferenceFormatterBase`).
- Formatter settings keys: `use_description_as_link_text`, `details`, `details_state`,
  `details_title`, `simple_theme`, `link_position`, `link_icon`, `link_title`.
- Archiver plugin: id `DownloadAllFileZip`, class `Plugin\Archiver\Zip` (extends core
  `Drupal\Core\Archiver\Zip`), extensions `{"zip"}`.
- Library: `download_all_files/theme` (CSS `css/download_all_files.css`). Icon:
  `images/downloadIcon.svg`.
- Hooks: `hook_help` only (`download_all_files.module`).
