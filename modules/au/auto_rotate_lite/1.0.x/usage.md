Auto Rotate Lite adds one image-style effect that corrects photo orientation from EXIF metadata when a derivative is generated, without altering the original file.

---

The module ships a single image effect plugin, `AutoRotateLiteImageEffect` (`src/Plugin/ImageEffect/AutoRotateLiteImageEffect.php`, plugin id `auto_rotate_lite`). When an image style containing the effect is rendered, `applyEffect()` checks that PHP's `exif_read_data()` exists and that the source is `image/jpeg` or `image/tiff`, reads the EXIF `Orientation` tag, and rotates the derivative 180/90/270 degrees for orientation values 3/6/8 via the GD toolkit's `ImageInterface::rotate()`. `transformDimensions()` swaps the reported width and height for orientation values 5-8 so the image style computes correct dimensions before the file is built. Because the effect runs during derivative generation, the uploaded original is never modified. The module has no configuration form, no routes, no permissions, and no settings — it only registers the effect. It depends solely on Drupal core's `image` module, the GD toolkit, and PHP's `exif` extension; when EXIF support is missing or the format is unsupported it leaves the image untouched. It is a lighter alternative to the full Image Effects suite or the EXIF Orientation module (which rotates the original on upload).

---
- Add the "Auto Rotate Lite" effect to an image style at Configuration > Media > Image styles.
- Automatically straighten sideways or upside-down phone photos on display.
- Keep original uploads untouched — the effect applies to derivatives only.
- Rotate JPEG images based on their EXIF orientation flag.
- Rotate TIFF images based on their EXIF orientation flag.
- Get correct rendered width/height via dimension swapping for portrait/landscape-flipped photos.
- Combine the effect with core scale, crop, or resize effects in the same image style.
- Apply the corrected image style to media image fields and file/image fields.
- Reference the corrected style from responsive image style mappings.
- Avoid installing the heavier Image Effects suite for this single need.
- Rely only on Drupal core plus GD — no contrib dependencies or external libraries.
- Handle orientation values 3, 6 and 8 (180/90/270-degree rotation).
- Let each display opt in or out by adding the effect per image style.
- Fall back gracefully and skip rotation when no EXIF data is present.
- Skip non-JPEG/TIFF sources without changes.
- Continue working when the PHP `exif` extension is unavailable (image left unchanged).
- Log an error when a toolkit rotate call fails (via the module logger channel).
- Serve as a drop-in replacement for on-upload rotation modules when you prefer non-destructive derivatives.
- Support both Drupal 10 and Drupal 11 (`core_version_requirement: ^10 || ^11`).
- Use with any GD-based image toolkit configured on the site.
