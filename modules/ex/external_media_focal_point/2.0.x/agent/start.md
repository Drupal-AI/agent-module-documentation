<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Media Focal Point — agent orientation

Image field widget (D9.3/D10) merging External Media uploads with the Focal Point crop UI. Single class: `src/Plugin/Field/FieldWidget/ExternalMediaFocalPointWidget.php`, extending `Drupal\external_media\...\ExternalMediaFile`.

- Requires contrib `external_media` and `focal_point` plus core `image`.
- Widget settings: `preview_image_style` (required), `preview_link`, `offsets` (default `x,y`).
- Preview link uses `focal_point.preview` route guarded by a CSRF token (`Drupal::csrfToken()`), and Crop entities via `focal_point.manager`.
- Security: uploads go through core file/image validators; the preview route is CSRF-tokened. No server-side fetch of a request-supplied URL in this widget (remote sourcing is handled by external_media). No SSRF surface here.
