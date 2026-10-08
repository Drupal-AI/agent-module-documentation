# Secure Login — agent index

Forces configured forms to submit over HTTPS and makes authenticated sessions HTTPS-only.
Config UI at `/admin/config/people/securelogin` (route `securelogin.admin`, permission
`administer site configuration`). All persistent state is the `securelogin.settings` config
object. No permissions of its own, no Drush, no plugins.

- **Settings keys, config route, drush config, which forms are secured** →
  [configure/settings.md](configure/settings.md)
- **`securelogin.manager` service API + the `#https` / `$options['https']` flags** →
  [api/manager.md](api/manager.md)
- **`hook_securelogin_alter()` — add a module's forms to the secured-forms checklist** →
  [hooks/securelogin-alter.md](hooks/securelogin-alter.md)

Key facts:
- Config object `securelogin.settings`: `base_url` (nullable), `secure_forms` (bool),
  `all_forms` (bool), `forms` (sequence of form IDs), `other_forms` (sequence).
- Default secured `forms`: `user_login_form`, `user_form`, `user_register_form`,
  `user_pass_reset`, `user_pass`.
- A form is secured when its (base) form ID is in `forms`/`other_forms`, or `all_forms` is TRUE;
  the `form_alter` hook then sets `#https = TRUE` and calls `securelogin.manager::secureForm()`.
