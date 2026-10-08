<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Compression — agent index

Compresses **JPEG/PNG** images with PHP **GD**, on upload or in bulk. Version **2.0.1**. Core `^8 || ^9 || ^10`.

- Settings: `/admin/config/user-interface/image_compression` (route `imagecompression.settings`); bulk: `/admin/config/user-interface/compress_existing_images`. Both require `administer site configuration`.
- Hook `image_compression_file_validate()` + `image_compression.manager` service; GD `imagejpeg()`/`imagepng()`.
- Security: pure GD — no external service (no TLS/key), no shell (no cmd injection), admin-only. Sound.
