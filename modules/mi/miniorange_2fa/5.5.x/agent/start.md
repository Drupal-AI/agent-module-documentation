# miniOrange 2FA — agent index

Adds Two-/Multi-Factor Authentication to Drupal login with many second-factor methods. **Requires a
miniOrange (Xecurify) cloud account** — challenge/validate for OTP methods is delegated to their API
using a stored customer id + api key. Config object `miniorange_2fa.settings`; admin tabs under
`/admin/config/people/miniorange_2fa/*`. Provides permissions, config schema, a Drush command, and an
`authentication_type` plugin type. Depends on `web-auth/webauthn-lib`. Two submodules.

- **Admin settings: customer/account setup, 2FA policy, methods, IP/role/domain rules, recovery codes,
  passwordless, and the emergency backdoor URL** → [configure/settings.md](configure/settings.md)
- **Permissions and what each admin tab gates** → [permissions/permissions.md](permissions/permissions.md)
- **The login/2FA flow: route override, session guard, OTP validation, `invoke2faOrInlineRegistration`** →
  [api/login-flow.md](api/login-flow.md)
- **The `authentication_type` plugin type + the shipped method plugins** →
  [plugins/authentication-types.md](plugins/authentication-types.md)
- **Drush command (`miniorange_2fa:change-status`)** → [drush/commands.md](drush/commands.md)

Submodules (own docs):
- `miniorange_webauthn` → [../../modules/miniorange_webauthn/5.5.x/agent/start.md](../../modules/miniorange_webauthn/5.5.x/agent/start.md)
- `registration_verification` → [../../modules/registration_verification/5.5.x/agent/start.md](../../modules/registration_verification/5.5.x/agent/start.md)

Key facts:
- `configure` route `miniorange_2fa.customer_setup` = the Account & License / registration tab.
- Login override: `MoRouteSubscriber` points `user.login.http` at `MoTfaController::validateLoginRequest`;
  `hook_form_alter` prepends `miniorange_2fa_form_alter_submit` on the login forms → after password check,
  `MoAuthUtilities::invoke2faOrInlineRegistration()` redirects to `/login/user/{user}/authenticate`.
- Second factor completed in `MiniorangeAuthenticate` — session `mo_auth` must be
  `1ST_FACTOR_AUTHENTICATED` with matching uid; success calls `user_login_finalize()`. OTPs are checked
  against the miniOrange API and de-duplicated (`isOtpUsed`).
- Master toggle `mo_auth_enable_two_factor`. Method plugins: `google_authenticator`, `otp-over-email`,
  `otp-over-sms`, `otp-over-sms-and-email`, `otp-over-phone`, `push_notifications`, `qr_code`, `kba`,
  `hardware-token`, `grid_pattern`, `web-authn`, `email_verification`, `microsoft_authenticator`,
  `miniorange_authenticator`, `generic_authenticator`.
- Emergency **backdoor**: `/user/login?skip_2fa=<mo_auth_customer_api_key>` — OFF by default
  (`mo_auth_enable_backdoor`), only works for users with role `administrator`/`admin`. See configure doc.
- Basic-Auth 2FA gate via `TfaBasicAuthDecorator` when `mo_auth_2fa_for_apis` is on.
