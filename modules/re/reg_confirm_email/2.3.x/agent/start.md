# Registration Confirm Email Address — agent index

Adds a required **"Confirm e-mail address"** field to the user registration form and validates
it matches the e-mail field (typo prevention). Two config values, toggled from the core account
settings page. No permissions, no Drush, no plugins, no submodules. Does **not** affect account
activation, approval, verification mails or tokens.

- **The two settings, where they live, the form-alter/validation behavior, and how to enable it** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Enabled via checkbox on `admin/config/people/accounts` (route `entity.user.admin_form`,
  form id `user_admin_settings`).
- Config `reg_confirm_email.settings`: `mail_confirm` (bool, default `FALSE`), `mail_desc` (string).
- When on, `hook_form_user_register_form_alter` inserts a required `email` element `conf_mail`
  after `mail`; validate handler errors if `mail !== conf_mail`.
- Implementation is entirely in `reg_confirm_email.module` (procedural form alters).
