<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Original image with style (original_image_style) — agent index

**Permanently applies a chosen image style to the originally uploaded file on presave, overwriting the source image in place.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** `image`
- **Configuration:** none global; per image field via third-party setting "Apply style to image after upload" on the field config edit form.
- **How it works:** `hook_form_field_config_edit_form_alter` adds the style select; `hook_entity_presave` runs `ImageStyle::createDerivative($uri, $uri)` on newly added files, re-saves the file, and refreshes width/height. Files already on the prior revision are skipped.
- **Security:** no routes, permissions or services; operates only on save via hooks — no request-facing surface. Note: the transform is **destructive** (original upload is overwritten in place).
