# Login Disable — agent index

Temporarily disable user login except for roles holding `bypass disabled login`; optionally require a
secret access key on the login URL and force-logout existing sessions. Depends on core `user`. Config at
`/admin/config/people/login-disable` (permission `administer permissions`). Provides one permission and a
config schema; no Drush.

- **Settings, the enforcement flow (form alter, hook_user_login, REST access check), key, flood, force
  logout, the permission** → [configure/settings.md](configure/settings.md)

Key facts:
- Config `login_disable.settings`: `login_disable_is_active` (bool, default false),
  `login_disable_key` (string, default `admin`), `login_disable_message`, `login_disable_force_logout`.
- Real enforcement is `hook_user_login`: on successful auth, if the user lacks `bypass disabled login`,
  `\Drupal::request()->getSession()->clear()` logs them straight back out.
- Form gate (`_login_disable_form_user_login_alter`) disables the login form fields unless the key is a
  `$_GET` argument; skipped entirely when the key is empty.
- Permission `bypass disabled login` is `restrict access: TRUE`.
- `LoginDisableAccessCheck` (`_login_disable_access`) is attached to route `user.login.http` (REST login).
