<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails Tiff (media_thumbnails_tiff) — agent index

**Generates JPG thumbnails for TIFF media entities via the Media Thumbnails framework using the Imagick (ImageMagick) PHP extension.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** media_thumbnails:media_thumbnails; requires the `imagick` PHP extension + ImageMagick/Ghostscript binaries
- **Plugin:** `media_thumbnail_tiff` (`MediaThumbnail`, mime `image/tiff`) → `createThumbnail()` reads TIFF page 0, flattens, scales to configured width (default 500), writes `<uri>.jpg` via `file.repository`
- **Requirements hook:** errors if `imagick` extension missing
- **Security:** No `shell_exec`/`exec` — all processing via the Imagick object API (no shell-argument injection). Source path comes from a stored media URI resolved with `realpath` (not request input); every Imagick call is wrapped in try/catch returning NULL. No routes/permissions/services. Environment hardening (ImageMagick `policy.xml`, patched Ghostscript) recommended when parsing untrusted TIFFs.

See [configure/thumbnails.md](configure/thumbnails.md)