<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: a Field formatter plugin (`AvatarFormatter`) that displays image fields as avatar-styled images.
- When: you want user pictures or image fields rendered as consistent avatar thumbnails.

---

- Enable the module; no dependencies beyond core image/field.
- On an image field's Manage Display, select the Avatar formatter and set its options.

---

- Registers a `@FieldFormatter` plugin (`src/Plugin/Field/FieldFormatter/AvatarFormatter.php`).
- Applies to image fields, including the user picture field.
- Renders the image with avatar presentation (size/shape) per the formatter settings.
- Use it for author bylines, comment authors, or member listings.
- Configure the image style/size through the formatter's settings form.
- No routes, permissions, or services are provided; display-layer only.
- Assign per view mode so different displays can show different avatar sizes.
- Works with core Image module image styles for cropping/resizing.
- Falls back gracefully when no image is present.
- Combine with a default/placeholder image style for empty values.
- Keep image styles defined so avatars are consistently sized.
- Clear caches after assigning the formatter so the display rebuilds.
- Ideal for profile and community-oriented themes.
- Lightweight: a single formatter plugin.
- No effect on stored data, only presentation.
- Version 2.0.x supports Drupal 8/9/10.
