<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails PDF — agent index

Adds one **Media Thumbnails** plugin that turns the first page of a PDF media entity into a JPG
thumbnail. No config of its own (`configure: null`), no permissions, no Drush, no config schema.
Requires the **`media_thumbnails`** module and the **ImageMagick PHP extension** (`ext-imagick`,
plus a Ghostscript delegate to rasterize PDFs).

- **The `media_thumbnail_pdf` plugin, how thumbnails are triggered/generated, requirements, and
  the (parent-owned) settings that affect it** → [configure/thumbnails.md](configure/thumbnails.md)

Key facts:
- Plugin: `MediaThumbnailPDF`, `@MediaThumbnail` id **`media_thumbnail_pdf`**, mime
  **`application/pdf`**, extends `media_thumbnails`' `MediaThumbnailBase`.
- Fires from `media_thumbnails`' `hook_media_presave` → `MediaThumbnailManager::createThumbnail()`
  (matched by the source file's mime type). Output: a managed JPG at `<source-uri>.jpg`.
- Thumbnail **width** and background come from the parent's `media_thumbnails.settings`
  (width default 500) — this module adds no settings.
