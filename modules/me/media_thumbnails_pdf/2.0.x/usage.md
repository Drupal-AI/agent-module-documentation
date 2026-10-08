<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails PDF is a plugin for the Media Thumbnails framework that renders the first page of a PDF media entity as a JPG image and uses it as the media entity's thumbnail, so PDF media shows a real preview instead of a generic file icon.

---

The module ships a single plugin, `MediaThumbnailPDF` (a `@MediaThumbnail` plugin, id `media_thumbnail_pdf`, registered for mime type `application/pdf`), extending the parent `media_thumbnails` module's `MediaThumbnailBase`. When a media entity is saved, `media_thumbnails`' `hook_media_presave` asks its `MediaThumbnailManager` for the plugin matching the source file's mime type; for PDFs that is this plugin, whose `createThumbnail($sourceUri)` runs. Because Imagick can't use stream wrappers, it copies the file to a temp path, opens page `[0]` with Imagick (sRGB colorspace), flattens transparency onto a white background, scales the image down to the globally configured thumbnail width if it is wider, converts it to JPG, and writes a managed file at `<source-uri>.jpg`, which becomes the media entity's `thumbnail`. It requires the **ImageMagick PHP extension** (`ext-imagick`) — a `hook_requirements` marks the module in error if `imagick` is not loaded — and in practice a Ghostscript delegate for Imagick to rasterize PDFs. There is **no configuration of its own** (`configure: null`): the thumbnail **width** (default 500) and background handling come from the parent module's `media_thumbnails.settings`. No permissions, no Drush, no config schema; it is a focused thumbnail generator that plugs into Media Thumbnails.

---

- Show a real first-page preview for PDF documents in the media library instead of a generic icon.
- Automatically generate a JPG thumbnail whenever a PDF media entity is created or updated.
- Give editors a visual cue to distinguish PDF media items at a glance.
- Render uploaded report/brochure PDFs as image thumbnails on listing pages.
- Produce consistent, white-background thumbnails for PDFs with transparency.
- Constrain PDF thumbnail width via the global Media Thumbnails setting (default 500px).
- Provide preview images for a document media type backed by PDF files.
- Improve the look of a media grid that mixes images and PDF documents.
- Regenerate a PDF's thumbnail on update via the parent framework's update/delete handling.
- Use the first page of a multi-page PDF as its representative image.
- Integrate PDF previews into Media Library selection dialogs.
- Feed generated PDF thumbnails into image styles for responsive display.
- Offer downloadable-document listings with meaningful visual previews.
- Replace the default file icon for `application/pdf` media with a rendered page image.
- Support catalog/portfolio sites where PDFs need visual browsing.
- Generate thumbnails server-side using ImageMagick/Ghostscript with no manual steps.
- Keep thumbnails as managed files so they participate in file usage tracking.
- Pair with Media Thumbnails' other plugins to cover multiple file types with previews.
- Give content teams automatic PDF cover images without a separate upload.
- Ensure PDF media entities render an <img> preview in views and formatters.
