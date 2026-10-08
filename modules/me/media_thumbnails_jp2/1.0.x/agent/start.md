<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Thumbnails Jp2 (media_thumbnails_jp2) — agent index

**Media Thumbnails plugin that generates JPEG preview thumbnails for JP2 (JPEG 2000) media via ImageMagick.**

- **Version:** 1.0.x (1.0.1)  ·  **Core:** ^9 || ^10 || ^11  ·  **Package:** Media
- **Depends on:** media_thumbnails. Requires ImageMagick (with JP2 delegate) + the Imagick PHP extension.
- **Provides:** `@MediaThumbnail` plugin `media_thumbnail_jp2` (`MediaThumbnailJp2`), scoped to MIME `image/jp2`.
- **Behaviour:** `createThumbnail()` resizes the source to a configurable width (default 500) and writes a managed `<uri>.jpg`, falling back to the generic media icon on failure.
- **No routes, permissions, or config forms of its own.**
