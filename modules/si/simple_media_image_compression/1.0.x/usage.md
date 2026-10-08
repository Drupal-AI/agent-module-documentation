<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Media Image Compression re-compresses JPEG images referenced by media fields when a node or paragraph is saved, using PHP's GD library to shrink file size at a configurable quality.
---
A settings form at `/admin/config/system/simple_media_image_compression/config` stores two values in `image_compression.qualitysettings`: an **Enable Compression** checkbox and a **JPEG quality** value (validated to a number between 10 and 100, default 70). On `hook_node_presave` and `hook_paragraph_presave`, when compression is enabled, the module walks the entity's fields, finds entity-reference fields targeting the media `image` bundle, resolves each media item's `field_media_image` file, and — only for `image/jpeg`/`image/jpg` mime types — re-encodes the file in place with `imagejpeg(..., $quality)`. Non-JPEG images are left untouched.

Operationally, the module rewrites the original file on disk at its real path, so compression is lossy and destructive to the stored original; there is no backup of the pre-compression file. The settings route is gated by the core `administer site configuration` permission. There are no anonymous endpoints, no external calls and no secrets; input is limited to already-uploaded media files, and the quality value is numerically validated. Setup: enable the module, open the settings form, tick Enable Compression and set a quality, then save and edit/save content to trigger compression.
---
- Reduce JPEG file sizes automatically on content save
- Set a global JPEG compression quality (10–100)
- Enable or disable compression from a settings form
- Compress images referenced by media fields on nodes
- Compress images referenced by media fields on paragraphs
- Lower bandwidth for image-heavy pages
- Apply a consistent quality across all uploaded JPEGs
- Leave non-JPEG images (PNG, etc.) untouched
- Trigger compression by editing and saving existing content
- Default to quality 70 when none is set
- Validate that the quality value is a number between 10 and 100
- Restrict the settings form to site administrators
- Optimise media library JPEGs without an external service
- Use the local GD library, avoiding third-party APIs
- Save storage space on the file system
- Improve page-load performance for photographic content
- Compress on presave so no extra queue is needed
- Target only the media `image` bundle's file field
- Roll out compression per environment via config
- Turn compression off temporarily during bulk imports
