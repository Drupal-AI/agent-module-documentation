<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Preview (pdfpreview) — agent index

Rasterises the **first page of an uploaded PDF** into a JPG/PNG thumbnail and shows it through a
file-field formatter. Version **8.x-1.2**, core `^10 || ^11`. Depends on core `image` and the
`imagemagick` contrib module (`>=8.x-3.7`); ImageMagick does not need to be the default toolkit.

Settings page: **`pdfpreview.settings`** at `/admin/config/media/pdfpreview` (permission
`administer site configuration`). No permissions, Drush commands, or plugin types of its own; it
defines one field formatter plugin (`pdfpreview`) and one service.

- **Global preview settings (size, quality, path, filename scheme, image type)** →
  [configure/settings.md](configure/settings.md)
- **The `pdfpreview` file-field formatter and its per-display options** → [fields/formatter.md](fields/formatter.md)
- **The `pdfpreview.generator` service and preview lifecycle (generate/delete/update)** →
  [api/generator.md](api/generator.md)

Key facts:
- Config object `pdfpreview.settings`, keys: `quality` (int, 75), `size` (string, `1024x1024`),
  `path` (string, `pdfpreview`), `filenames` (`human`|`machine`, `human`), `type` (`png`|`jpg`, `png`),
  `show_description` (bool), `tag` (`span`|`div`), `fallback_formatter` (string).
- Service `pdfpreview.generator` → `Drupal\pdfpreview\PDFPreviewGenerator`; public methods
  `getPDFPreview()`, `deletePDFPreview()`, `updatePDFPreview()`.
- Formatter plugin id `pdfpreview` (`Drupal\pdfpreview\Plugin\Field\FieldFormatter\PDFPreviewFormatter`,
  extends core `ImageFormatter`, `field_types = {file}`).
- Theme hook `pdfpreview_formatter` (template `pdfpreview-formatter.html.twig`), registered as a
  theme wrapper by the formatter.
- Regenerates/cleans previews via `hook_file_update` and `hook_file_delete`.
- Update hook `pdfpreview_update_8001` sets `type` to `jpg` on existing sites.
