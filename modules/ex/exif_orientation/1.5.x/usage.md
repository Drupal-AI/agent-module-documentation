EXIF Orientation automatically rotates uploaded JPEG and PNG images to match their EXIF Orientation tag, so photos taken on phones and cameras appear upright everywhere.

---

Many phones and cameras (iPhone 4 and up, for example) save every photo in the sensor's native landscape orientation and record how it should be displayed in the image's EXIF `Orientation` tag rather than physically rotating the pixels. Browsers and image toolkits often ignore that tag, so the photo appears sideways or upside-down. EXIF Orientation fixes this at upload time: it implements `hook_file_presave()`, reads the EXIF data with PHP's `exif_read_data()`, and physically rotates the stored file using Drupal's image toolkit (`image.factory`) so the saved image is already correctly oriented. It handles the three rotation-only orientation values — 3 (180°), 6 (90°) and 8 (270°) — and leaves images without an Orientation tag untouched; odd/mirrored (flipped) values are not corrected. It also adds an upload validator (`exif_orientation_validate_image_rotation`) that runs before core's `file_validate_image_resolution`, so the rotation happens before any resize can strip the EXIF data. The module works entirely automatically once enabled: there is no configuration UI, no settings, no permissions, and no image style effect to add. It only acts on `image/jpeg` and `image/png` MIME types and requires PHP's EXIF extension to be available.

---

- Auto-rotate iPhone/Android photos uploaded to image fields so they display upright.
- Correct camera photos saved in landscape with an EXIF Orientation tag.
- Fix sideways user profile pictures uploaded from mobile devices.
- Rotate images 180° when the EXIF Orientation is 3.
- Rotate images 90° when the EXIF Orientation is 6.
- Rotate images 270° when the EXIF Orientation is 8.
- Ensure the stored master image is oriented before any image style is generated from it.
- Rotate the file before `file_validate_image_resolution` resizes it and loses EXIF data.
- Normalize orientation across a media library so thumbnails are consistent.
- Apply correct orientation to JPEG uploads without editing photos manually.
- Apply correct orientation to PNG uploads that carry an EXIF Orientation tag.
- Avoid teaching editors to pre-rotate photos before upload.
- Leave images without an Orientation tag unchanged (no unnecessary re-encoding).
- Keep a decoupled/headless image API serving already-upright images to clients.
- Improve display of user-generated photo content on public sites.
- Correct orientation for photos in webform or file-field submissions.
- Ensure derivative images (crops, responsive styles) inherit the correct orientation.
- Run rotation server-side so no client-side JavaScript orientation hack is needed.
- Enable site-wide auto-orientation just by installing and enabling the module.
- Handle bulk photo imports where source images rely on EXIF orientation.
- Serve correctly oriented images to browsers that ignore the EXIF tag.
- Reuse the `exif_orientation_validate_image_rotation()` validator on a custom file field.
- Trigger rotation manually in code by re-saving a file entity (fires `hook_file_presave`).
