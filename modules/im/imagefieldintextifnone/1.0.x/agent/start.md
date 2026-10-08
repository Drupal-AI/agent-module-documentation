<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Field in Text if None (imagefieldintextifnone) — agent index
**Inserts an image field's image into a long-text field at display time when the text has no image.**

- **Version:** 1.0.0-alpha1 → dir `1.0.x`
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** field, filter, image, text
- **Mechanism:** `hook_entity_view()` — scans processed body for `<img>`, else splices rendered image field markup at a computed paragraph position; can remove the original image display.
- Mapping is currently hard-coded (`node`/`article`, `field_image`→`body`, `full`); settings UI is a `@TODO`. No routes/permissions/services.

**Security:** display-only alteration of the entity's own field content; text still passes through the `processed_text` format pipeline; no routes, permissions, or request-input handling.
