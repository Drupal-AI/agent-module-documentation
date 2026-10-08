# Login Disable — agent index

Temporarily disable user login except for roles holding `bypass disabled login`; optionally require a
secret access key on the login URL and force-logout existing sessions. Depends on core `user`. Config at
`/admin/config/people/login-disable` (permission `administer permissions`). Provides one permission and a
config schema; no Drush. Requires Drupal `^11.3 || ^12`.

- **Settings, the enforcement flow (form alter, hook_user_login, REST access check), key, force
  logout, the permission** → [configure/settings.md](configure/settings.md)

Note: `config/install` ships the access key defaulted to `admin` — change it before activation.

Key facts:
- Config `login_disable.settings`: `login_disable_is_active` (bool, default false),
  `login_disable_key` (string, default `admin`), `login_disable_message`, `login_disable_force_logout`.
- Real enforcement is `hook_user_login` (`LoginDisableHooks::userLogin`): on successful auth, if the user
  lacks `bypass disabled login`, `$requestStack->getCurrentRequest()->getSession()->clear()` logs them
  straight back out. uid 1 bypasses (holds all permissions).
- Form gate (`_login_disable_form_user_login_alter`) disables the login form fields and unsets
  `#validate`/`#submit`/`actions` unless the key is a `$_GET` argument; skipped entirely when the key is
  empty. UI-level obscurity only.
- Permission `bypass disabled login` is `restrict access: TRUE`.
- `LoginDisableAccessCheck` (`_login_disable_access`) is attached to route `user.login.http` (REST login)
  by `LoginDisableRouteSubscriber`; denies REST login when active and a key is set unless the key is in
  the query.
- Hooks are implemented as an OOP `#[Hook]` class (`src/Hook/LoginDisableHooks.php`), registered as a
  service, with thin `#[LegacyHook]` procedural wrappers in `login_disable.module`.
