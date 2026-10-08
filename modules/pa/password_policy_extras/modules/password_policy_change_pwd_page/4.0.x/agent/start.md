# Password Policy Extras for Password Separate Form — agent index

Glue submodule: attaches Password Policy's live status table to the `change_pwd_form` provided by the
**Password Separate Form** (`change_pwd_page`) module. No config, permissions, services, or routes.
Depends on `password_policy_extras` + `change_pwd_page`.

How it works (`password_policy_change_pwd_page.module`):
- `hook_form_change_pwd_form_alter()` — when the `user` route param is set and
  `password_policy.validation_manager->tableShouldBeVisible()` is true, calls the parent helper
  `_password_policy_extras_add_libraries_and_settings_to_form($form)` to attach the AJAX status-table
  libraries + `drupalSettings`.
- `hook_module_implements_alter()` reorders `form_alter` / `form_change_pwd_form_alter` to run after
  Password Policy.
- `hook_install()` sets module weight to 30 (loads after `password_policy_extras`=20 and PRLP).

See the parent's [configure/settings.md](../../../../4.0.x/agent/configure/settings.md) and
[api/events.md](../../../../4.0.x/agent/api/events.md) for the settings and helper it reuses.
