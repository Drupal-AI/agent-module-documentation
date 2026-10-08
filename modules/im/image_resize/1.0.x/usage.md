<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Resizer resizes and re-encodes managed image files in place, on upload and on demand, via a cron-run queue.

---

Image Resizer targets the stored original file rather than its display derivatives. When a file is uploaded it is checked against a configured set of MIME types and an optional minimum file size, and matching files are placed on a queue. A queue worker (run on cron, or via `drush queue:run image_resize`) then loads each file, optionally downscales it to a maximum or minimum bounding box while preserving aspect ratio, and optionally converts it to another toolkit-supported format such as WebP or AVIF. It saves the result back over the managed file, updates the file entity's URI, name, MIME type and size, and rewrites the width/height stored on referencing image fields (current default revision only). With the ImageMagick toolkit a per-conversion quality override can be applied.

Because the conversion overwrites the original file and the change is irreversible, the module is best introduced against a backup or a representative copy first. Existing images are not processed automatically; the settings form offers a batch "Requeue existing images" action to enqueue everything that currently matches the criteria. The only route the module adds is its admin settings form at `/admin/config/media/image-resizer`, gated by the `administer site configuration` permission.

---

- Downscale oversized originals automatically when files are uploaded.
- Enforce a maximum bounding box (e.g. 3000x3000) across a media library.
- Enforce a minimum bounding box so images never fall below a size.
- Preserve aspect ratio while resizing (shorter/longer side scaled to fit).
- Convert JPEG/PNG originals to WebP to cut storage and bandwidth.
- Convert to AVIF where the toolkit and site support it.
- Standardise every stored image on a single enforced format.
- Set a per-conversion quality override with the ImageMagick toolkit.
- Skip small images with a minimum file-size threshold.
- Restrict processing to selected image MIME types only.
- Avoid re-resizing images only marginally over the limit via a pixel size threshold.
- Batch-requeue an entire existing media library to apply new settings.
- Process conversions in the background on cron instead of blocking uploads.
- Drain the queue on demand with `drush queue:run image_resize`.
- Reduce backup and storage footprint by shrinking source files.
- Start image-style derivatives from a smaller, cheaper source image.
- Keep referencing image fields' stored width/height in sync after resizing.
- Audit total image storage per MIME type from the settings form's tables.
- Requeue after changing settings so existing files pick up the new rules.
- Test the pipeline against representative images before a production rollout.
