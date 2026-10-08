<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatically strips embedded EXIF metadata (GPS, device, timestamps) from uploaded JPEG images on file save.

---

EXIF Removal is a zero-configuration privacy module for Drupal 10.3+/11. It implements `hook_file_insert()` and, for every newly saved file entity whose MIME type is `image/jpeg`, hands the file to the `exif_removal.removal` service (`Drupal\exif_removal\ExifRemoval::exifRemoval()`). The service removes all EXIF metadata by re-encoding the image: it uses PHP's GD extension (`imagecreatefromjpeg()` then `imagejpeg()` at quality 80) by default, or the ImageMagick toolkit's `strip` operation when the optional `image_effects` module is installed and ImageMagick is the active toolkit. Because it hooks the generic file-insert event, it covers all upload paths (node/media fields, user pictures, the media library, and programmatic file saves) without any admin setup. It provides no settings form, routes, permissions, or config; only JPEG files are affected, and files with no EXIF data or when the PHP `exif`/GD functions are unavailable are left unchanged.

---

- Remove GPS coordinates from photos uploaded to a public Drupal site so image locations are not leaked.
- Strip camera make/model and lens details from user-submitted images.
- Delete capture date/time and other timestamp EXIF fields before images are published.
- Harden user profile picture uploads so personal metadata is not exposed.
- Sanitize images added through node or media entity image fields automatically.
- Clean images uploaded via the core Media Library without editor intervention.
- Enforce a site-wide image privacy policy with no per-field configuration.
- Reduce PII stored on the server by discarding EXIF at upload time.
- Comply with privacy/GDPR expectations for user-generated image content.
- Protect journalists', activists', or community-site users' location privacy on shared photos.
- Re-encode JPEGs at quality 80 to shrink file size while stripping metadata.
- Use ImageMagick's `strip` operation for metadata removal when `image_effects` and ImageMagick are configured.
- Fall back to GD automatically when ImageMagick/`image_effects` is not present.
- Cover programmatic file saves (e.g. migrations or custom upload code) that create JPEG file entities.
- Avoid third-party services or external binaries beyond PHP's own image libraries.
- Provide EXIF stripping without adding any admin UI or route surface to maintain.
- Combine with core image styles: metadata is removed from the original before derivatives are generated.
- Silently no-op on non-JPEG uploads (PNG, GIF, WebP) so those formats pass through untouched.
- Skip images that already contain no EXIF data to avoid unnecessary re-encoding.
- Log any processing exception to the `exif_removal` logger channel for later review.
- Deploy a lightweight, dependency-free privacy control on privacy-sensitive community platforms.
- Call the `exif_removal.removal` service directly from custom code to strip EXIF on demand.
