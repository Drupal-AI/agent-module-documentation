<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Image Widget Crop makes the Image Widget Crop widget skip SVG files, which have no raster dimensions to crop.

---

It ships a single form element, `Drupal\svg_image_widget_crop\Element\ImageCrop`, that extends Image Widget Crop's `image_crop` element and overrides `processCrop()`. When the `svg_image` module is present and the uploaded file's MIME type is an SVG (`image/svg...`), it returns the element unchanged (no crop UI); otherwise it defers to the parent crop processing. This prevents broken/empty crop widgets and JS errors when editors attach SVGs to image fields that use Image Widget Crop. The module has no routes, permissions, services, config, or settings — it is a pure behavioural patch that depends on `image_widget_crop` and `svg_image`.

Security: this module does **not** render SVGs and performs no sanitisation — it only bypasses the crop UI for them. SVG display and any sanitisation are the responsibility of the `svg_image` dependency, so this module introduces no XSS surface of its own. Typical setup is simply enabling it alongside Image Widget Crop and SVG Image; the exclusion is automatic with no configuration.

---

- Enable it alongside Image Widget Crop and SVG Image.
- Let editors upload SVGs to image fields that use the crop widget.
- Avoid a broken/empty crop UI appearing for SVG uploads.
- Prevent JavaScript crop errors when an SVG has no raster dimensions.
- Keep raster images (PNG/JPG) cropping normally through the parent element.
- Mix SVG and raster media in the same crop-enabled image field.
- Use SVG logos/icons in fields configured with crop types.
- Rely on automatic MIME-based detection (`image/svg`) — no configuration.
- Remove the need to create separate non-crop fields just for SVGs.
- Support content types that accept both vector and photographic images.
- Delegate SVG rendering/sanitisation to the `svg_image` dependency.
- Drop it in as a small compatibility shim for existing crop setups.
- Confirm behaviour with a functional test of an SVG upload.
- Uninstall cleanly — it stores no config or state.
- Use across Drupal 8.8–11 (broad core compatibility).
