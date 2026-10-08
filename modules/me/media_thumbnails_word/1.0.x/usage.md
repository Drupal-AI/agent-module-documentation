<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Thumbnails Word is a Media Thumbnails plugin that renders a JPG preview thumbnail of Word (.doc/.docx) media entities.

---

Drupal's Media Thumbnails framework lets contrib modules supply thumbnail generators keyed by MIME type. This module registers a `media_thumbnail_word` plugin for `application/msword` and `application/vnd.openxmlformats-officedocument.wordprocessingml.document`. When a Word file is added as media, `createThumbnail()` loads the document with PhpOffice/PhpWord, converts it to a PDF using the mPDF renderer, then rasterises the first page with Imagick, flattens transparency, scales it to the configured width, and writes a managed `.jpg` beside the source file.

Operationally the module needs three things present: the PHP `imagick` extension (it logs a warning and bails if absent), the PhpWord and mPDF libraries available via Composer, and the mPDF library path configured. That path is set at `/admin/config/media/media-thumbnails-word-settings` (route `media_thumbnails_word.media_thumbnails_word_settings`, permission `administer site configuration`); the submit handler rejects a path that is not an existing directory. All processing runs server-side on admin/editor-uploaded files — there are no anonymous or mutating routes — so the main risks are the usual document-processing library ones (keep PhpWord/mPDF/Imagick patched), not request-driven ones.

---

- Enable the module to auto-generate thumbnails for Word media
- Configure the mPDF library path at the settings form
- Provide preview images for .doc and .docx files in the media library
- Show Word document thumbnails in media reference field widgets
- Give editors a visual cue for Word files instead of a generic icon
- Ensure the `imagick` PHP extension is installed for thumbnail generation
- Require PhpOffice/PhpWord via Composer for document loading
- Require the mPDF renderer library for Word-to-PDF conversion
- Regenerate thumbnails after installing/patching the document libraries
- Scale generated thumbnails to the framework's configured width
- Produce JPG derivatives stored next to the source file as managed files
- Flatten transparency to a white background in the output image
- Surface a warning in logs when Imagick is missing
- Surface a warning in logs when the mPDF path is unset
- Validate the mPDF path is a real directory before saving
- Standardise document previews across an editorial team
- Combine with image styles applied to the generated thumbnail field
- Troubleshoot failed conversions via the logged Imagick exception messages
- Restrict the settings form to site administrators
- Use alongside other Media Thumbnails plugins (e.g. PDF) for full coverage
