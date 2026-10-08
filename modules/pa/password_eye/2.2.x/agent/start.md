<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Eye — agent index

Adds a show/hide "eye" icon to password fields on forms you list. Pure JS + one config
value. No permission of its own, no config schema, no Drush, no plugins.

- **The settings form, config key, targeting forms, the library & CSS classes** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config: `password_eye.settings` → `password_eye.form_id_password` = comma-separated list of
  **form ids** to enhance. Default (set at install): `user_login_form`.
- `hook_form_alter()` adds class `pwd-see` and attaches library `password_eye/pwd_eye_lib`
  only to forms whose id is in that list.
- Settings route `password_eye.route` → `/admin/config/system/pssword_eye-settings` (note the
  misspelled path segment `pssword_eye-settings`). Access: `_permission: 'access content'`
  **and** `_role: 'administrator'`.
- JS `Drupal.behaviors.pwd` toggles each `:password` input's `type` between `password`/`text`
  via a `span.shwpd` (`eye-open`/`eye-close` classes). Library depends on `core/jquery`.
- No config schema ships; the one setting is created in `hook_install`.
