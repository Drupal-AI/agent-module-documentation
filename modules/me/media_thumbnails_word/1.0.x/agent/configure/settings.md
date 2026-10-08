<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Media Thumbnails Word

## Prerequisites
- Media Thumbnails module enabled.
- PHP `imagick` extension loaded (plugin logs a warning and returns NULL otherwise).
- PhpOffice/PhpWord and mPDF available (via Composer / vendor).

## Set the mPDF library path
Route: `media_thumbnails_word.media_thumbnails_word_settings`
Path: `/admin/config/media/media-thumbnails-word-settings`
Permission: `administer site configuration`

Field **Path to mPDF library** → full directory path, e.g. `/var/www/vendor/mpdf/mpdf`.
The submit handler calls `is_dir()` and refuses to save a non-existent directory.

Stored as config `media_thumbnails_word.settings:mpdf_path` (default empty).

## How generation works (`MediaThumbnailsWord::createThumbnail`)
1. For `.doc`/`.docx`, PhpWord loads the file and sets the PDF renderer to MPDF using `mpdf_path`.
2. A `<source>.pdf` is written next to the source file.
3. Imagick reads page 0 of that PDF, flattens transparency onto white, scales to the framework width (default 500), converts to JPG.
4. The JPG is saved via `file.repository` as `<source>.jpg` (a managed file).

## Drush
Set the path without the UI:
`drush cset media_thumbnails_word.settings mpdf_path '/var/www/vendor/mpdf/mpdf' -y`
