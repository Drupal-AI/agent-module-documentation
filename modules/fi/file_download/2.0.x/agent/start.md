<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Download — agent index

Provides field formatters that render file/image fields as **forced-download** links (browser saves
the file as an attachment instead of opening it). No global settings page (`configure: null`); each
field is configured on its *Manage display*. Ships a submodule `file_download_counter`.

- **The two formatters (`file_download_formatter`, `file_download_uri_formatter`), their settings
  keys, and how to set them on a field display** → [configure/formatter.md](configure/formatter.md)
- **The download route/controller, the forced-attachment headers, the `access file download`
  permission, `hook_file_download`, theme hooks and the `file:type` token** →
  [api/download.md](api/download.md)

Submodule: [file_download_counter](../../modules/file_download_counter/2.0.x/agent/start.md) — logs
per-file download counts and adds a Views field + "Popular content" block.

Key facts:
- Formatter ids: `file_download_formatter` (file + image), `file_download_uri_formatter`.
- Download route: `file_download.link` → `/file-download/download/{scheme}/{fid}` → controller streams
  the file with `Content-Disposition: attachment`.
- Permission: `access file download`. Config schema: `field.formatter.settings.file_download_formatter`
  and `…file_download_uri_formatter`.
