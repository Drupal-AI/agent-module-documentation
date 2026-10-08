<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authenticator Login (alogin) — agent index

TOTP **two-factor authentication** for Drupal login, backed by the `pragmarx/google2fa-qrcode`
PHP library. Package `Security`. Core `^9.5 || ^10 || ^11`. License GPL-2.0-or-later.
Version dir `2.1.x` (installed 2.1.8). No Drupal module dependencies; composer requires
`pragmarx/google2fa-qrcode:^3.0` and `bacon/bacon-qr-code:^2.0`.

## Solution docs

- **Service, login/enrol flow, forms, routes, the REST override, Drush** →
  [api/authenticator-service.md](api/authenticator-service.md)
- **Site configuration (`alogin.config`), permissions, enforced-redirect subscriber** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Service** `alogin.authenticator` = `Drupal\alogin\AuthenticatorService`
  (args `@config.factory`, `@tempstore.private`, `@current_user`, `@database`). Wraps
  `PragmaRX\Google2FAQRCode\Google2FA`: `generateSecretKey(64)`, `getQr()`, `check()`/`verifyCode()`
  (`verifyKey`), plus CRUD on the `alogin_user_settings` table (`store`/`new`/`update`/`exists`/
  `isEnabled`/`getSecret`).
- **Table** `alogin_user_settings` (`alogin.install`): `uid` (PK), `secret` (varchar_ascii 255),
  `enabled` (int).
- **Forms** — `SettingsForm` (per-user enrol, `/user/{user}/2fa`), `TwoFaForm` (login-time code
  entry, `/2fa`), `ConfigForm` (admin, `/admin/config/alogin/config`, config `alogin.config`).
- **Controllers** — `AuthenticatorController::access()` (custom access for the settings route),
  `MfaLoginController` extends core `UserAuthenticationController` and overrides the
  `user.login.http` JSON login route (wired by `Routing\AloginRouteSubscriber`).
- **Event subscribers** — `AloginRouteSubscriber` (route alter), `MfaRedirectSubscriber`
  (`KernelEvents::REQUEST`, force-redirect un-enrolled users to setup when configured).
- **Hooks** — `alogin_form_alter()` converts `user_login_form` submit into the AJAX callback
  `alogin_ajax_callback()`; `alogin_help()`.
- **Permissions** — `administer alogin`, `alogin bypass enforced redirect`.
- **Drush** — `mfa-reset {uid}` (alias `mfar`) = `Commands\MfaReset`, deletes a user's row.
- **Config** — object `alogin.config` (`allow_enable_disable`, `redirect`, `message_type`,
  `redirect_message`); install defaults in `config/install/`. No `config/schema/`.

## Routes

| Route | Path | Access |
|---|---|---|
| `alogin.settings` | `/user/{user}/2fa` | `_custom_access` = `AuthenticatorController::access` |
| `alogin.two_fa_form` | `/2fa` | `_access: 'TRUE'` (user mid-login, not yet authenticated) |
| `alogin.config` | `/admin/config/alogin/config` | `_permission: 'administer alogin'` |

Login flow, in one line: password validated on `user_login_form` → AJAX callback stores uid in the
`alogin` private tempstore → if `isEnabled(uid)` redirect to `/2fa`, else `user_login_finalize()`
immediately; `/2fa` verifies the code then finalises and clears the tempstore.
