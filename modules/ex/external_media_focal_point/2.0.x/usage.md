<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Media Focal Point provides an image field widget that combines the External Media upload/selection experience with the Focal Point crop tool, letting editors set a focal point (left/top offset in percent) on images sourced from third-party services.

It extends External Media's `ExternalMediaFile` widget and mirrors core's Image/Focal Point widget behavior: image validation, preview image style, a draggable focal-point indicator, and a preview link that opens the Focal Point preview via a CSRF-tokened modal.

---

- Depends on the `external_media` and `focal_point` contrib modules plus core `image`; Drupal 9.3+ or 10.
- Enable with `drush en external_media_focal_point`.
- On an image field's "Manage form display", choose the "External Media with Focal Point" widget.
- Configure the widget: preview image style (required), whether to show the preview link, and a default focal point value in `leftoffset,topoffset` percent form (e.g. `50,50`).
- The default focal point is validated with `focal_point.manager`'s validator; invalid values are rejected.

---

- Let editors set an image focal point on media uploaded from external/third-party sources.
- Reuse core image field settings (alt/title fields, min/max resolution, allowed extensions).
- Enforce image validation via `file_validate_is_image` and toolkit-supported extensions.
- Show a live preview thumbnail using a site-builder-selected preview image style.
- Display a draggable focal-point indicator over the preview image.
- Open a full Focal Point preview in an AJAX modal via a CSRF-protected token.
- Store the focal point as a Crop entity using the configured `focal_point.settings` crop type.
- Populate the focal point value from an existing crop when the widget loads.
- Provide a per-widget default focal point (`offsets`) for new images.
- Validate offsets are in the `x,y` percentage form.
- Support single- and multi-value (draggable) image fields.
- Integrate with Media Library forms (custom widget template for uploads).
- Add the preview image style as a config dependency and handle its removal gracefully.
- Capture images from mobile devices (`accept="image/*"`).
- Combine external media sourcing with per-image art-direction cropping.
- Keep aspect ratio guidance in the widget description for preview styles.
