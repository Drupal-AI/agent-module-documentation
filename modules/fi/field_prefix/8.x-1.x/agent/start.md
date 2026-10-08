<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Prefix — agent orientation

D8/9/10 module altering the `field_` prefix Field UI uses for new field machine names.

- Config form: `admin/config/field_prefix/setting` (`src/Form/SettingForm.php`), permission `access administration pages` (an admin route).
- Alters Field UI's add-field form via `field_prefix.module`. Affects only newly created fields.
- No content routes, no mutation endpoints, no anon access. Minimal security surface (admin-gated config).
