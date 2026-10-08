<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Media Crop is a field widget that adds Image Widget Crop support to images imported from External Media sources.

---

External Media Crop bridges the External Media and Image Widget Crop modules: it provides a field widget (`external_media_image_widget_crop`) for image fields that lets editors upload/import an image from a third-party source and then define crop regions with the Image Widget Crop UI.

The single widget class extends External Media's `ExternalMediaFile` widget and mixes in Image Widget Crop's manager so that, after a file is selected, the configured crop types render inline and crop coordinates are saved against the file. It reuses core Image styles and Crop entities; there is no route, permission, service or admin page of its own — configuration is entirely through the field's form-display widget settings.

Enable it alongside its two dependencies, then set an image field's form-display widget to "External Media with Image Widget Crop" and choose which crop types to expose. It is a display/editing enhancement with no server endpoints.

---
- Crop images imported from an external media source.
- Add Image Widget Crop UI to an external-media image field.
- Choose which crop types appear on the widget.
- Define crop regions for third-party-hosted images.
- Reuse existing image styles with external images.
- Save crop coordinates against an uploaded file.
- Combine external image upload and cropping in one widget.
- Configure the widget via form-display settings.
- Support responsive crops for remote imagery.
- Let editors re-crop an external image after upload.
- Apply consistent crop ratios to imported images.
- Avoid a separate crop step for external media.
- Use crop entities produced by the widget in image styles.
- Enable per-field crop-type selection.
- Provide an AJAX crop preview on the field.
- Extend External Media's file widget with cropping.