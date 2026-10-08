<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Eye adds a small show/hide "eye" icon next to password fields on chosen forms, letting users reveal what they typed by toggling the input between password and text.

---

The module is a tiny JavaScript enhancement driven by one config value. `hook_form_alter()` reads `password_eye.settings` → `password_eye.form_id_password` (a comma-separated list of form ids, defaulting to `user_login_form` set at install), and for any form whose id is in that list it adds the CSS class `pwd-see` and attaches the `password_eye/pwd_eye_lib` library (jQuery + a small CSS/JS pair). The JS (`Drupal.behaviors.pwd`) inserts a clickable `span.shwpd` after each `:password` input inside a `.pwd-see` form and toggles the input's `type` between `password` and `text` (swapping `eye-open`/`eye-close` classes for the icon). A settings form at `/admin/config/system/pssword_eye-settings` (route `password_eye.route`, menu "Password Eye Settings" under System) lets an admin edit the list of form ids; clearing it disables the feature. There is no permission of its own and no config schema — just the one settings value.

---

- Add a show-password eye icon to the user login form (default, out of the box).
- Enable the eye icon on the user registration form so people can verify their chosen password.
- Add the toggle to a custom login/registration form by adding its form id to the config.
- Let users reveal passwords on a "change password" form to catch typos.
- Enable the eye on multiple forms at once (comma-separated form ids).
- Disable the feature on the login form by removing `user_login_form` from the list.
- Improve UX on mobile where mistyped hidden passwords are common.
- Reduce failed logins caused by hidden-password typos.
- Add password visibility to a webform that collects a password.
- Provide a reveal toggle on an account-settings password field.
- Turn the feature on for a specific admin-only form.
- Standardize password reveal behavior across several site forms.
- Improve accessibility of password entry by allowing users to see input.
- Add the toggle to a commerce/checkout password field form.
- Provide a familiar "eye" affordance matching modern login UIs.
- Scope the eye icon to just the forms you list (no global change to every form).
- Style the eye icon via the module's CSS classes (`shwpd`, `eye-open`, `eye-close`).
- Deploy the target-form-id list as configuration across environments.
- Help support/helpdesk staff verify passwords during guided setup.
- Toggle password visibility without any custom JavaScript of your own.
