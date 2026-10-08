<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Media Crop (external_media_crop) — agent index

**Field widget adding Image Widget Crop support to images imported via External Media.**

- **Version:** 2.0.x
- **Core:** `^8.9 || ^9 || ^10`
- **Deps:** `external_media`, `image_widget_crop`, core `image`.
- **Provides:** one FieldWidget `external_media_image_widget_crop` (`ExternalMediaImageWidgetCrop`, extends `ExternalMediaFile`) for image fields.
- **Config:** via the field form-display widget settings (crop-type selection); no routes/permissions/services.

**Security:** No routes, permissions, services or SQL — a pure editing-UI widget. No security-relevant surface.