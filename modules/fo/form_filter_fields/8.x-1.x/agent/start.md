<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Filter Fields (form_filter_fields) — agent index

**Dependent/cascading select fields on node & media forms via hook_form_alter().**

- **Version:** 8.x-1.x  | **Core:** ^8.7.7 || ^9 || ^10  | **Package:** Fields
- **Configure:** `/admin/config/content/form_filter_fields` (route `form_filter_fields.settings`, perm `administer site configuration`); delete route same perm.
- **Mechanism:** `hook_form_alter()` matches `node_*_form`/`media_*_form`, filters the target field's options by the control field value. Config in `form_filter_fields.settings`.

**Security:** admin-only config. Filtering is a form-display convenience (client/option-set level), not a server-side authorization control — do not rely on it to reject out-of-range submitted values. Nothing else notable.
