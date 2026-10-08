<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Scale and Crop (Without Upscale) adds one image-style effect, "Scale and crop (without upscale)", that crops to a target aspect ratio exactly like core's Scale and Crop but never enlarges a source image already smaller than the target — a small upload stays small instead of being blown up into a blurry, pixelated derivative.

---

Core's Scale and Crop always emits an image at the configured dimensions, scaling up when the source is smaller; for an exact fixed box that is correct, but on a site where editors upload whatever they have it means a 400-pixel logo becomes a soft, artefacted 1200-pixel banner that nobody notices until production. Core's alternatives do not help: Scale alone will not crop to a ratio, and Scale and Crop cannot be told to stop. This module's effect fills that gap by subclassing core's `ScaleAndCropImageEffect` (`src/Plugin/ImageEffect/ScaleAndCropWithoutUpscaleImageEffect.php`): before delegating to the parent it recomputes the effective target so that when the source is smaller in either dimension the target box is shrunk to fit rather than the image being enlarged, preserving the configured aspect ratio and the chosen crop anchor. You add it to any image style through the normal Image styles UI (it reuses core's width/height/anchor form), and it also implements `transformDimensions()` so predicted `<img>` dimensions stay correct. Its only dependency is core `image`, it supports `^9 || ^10 || ^11`, and a `post_update` hook casts legacy string width/height config to integers without triggering a derivative flush. The design consequence to plan for is that derivatives are no longer guaranteed to be a fixed size, so a layout expecting exact dimensions needs CSS that tolerates a smaller image (`max-width`/`object-fit` rather than fixed `width`/`height`) — generally the better outcome than a stretched image, but a deliberate decision rather than a free win.

---

- Stop small uploads being blown up.
- Crop to an aspect ratio without upscaling.
- Avoid blurry banners from small logos.
- Keep image quality on editor uploads.
- Replace core Scale and Crop where quality matters.
- Protect a hero image from stretching.
- Handle a mixed-quality image library.
- Crop thumbnails without enlargement.
- Improve perceived quality of a listing.
- Avoid artefacts on small source images.
- Keep original size when it is under the target.
- Combine with responsive image styles.
- Reduce complaints about fuzzy images.
- Handle legacy images from a migration.
- Crop consistently without quality loss.
- Support a site still on Drupal 9, 10, or 11.
- Apply the effect to selected image styles only.
- Choose the crop anchor (center, top-left, etc.) per style.
- Add the effect to a style via drush php:eval.
- Keep predicted img dimensions accurate for lazy layouts.
- Enforce a max resolution while allowing smaller outputs.
