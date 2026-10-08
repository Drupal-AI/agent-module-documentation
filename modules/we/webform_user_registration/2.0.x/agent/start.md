# Webform User Registration — agent index

Provides ONE Webform handler, `user_registration` (`UserRegistrationWebformHandler`), that creates a new
user account (anonymous submitter) or updates the current user's account (authenticated) from a webform
submission, via element→user-field mapping. No config UI of its own (`configure` null) — configured per
webform under *Settings › Emails/Handlers*. No permissions, no Drush. Depends on `user` + `webform:^6.2`.

- **The handler: settings keys, field mapping, create/update lifecycle, approval/verification/login,
  AJAX limitation, and the role-assignment access guard** → [configure/handler.md](configure/handler.md)

Key facts:
- Handler id `user_registration`, category "User", `cardinality = UNLIMITED`, `tokens = TRUE`.
- Config schema `webform.handler.user_registration` groups: `create_user`, `update_user`,
  `user_field_mapping`.
- Safe defaults: `create_user.enabled = FALSE`, `update_user.enabled = FALSE`,
  `admin_approval = TRUE`, `email_verification = TRUE`.
- Creation requires a webform element mapped to `mail` (validated).
- Roles checkboxes are `#access`-gated behind `administer permissions`; new accounts get a generated
  password and are `block()`ed (approval) or `activate()`d, then approval/verification mail is sent or
  `user_login_finalize()` logs them in.
- Does not support AJAX webform submissions (form shows a warning to disable AJAX / set a redirect).
