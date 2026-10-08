<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Style On Upload permanently applies a chosen image style to image files as they are uploaded, replacing the stored original with the processed derivative. It is typically used to cap the dimensions (e.g. width) of uploaded images so oversized originals never hit disk at full size.

---

The module implements `hook_file_presave()` (`image_style_on_upload.module`) and delegates to the `image_style_on_upload.utility.image_style_applier` service (`src/Utility/ImageStyleApplier.php`). On presave it acts only on **temporary** files whose MIME type is in the configured whitelist; it loads the configured image style, generates a derivative from the file URI via `ImageStyle::createDerivative()`, then moves that derivative back over the original URI (`FileExists::Replace`) and updates the file size. So unlike normal Drupal image styles — which keep the original and render derivatives on demand — this rewrites the source file itself at upload time. Configuration lives in `image_style_on_upload.settings` with two keys: `image_style` (the machine name of the style to apply, default `upload`) and `mime_types` (a space-separated MIME whitelist, default `image/gif image/jpeg image/png`). The module ships an optional `upload` image style (`config/optional/image.style.upload.yml`) that scales width to 2000px. The settings form is at `/admin/config/media/image_style_on_upload`, gated by the core `administer site configuration` permission (note: `info.yml` declares no `configure` route, so `configure` is null even though a form/menu link exist). No permissions of its own, no plugins, no Drush.

---

- Downscale every uploaded image to a maximum width so full-size originals are never stored.
- Reduce storage and bandwidth by processing images at upload instead of keeping huge originals.
- Apply a site-wide "upload" image style that scales images to 2000px wide out of the box.
- Restrict processing to JPEG/PNG/GIF via the MIME-type whitelist.
- Add or remove MIME types (e.g. include `image/webp`) that trigger processing.
- Normalize inconsistent editor uploads to a consistent maximum size.
- Strip oversized dimensions from user-submitted profile pictures on upload.
- Enforce a house style (dimensions, scaling) on all incoming image files.
- Pre-shrink images before other modules or fields process them, since the stored original is already reduced.
- Choose any existing image style (crop, scale, resize) to apply on upload.
- Cut down on server-side derivative generation cost by shrinking the source first.
- Prevent multi-megapixel phone photos from being stored at native resolution.
- Apply a watermark-or-scale style to every uploaded image automatically.
- Keep media library originals within a sane size budget.
- Ensure uploads via any file/image field get the same upload-time treatment.
- Switch the applied style globally by changing one config value.
