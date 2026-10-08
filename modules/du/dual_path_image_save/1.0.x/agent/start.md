<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dual Path Image Save (dual_path_image_save) — agent index
**On node presave, copies configured image-field files to an admin-set custom path in addition to their normal location.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 — depends on `image`, `views`, `field`.
- **Route:** `dual_path_image_save.admin_settings` → `/admin/config/media/dual-path-image-save` (`administer site configuration`).
- **Config:** `dual_path_image_save.settings:fields` (field names) + per-field third-party setting `dual_path_image_save.path`.
- **Hook:** `dual_path_image_save_entity_presave()` copies via `file_system->copy(..., EXISTS_REPLACE)` using `basename()` for the filename.
- **Views:** field plugin `DualPathImage`.
- **Security:** destination path and field list are admin config (not request input); filename passed through `basename()` (no traversal). No security findings.
