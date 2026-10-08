<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auth0 — agent index

Auth0-hosted SSO for Drupal built on the official `auth0/auth0-php` v8 SDK + `externalauth` + `key`.
Overrides `/user/login` and `/user/logout`, adds `/auth0/callback`. Config UI at `admin/config/auth0`
(`configure` = `auth0.settings`), gated by `administer site configuration`. No permissions of its own,
no plugins, no Drush. PHP 8.3. This is `5.0.0-alpha1`.

- **Config keys, both settings forms, Key-module integration, role/claim mapping syntax** →
  [configure/settings.md](configure/settings.md)
- **Routes + the login/callback/logout flow and the services (Client/Auth/Provision/Config)** →
  [api/services.md](api/services.md)

Key facts:
- Routes (all `_access: TRUE`): `auth0.login` `/user/login`, `auth0.callback` `/auth0/callback`,
  `auth0.logout` `/user/logout`, `auth0.legacy_login` `/user/login/legacy`; `auth0.password_reset`
  `/auth0/password-reset` (`_user_is_logged_in: TRUE`).
- Callback security is delegated to the SDK: `ClientService::exchange()` → `$client->exchange()`
  validates `state` (CSRF), code exchange, and ID-token signature/`iss`/`aud`/`nonce`/exp; the module
  also verifies the token `sub` matches userinfo.
- Users mapped via `externalauth` provider `auth0` keyed by the Auth0 `sub`.
- Secrets: `getClientSecret()`/`getCookieSecret()` prefer a **Key** entity (`*_key` id), else a direct
  config value (logs a warning). `config/install` ships all values empty — no baked-in secret.
- Depends on `key` + `externalauth`; requires `auth0/auth0-php ^8.3`.
