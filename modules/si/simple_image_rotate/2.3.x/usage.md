<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Image Rotate adds a "Rotate image clockwise" button next to uploaded images on entity edit forms, letting editors rotate an image field's picture, with the rotation applied to the actual file when the entity is saved.

---

The module enhances core **image** fields. On an image field's *Field settings* edit form it adds
an **"Enable rotate function"** checkbox, stored as a third-party setting
`simple_image_rotate.enable_rotate` on that field's `FieldConfig`
(`field.field.<entity>.<bundle>.<field>`). When enabled — and the current user has the
`rotate images` permission — the field widget attaches a JS/CSS library and shows a rotate button
plus a hidden `rotate` value on each uploaded image; the JavaScript rotates the preview in the
browser and records the chosen angle. On save, `hook_entity_presave()` reads that angle and, for
each image with a non-zero rotation, moves the file to a new name with an `_r<counter>` suffix,
rotates the real image via the image factory (`$image->rotate()`), updates width/height/filesize,
and resets the `rotate` value to 0 (making the operation idempotent). It has **no configuration
page** (`configure: null`) and no config object of its own — only the per-field third-party
setting and the `rotate images` permission. It works only on image fields (no effect elsewhere),
and needs the core Image module.

---

- Give editors a one-click "rotate clockwise" button on image uploads in a node form.
- Fix sideways phone photos at upload time without an external editor.
- Enable rotation on a specific image field via its "Enable rotate function" checkbox.
- Rotate the preview in the browser, then persist the rotation to the file on save.
- Restrict who can rotate images with the `rotate images` permission.
- Rotate images on any entity with an image field (nodes, media, users, terms…).
- Keep the original stored in a new `_r1`, `_r2`, … file after each rotation.
- Update image width/height/filesize automatically after rotating.
- Avoid re-rotating an already-rotated image (the angle resets to 0 after save — idempotent).
- Let content teams correct image orientation without touching the filesystem.
- Provide rotation on multi-value image fields (each image gets its own button).
- Rotate images uploaded through a custom content type's photo field.
- Turn rotation on only for the fields/roles that need it.
- Apply rotation using Drupal's configured image toolkit (GD, etc.).
- Reduce support requests about "my picture is sideways".
- Add lightweight image editing without a heavy media-library integration.
- Enable rotation per field via exported config (`third_party_settings.simple_image_rotate.enable_rotate`).
- Combine with image styles — rotation changes the source file, styles regenerate from it.
- Give a photographer role rotate access while keeping other editors out.
- Rotate a profile picture field's image on the user form.
