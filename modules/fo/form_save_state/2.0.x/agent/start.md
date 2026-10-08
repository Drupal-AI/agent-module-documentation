<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Save State (form_save_state) — agent index

**Client-side autosave of selected forms to browser localStorage.**

- **Version:** 2.0.x  | **Core:** ^8 || ^9 || ^10  | **Package:** Other
- **Configure:** `admin/config/user-interface/form-save-state` (route `form_save_state.admin`, perm `administer site configuration`).
- **Mechanism:** `hook_form_alter()` attaches the `form_save_state/save` JS library for form IDs listed in `form_save_state.settings`; JS reads/writes `localStorage`.

**Security/privacy note:** all saved values are stored in the visitor's browser localStorage (never server-side). On shared computers, cached input persists in that browser profile — do not enable for forms carrying sensitive data (passwords, PII). No server-side exposure.
