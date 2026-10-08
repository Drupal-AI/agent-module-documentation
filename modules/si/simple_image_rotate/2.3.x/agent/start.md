<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Image Rotate — agent index

Adds a **"Rotate image clockwise"** button to core **image** field widgets; the rotation is
applied to the real file on entity save. Depends on core `image`. **No settings page**
(`configure: null`), no config object — only a per-field third-party setting and one permission.

- **Enable rotation on an image field (the third-party setting) + the permission** →
  [configure/enable-rotate.md](configure/enable-rotate.md)
- **How rotation actually works (JS preview + `hook_entity_presave` file rewrite)** →
  [api/mechanism.md](api/mechanism.md)
- **Permission `rotate images`** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Enabled per field via the third-party setting
  **`third_party_settings.simple_image_rotate.enable_rotate: true`** on the image field's
  `FieldConfig` (`field.field.<entity>.<bundle>.<field>`). Set from the field's edit form
  ("Enable rotate function" checkbox).
- The rotate button only shows when the field has `enable_rotate` **and** the user has the
  **`rotate images`** permission.
- On save, `hook_entity_presave()` rotates the file, writes it to an `_r<n>`-suffixed name, and
  resets the angle to 0 (idempotent).
