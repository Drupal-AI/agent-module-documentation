Registration Confirm Email Address adds a second "Confirm e-mail address" field to the user registration form and validates that it matches the e-mail field, preventing typos in the address a new account is created with.

---

The module is a tiny form-alter: it adds a checkbox **"Use two e-mail fields on registration form"** and a help-text field to the core account settings form (`user_admin_settings`, route `entity.user.admin_form` at `admin/config/people/accounts`), storing them as `mail_confirm` (bool, default `FALSE`) and `mail_desc` (string) in `reg_confirm_email.settings`. When `mail_confirm` is enabled, `hook_form_user_register_form_alter` inserts a required `#type => email` field named `conf_mail` immediately after the standard `mail` field (using a small array-insert helper to preserve weight/order), and attaches a validate handler that calls `$form_state->setErrorByName('conf_mail', …)` when `mail !== conf_mail`. That is the whole behavior: it re-implements LoginToboggan's email-confirmation feature as a standalone module. It does **not** touch account activation, approval, verification e-mails, tokens, or the login flow — it only enforces that the two typed addresses match before the register form submits. No permissions, no Drush, no plugins; a config schema exists for the two settings.

---

- Require users to type their e-mail address twice during self-registration to catch typos.
- Reduce failed activation e-mails caused by mistyped addresses.
- Add double-entry confirmation without installing the full LoginToboggan module.
- Provide custom help text under the confirm field (e.g. "Please re-type your e-mail to confirm it is accurate").
- Turn the confirm field on or off site-wide from the account settings page.
- Improve data quality of the user base by validating address entry at registration time.
- Keep the confirm field only on the public register form (it is not added to admin-create-user unless that form is the register form).
- Enforce an exact string match between the two e-mail fields before the account is created.
- Localize the confirm-field label/description via the standard translation UI.
- Ship a lightweight, dependency-free UX improvement for open-registration sites.
- Combine with core's "require e-mail verification" so the (now typo-checked) address gets a real activation mail.
- Pair with anti-spam modules while keeping registration friction minimal.
- Give community/membership sites a familiar "confirm your email" registration pattern.
- Prevent support tickets from users who never receive mail because of a wrong address.
- Configure the help text to match your site's tone/branding.
- Use on multilingual sites where the confirm prompt should be translated per language.
