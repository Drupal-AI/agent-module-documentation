<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Two-factor Authentication (tfa) — agent index

Pluggable base module that forces a **second authentication factor** after Drupal's
username/password login. It overrides the core login/password-reset routes, redirects TFA users
to a code-entry form, and finalizes the login only after a validation plugin accepts a code (or a
login plugin allows a skip). Package **Security**. Version **1.13.x**, core `^10 || ^11`, PHP
`>=8.1`, license GPL-2.0-or-later.

- **Dependencies:** `encrypt` (module) at runtime; Composer libs `christian-riesen/otp` (OTP
  math), `chillerlan/php-qrcode` (setup QR), `paragonie/constant_time_encoding` (base32).
  `encrypt` in turn needs `key`. Requires PHP OpenSSL (Mcrypt is a legacy fallback).
- **Ships submodule** `services_tfa` (deprecated) — documented separately under
  `modules/tf/tfa/modules/services_tfa/1.13.x/`.

## What it provides

- **Four plugin types** (managers in `src/`): `TfaValidation` (`Plugin/TfaValidation`),
  `TfaSetup` (`Plugin/TfaSetup`), `TfaLogin` (`Plugin/TfaLogin`), `TfaSend` (`Plugin/TfaSend`).
  Built-in plugins: `tfa_totp`, `tfa_hotp`, `tfa_recovery_code` (validation), matching `*_setup`
  plugins, and `tfa_trusted_browser` (login). → [plugins/plugin-types.md](plugins/plugin-types.md)
- **Config** object `tfa.settings` (install defaults + schema) edited at `/admin/config/people/tfa`
  by `SettingsForm`. → [configure/settings.md](configure/settings.md)
- **Routes** for the login flow and per-user setup, all custom-access-controlled. →
  [api/flow-and-routes.md](api/flow-and-routes.md)
- **Permissions** (`tfa.permissions.yml`): `admin tfa settings`, `setup own tfa`,
  `disable own tfa`, `administer tfa for other users`. → [permissions/permissions.md](permissions/permissions.md)
- **Services/API:** four plugin managers, `logger.channel.tfa`, a route subscriber, key traits
  (`TfaLoginContextTrait`, `TfaLoginTrait`, `TfaUserDataTrait`, `TfaRandomTrait`). →
  [api/flow-and-routes.md](api/flow-and-routes.md)
- **Drush:** `tfa:reset-user` + a `sql-sanitize` hook. → [api/flow-and-routes.md](api/flow-and-routes.md#drush)
- **Also:** block `tfa_user_login_block` (replaces core login block via `hook_block_access`),
  Views field `tfa_enabled_field`, `hook_mail` for enable/disable notifications, and a user-op link.

## Fast facts (from source)

- Login override lives in `TfaRouteSubscriber` (runs at `PHP_INT_MIN` priority): `user.login` →
  `TfaLoginForm`, `user.login.http` → `TfaUserAuthenticationController::login`, `user.reset.login`
  → `TfaUserController::resetPassLogin`. `tfa_requirements()` warns if these were re-overridden.
- OTP seeds and recovery codes are stored in `users_data` (keys prefixed `tfa_`) **encrypted**
  through the Encrypt profile named in `tfa.settings.encryption`; accepted codes are hashed and
  recorded to prevent replay (`TfaBasePlugin::storeAcceptedCode`/`alreadyAcceptedCode`).
- Second-factor entry is gated by a per-session `tfa-entry-uid` tempstore value (5-minute expiry)
  plus an HMAC login-hash of the account state; flood control throttles failed codes.
