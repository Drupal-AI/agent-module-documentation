<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring JPEG compression

1. Enable the module.
2. Visit `/admin/config/system/simple_media_image_compression/config` (permission: core `administer site configuration`).
3. Tick **Enable Compression**.
4. Set **JPEG compression quality** (10 = smallest/lowest quality, 100 = largest/highest; default 70). The value must be numeric and between 10 and 100.
5. Save — values persist to `image_compression.qualitysettings`.

Trigger and behaviour:
- Compression runs on `hook_node_presave` and `hook_paragraph_presave`. Save (or re-save) content that references media of the `image` bundle to compress its JPEG file.
- Only `image/jpeg` / `image/jpg` files are processed; other formats are skipped.
- `compress_image_gd()` resolves the media's `field_media_image` file, gets its real path via the file system service, and calls `imagejpeg($image, $path, $quality)` — **overwriting the original file in place**. There is no backup, so keep source originals elsewhere if you need them; re-saving repeatedly recompresses and degrades quality further.
