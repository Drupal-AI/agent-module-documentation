<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Widget Layout (fwl) — agent index

**Per-field width / max-width settings on form-display widgets for multi-column edit forms.**

- **Version:** 1.0.x  | **Core:** ^8 || ^9 || ^10
- **Configure:** `/admin/config/fwl` (route `fwl.settings_form`, perm `administer site configuration`).
- **Mechanism:** `hook_field_widget_third_party_settings_form()` adds Width% and Max-width px to each widget under *Manage form display*; a CSS/JS library applies them. Stored as third-party settings on form display config.
- **Surface:** no entities/permissions.

**Security:** admin-only; presentational form-layout helper. Nothing notable.
