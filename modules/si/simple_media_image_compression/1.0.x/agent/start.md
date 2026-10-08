<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Media Image compression (simple_media_image_compression) — agent index

**Re-compresses JPEG media images via GD on node/paragraph presave, at a configurable quality.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Route/permission:** `image_compression.settings` (`/admin/config/system/simple_media_image_compression/config`) requires core `administer site configuration`.
- **Config:** `image_compression.qualitysettings` — `enable_compression` (bool), `jpegquality` (10–100, default 70).
- **Mechanism:** `hook_node_presave` / `hook_paragraph_presave` find media-`image` reference fields and run `imagejpeg()` in place on JPEG files only.
- **Security:** admin-config route only, permission-gated. Operates on already-uploaded media files; no anonymous endpoints, no external calls, no secrets. Caveat: compression is **lossy and overwrites the original file on disk** (no backup); JPEG-only.

See [configure/settings.md](configure/settings.md)
