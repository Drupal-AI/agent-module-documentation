<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Effect adds an "advance resize" image effect to Drupal's image styles, with toolkit operations for both GD and ImageMagick (imagick), giving more control over resizing than the core resize/scale effects.

---

The module provides an `AdvanceResizeImageEffect` image-effect plugin plus matching `AdvanceResize` image-toolkit operations under `Plugin/ImageToolkit/Operation/gd/` and `.../imagick/`. Once installed, the effect appears in the image-style editor (`/admin/config/media/image-styles`) and can be added to any style with its own width/height/resize parameters, which are then applied when derivative images are generated.

This is an image-processing/media feature configured through the standard image-styles admin UI (which requires `administer image styles`). It has no bespoke routes or permissions and performs local image manipulation only.

---

- Add an advanced resize effect to image styles.
- Resize image derivatives with finer control.
- Support the GD image toolkit.
- Support the ImageMagick (imagick) image toolkit.
- Configure width and height for the effect.
- Add the effect through the image-styles admin UI.
- Generate resized derivatives on demand.
- Apply the effect to any image field using the style.
- Complement core scale/resize effects.
- Reuse Drupal's image-style caching for derivatives.
- Choose the toolkit via core image toolkit settings.
- Avoid custom code for advanced resizing.
- Work with responsive image styles that reference the style.
- Keep processing local (no external service).
- Require `administer image styles` to configure.
- Apply consistent sizing across content.
