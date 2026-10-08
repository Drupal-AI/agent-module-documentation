<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories File Link — agent index

Adds a CKEditor 5 **"Insert file link"** toolbar button plus the text filter that renders the
resulting `<drupal-media-file-link>` tags as download links. No settings page, no
permissions, no services, no config object — only per-format filter settings.

- **Enable it on a text format, the link template + tokens, the icon setting, and the exact
  rendering rules** → [plugins/file-link.md](plugins/file-link.md)

Key facts:
- CKEditor 5 plugin id **`media_directories_file_link_button`**, toolbar item
  **`mediaFileLinkButton`** ("Insert file link"), allowed element
  `<drupal-media-file-link data-entity-uuid data-entity-type data-file-type>`,
  conditioned on filter `media_directories_file_link`.
- Filter plugin id **`media_directories_file_link`** ("Media file link"),
  `TYPE_TRANSFORM_REVERSIBLE`, **weight 95**. Settings: `template`
  (default `<a href="@file_url">@text</a>`) and `icon` (default `TRUE`).
- Tokens: `@file_url`, `@text`, `@name`, `@mime`, `@size`, `@uuid`, `@file_type`.
- Output is always wrapped in `<span class="media-file-link">`, plus
  `data-file-type="<category>"` when `icon` is on.
- File-type categories (`getFileTypeForMimeType()`): `file`, `text`, `image`, `audio`,
  `video`, `archive`, `spreadsheet`, `code`.
- Distinct from `media_directories_browser`'s `media_directories_browser_media_file_link`
  plugin, which adds a file picker **inside the standard link form** rather than a toolbar
  button.
