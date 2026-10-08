<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image File Preview (image_file_preview) — agent index

**Adds a display-only Views field that renders an image thumbnail for File (`file_managed`) entities.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Dependencies:** none (Drupal core only)
- **Key API:** `hook_views_data_alter()` registers field `file_managed.image_file_preview` with Views field id `image_file_preview` (see `image_file_preview.module`).
- **Routes/permissions/services:** none.

**Security:** no routes, forms, permissions, or mutating endpoints; purely a read-only Views display field. No security findings.