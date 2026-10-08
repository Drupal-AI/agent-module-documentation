<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticator Login (alogin) adds TOTP two-factor authentication — the six-digit code from an authenticator app such as Google Authenticator, Microsoft Authenticator or Authy — as a second step in the Drupal login flow.

---

The module ships one service, three forms, a controller, two event subscribers, a Drush command and its own database table. Enrolment is per user at `/user/{user}/2fa` (`SettingsForm`), where the `alogin.authenticator` service (`AuthenticatorService`, backed by the `pragmarx/google2fa-qrcode` library) generates a secret and renders a QR code; the user scans it and confirms one code to store the secret in the `alogin_user_settings` table. At login, `alogin_form_alter()` turns the core `user_login_form` submit into an AJAX callback (`alogin_ajax_callback`): after the password is validated it stashes the uid in the private tempstore and, if the account has 2FA enabled, redirects to the `/2fa` verification form (`TwoFaForm`) instead of finalising the session; only a valid code then calls `user_login_finalize()`. A REST/JSON login controller (`MfaLoginController`) overrides core's `user.login.http` route to require an `mfa_token` field for accounts that have 2FA. Site behaviour is configured at `/admin/config/alogin/config` (`ConfigForm`, config object `alogin.config`): admins choose whether users may toggle their own 2FA (`allow_enable_disable`), whether un-enrolled users are force-redirected to set it up after login (`redirect`, driven by `MfaRedirectSubscriber`), and the redirect message and its type. Two permissions gate the module: `administer alogin` (the config form) and `alogin bypass enforced redirect` (exempt an account from enforced enrolment). The `drush mfa-reset {uid}` command (alias `mfar`, `MfaReset`) deletes a user's row so their 2FA is cleared.

The `/2fa` route is deliberately `_access: 'TRUE'` because the user is mid-login and not yet authenticated when the verification form is shown; the per-user settings route is guarded by `AuthenticatorController::access()`, which allows only the account whose id matches the `{user}` route parameter (or a user with the config-form permission via the admin route). Verification uses `Google2FA::verifyKey()` against the stored secret; the QR label is the site name (issuer) plus the account display name.

---

- Add TOTP two-factor authentication to a Drupal site.
- Let users enrol an account by scanning a QR code at `/user/{user}/2fa`.
- Require the six-digit authenticator code as a second step after the password.
- Make 2FA mandatory for everyone by leaving `allow_enable_disable` off.
- Let users opt in and out of their own 2FA by enabling `allow_enable_disable`.
- Force un-enrolled users to the setup form after login with the `redirect` option.
- Customise the enforced-enrolment message text and its status/warning/error type.
- Exempt selected roles from enforced enrolment via `alogin bypass enforced redirect`.
- Support Google Authenticator, Microsoft Authenticator and Authy (standard TOTP).
- Add an `mfa_token` field to a JSON `POST /user/login` for API clients with 2FA.
- Reset a locked-out user's 2FA from the CLI with `drush mfa-reset 1`.
- Clear a user's authenticator secret when they lose their device.
- Store each user's secret and enabled flag in the `alogin_user_settings` table.
- Restrict who can reach the module's configuration with `administer alogin`.
- Add the config form to the admin menu under Configuration → System.
- Add an "Enable 2FA" local task tab on the user profile.
- Show the 2FA QR code inline as an SVG/PNG data image on the settings form.
- Verify a code before saving it so enrolment can't complete with a wrong secret.
- Use as a lightweight alternative to the larger TFA module for authenticator-app 2FA.
- Pair with core flood control and login protections for defence in depth.
- Roll 2FA out gradually by turning enforcement on only for specific roles.
