<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails Word (media_thumbnails_word) — agent index

**Media Thumbnails plugin that renders a JPG preview of Word (.doc/.docx) media via PhpWord → mPDF → Imagick.**

- **Version:** 1.0.x (release 1.0.0-rc1)
- **Core:** ^9.3 || ^10 || ^11
- **Dependency:** media_thumbnails
- **Plugin:** `@MediaThumbnail("media_thumbnail_word")` for `application/msword` and the OOXML wordprocessing MIME type
- **Config route:** `media_thumbnails_word.media_thumbnails_word_settings` → `/admin/config/media/media-thumbnails-word-settings` (permission `administer site configuration`)
- **Config:** `media_thumbnails_word.settings:mpdf_path`
- **Runtime needs:** `imagick` PHP extension; PhpOffice/PhpWord + mPDF libraries

See [configure/settings.md](configure/settings.md)

**Security:** Admin-only config route (`administer site configuration`); all thumbnail generation is server-side on uploaded media with no anonymous or mutating endpoints. Standard document-processing-library hygiene applies (keep PhpWord/mPDF/Imagick updated).
