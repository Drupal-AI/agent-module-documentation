<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Animated GIF makes Drupal render animated GIF images at their original, unprocessed URL so their animation is preserved, because image styles (which use GD) would otherwise flatten a GIF to a single frame.

---

Core's image styles process derivatives through the GD toolkit, which drops all but the first frame of an animated GIF. This module detects animated GIFs and, for those files, skips the image style so the original animated file is served. Detection is done by a service (`AnimatedGif`, id `Drupal\animated_gif\Service\AnimatedGifInterface`) whose `isFileAnAnimatedGif()` / `isAnAnimatedGif()` scan the file's bytes for GIF frame headers and return TRUE when at least two frames are found (a non-`image/gif` file is never animated). It ships a field formatter, `animated_gif_image_url` ("Animated GIF URL to image"), that behaves like core's Image URL formatter but outputs the original file URL for animated GIFs. It also implements several preprocess hooks (`preprocess_image_formatter`, `preprocess_responsive_image_formatter`, `preprocess_image_style`, `preprocess_responsive_image`) that, for animated GIFs, strip the image style / responsive `srcset` and render the raw image so the animation plays. Finally it warns editors on the image widget ("GIF images are not being processed by image styles, use with caution!") when an uploaded file is an animated GIF. There is no settings form or configure route — enable it, and existing image displays automatically bypass styles for animated GIFs; optionally switch a field to the `animated_gif_image_url` formatter when you need just the URL.

---

- Show animated GIFs on the site with their animation intact instead of a flattened first frame.
- Keep a hero or banner animated GIF animating even though the field uses an image style.
- Serve the original animated GIF file URL from an image field via the `animated_gif_image_url` formatter.
- Preserve GIF animation inside responsive image fields (strips the WebP/derivative `srcset`).
- Detect programmatically whether an uploaded file is an animated GIF via the AnimatedGif service.
- Warn content editors when they upload an animated GIF that won't be processed by image styles.
- Let editors mix animated GIFs and normal images in the same image field without breaking animation.
- Avoid writing a custom formatter or toolkit patch just to stop GIFs being flattened.
- Output an animated GIF's URL for use in a custom template or Twig without an image style.
- Keep animated GIF avatars/reactions animating in user or comment displays.
- Prevent broken derivatives when a content type's image field points at animated GIFs.
- Guard a decoupled front end by checking `isAnAnimatedGif()` before requesting a styled derivative.
- Support animated GIFs in Media image displays without a separate media type.
- Provide the raw URL of an animated GIF to a lightbox or gallery library.
- Ensure email or export templates reference the un-styled animated GIF file.
- Skip image-style generation cost for GIFs that must be served as-is.
- Combine with responsive images while still emitting a working animated GIF source.
- Confirm a file's animation status in a migration or cron job using the service.
- Show product demo GIFs animating on catalog pages built with image styles.
- Keep editorial illustration GIFs animating across all view modes automatically.
- Distinguish animated from static GIFs (≥2 frames) using the module's detection helper.
