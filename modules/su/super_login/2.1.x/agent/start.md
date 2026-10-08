# Super Login — agent index

Improves core's login / registration / password-reset forms via `hook_form_alter()`. All
behaviour is driven by one config object **`super_login.settings`** (values nested under a
`super_login.*` path). Config UI: route `super_login.settings` →
`/admin/config/people/super_login/settings` (permission: core *administer site configuration*).
No own permission, no Drush, no plugins.

- **All settings keys, the config path, Login Type, drush cget/cset** →
  [configure/settings.md](configure/settings.md)
- **What it changes on each form, the email→username login mechanism, caps lock, tabs** →
  [api/login-behavior.md](api/login-behavior.md)

Key fact: config is `super_login.settings` with everything under a nested `super_login` key,
so a value is read as `super_login.settings` → `super_login.<key>` (e.g.
`drush cget super_login.settings super_login.login_type`). **Login Type**: `0` username or
email, `1` username only, `2` email only.
