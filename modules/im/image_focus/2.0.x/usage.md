Image Focus adds a "Focus Scale and Crop" image effect that computes an image's focal point automatically (using an entropy measure) so scale-and-crop image styles keep the interesting part of the image instead of blindly cropping the centre.

---

The module provides one image effect plugin, `image_focus_scale_crop` ("Focus Scale and Crop", `FocusScaleCropImageEffect`), which extends core's `ResizeImageEffect`. On apply it computes a focal point (`cx`,`cy`), scales the image so the target width×height fits, then crops around the focal point (clamped to the image bounds). The focal point comes from `ImageFocusEntropy`: the image is loaded via `imagecreatefrom<ext>()`, split into square zones, and the Shannon entropy of each zone's RGB histogram is computed; the entropy-weighted centre of mass is the focal point (falling back to the geometric centre if GD can't load the source). Because it reads pixels through PHP GD directly on the source file, it works alongside either the GD or ImageMagick toolkit. Configuration: add the effect to an image style at `admin/config/media/image-styles` (it takes width/height like a normal resize) and, on the module settings page `admin/config/media/image-focus-settings` (route `image_focus.image_focus_settings`, permission `administer site configuration`), set `image_focus_face_detection_maxsize` (KB; default 50) — the schema also carries a `face_detect` boolean, though the shipped 2.0.x effect uses only the entropy method. No permissions, Drush, or plugin types of its own; depends on core `image`.

---

- Automatically keep the subject in frame when generating cropped image derivatives.
- Add smart scale-and-crop to a responsive image style without manual focal points.
- Replace core "Scale and crop" with an entropy-aware crop for thumbnails.
- Produce better square thumbnails from landscape or portrait source images.
- Generate teaser/card images that don't cut off the main subject.
- Crop hero/banner derivatives toward the busiest (highest-entropy) region.
- Work with either GD or ImageMagick toolkits (reads pixels via GD directly).
- Avoid installing a JS focal-point picker where automatic cropping suffices.
- Apply consistent smart cropping across many uploaded images at scale.
- Configure the effect's target width and height like any resize effect.
- Fall back gracefully to centre-crop when the source can't be decoded.
- Cap the max image size (KB) considered, to bound processing cost.
- Improve gallery grids by focusing each crop on its content.
- Create avatar crops that tend to keep faces/subjects visible.
- Build multiple image styles reusing the same focus effect at different sizes.
- Serve better social-share images by cropping toward the salient area.
- Reduce editor effort — no per-image crop settings needed.
- Combine with other image effects (convert, desaturate) in the same style.
- Handle JPEG, PNG and other GD-readable formats via `imagecreatefrom*`.
- Provide smart cropping for Media-library-managed images through image styles.
