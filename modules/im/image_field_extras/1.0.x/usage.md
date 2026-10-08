<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Field Extras extends Drupal's image field with two extra pieces of metadata — a photo credit and a caption — that editors enter alongside the uploaded image and that are stored and displayed with it.

---

The module adds an `ImageExtraItem` field item and an `ImageExtraStorage` service (backed by the data cache, cache-tag invalidator and database) that persists the extra photo-credit and caption values for image field items. It builds on the core `image` module, augmenting the standard image field/widget/formatter so the credit and caption travel with each image.

This is a content/metadata feature. The extra values are editorial content entered by users with field edit access and rendered through the field formatter; the module adds no routes or permissions and no access-control behavior beyond the field's own access.

---

- Add a photo-credit to image fields.
- Add a caption to image fields.
- Store credit and caption per image item.
- Display credit and caption with the image.
- Attribute photographers/sources on images.
- Provide accessible captions for images.
- Cache the extra image metadata for performance.
- Invalidate caches via cache tags on change.
- Build on the core image field.
- Enter values in the image field widget.
- Render values through the image field formatter.
- Keep metadata attached to the specific image item.
- Avoid a separate field for credits/captions.
- Support multiple image items per field.
- Require field edit access to set values.
- Add no routes or permissions.
