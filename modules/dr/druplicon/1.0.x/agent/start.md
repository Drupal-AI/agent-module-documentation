<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Druplicon (druplicon) — agent index
**Swaps the Admin Toolbar Druplicon logo for an administrator-uploaded image.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 — depends on `admin_toolbar`.
- **Route:** `druplicon.settings` → `/admin/config/druplicon/settings` (`administer site configuration`).
- **Config:** `druplicon.settings:druplicon_fid` (managed file id).
- **Behavior:** `druplicon_preprocess_menu()` injects the image into the `admin` menu via `drupalSettings` + library `druplicon/druplicon`.
- **Security:** single admin-gated form. Note upload validators permit `svg` (`SettingsForm.php`), so an admin could upload a scriptable SVG served from `public://`; gated by `administer site configuration` (trusted). Otherwise no findings.
