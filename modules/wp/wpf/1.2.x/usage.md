<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webp fallback image (machine name `wpf`) generates on-demand `.jpg` copies of WebP image-style derivatives so browsers that cannot display WebP still get an image, using Drupal's Responsive Image module's `<picture>`/`srcset` fallback slot.

---

The intended setup is: convert images to WebP inside your image styles (core's "Convert" to webp effect), attach those styles through a **responsive image style**, and use that responsive image style in an entity display. `wpf` then hooks `hook_preprocess_responsive_image()` and rewrites the fallback `img` element's `#uri` from `.webp` to `.jpg` via its `wpf.image_factory` service (`ImageFactory::getJpg()`), so the `<img>` fallback points at a JPEG. The JPEG derivative itself is created **lazily**: the module's `RouteSubscriber` overrides the core image-style download controller (`image.style_public` / `image.style_private`) so that when a browser actually requests the `.jpg` derivative URL, `ImageFactory::createImageCopy()` produces it from the WebP derivative (using GD's `imagecreatefromwebp()`/`imagejpeg()`, or ImageMagick), at a configurable quality. This "generate only when requested" design avoids creating JPEGs that may never be used and keeps the WebP as the primary, best-quality asset. Settings live in `wpf.settings`: `quality` (JPEG quality, default 75) and `styles.disabled` (image styles for which no JPEG fallback is generated). The config form is at `/admin/config/media/wpf` (route `wpf.settings_form`). The module also cleans up fallback JPEGs when the source file is deleted (`hook_file_delete`) or a crop changes (`hook_crop_insert`/`hook_crop_update`). Requires `file`, `responsive_image`, and the GD extension.

---

- Serve a JPEG fallback to old browsers that cannot render WebP while modern browsers get WebP.
- Add WebP delivery to a site via responsive image styles without breaking legacy browser support.
- Generate the fallback JPEG only when a browser requests it, avoiding wasted derivatives.
- Keep WebP as the primary, highest-quality derivative and derive JPEG straight from it.
- Set the JPEG fallback quality (e.g. 60) site-wide via `wpf.settings` `quality`.
- Disable JPEG fallback generation for specific image styles you don't need it on.
- Use GD's native `imagecreatefromwebp()` to convert WebP derivatives to JPEG.
- Fall back to ImageMagick conversion when configured as the toolkit.
- Rewrite `srcset` URLs so each candidate WebP has a matching `.jpg` fallback.
- Automatically delete orphaned fallback JPEGs when the original file is deleted.
- Regenerate fallbacks when an image crop is inserted or updated (Image Widget Crop / crop API).
- Improve Core Web Vitals by shipping smaller WebP to capable browsers with a safe fallback.
- Avoid the sub-optimal "jpeg-then-webp" pipeline other modules use (wpf derives jpeg from webp).
- Configure fallback behaviour from a single admin form at /admin/config/media/wpf.
- Support both public and private image style delivery routes for fallbacks.
- Provide fallback images for responsive `<picture>` markup produced by Responsive Image.
- Roll out WebP across an image-heavy site (galleries, product images) with graceful degradation.
- Keep fallback JPEGs out of version control since they are generated on demand into the styles dir.
- Tune quality per environment by changing the `wpf.settings.quality` value.
- Ensure a broken/missing WebP still yields a usable JPEG in the same request when possible.
- Integrate WebP fallbacks into an existing responsive image workflow with minimal changes.
- Reduce bandwidth for modern users without dropping support for older clients.
