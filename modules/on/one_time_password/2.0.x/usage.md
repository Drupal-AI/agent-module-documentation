<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
One Time Password adds authenticator-app two-factor authentication (TOTP, RFC 6238) to Drupal: a user scans a QR code, then must enter a 6-digit time-based code during login. It integrates with the normal login form, one-time-login (password reset) links, and the REST login endpoint.

---

The module attaches a hidden `one_time_password` base field to the user entity that stores the account's TOTP secret as an `otpauth://` provisioning URI (generated and read through the `spomky-labs/otphp` library, with the Symfony Clock service supplying time). A user enables 2FA at `/user/{user}/two-factor-auth` (`PasswordSetupForm`, access gated by `user.update` entity access, so a user manages their own and admins with edit-any-user rights can manage others): clicking *Enable* calls `ProvisioningUriItemList::regenerateOneTimePassword()` (default 30-second SHA1 TOTP, for authenticator-app compatibility) and saves the user; the form then renders a QR code via `endroid/qr-code`, and a *Disable* button clears the field. During the standard login form, `hook_form_user_login_form_alter` (via `UserLoginEnforce`) adds a 6-digit *One Time Password* textfield and a `#validate` callback that runs after core has authenticated the password: if the account has a secret, it enforces per-user and per-IP flood control (`FLOOD_THRESHOLD` 5 attempts per `FLOOD_WINDOW` 3600s), rejects codes that overlap an already-accepted TOTP window (replay protection tracked in `user.data` key `one_time_password_totp_time_window`), and verifies the code with `TOTP::verify($code, NULL, $leeway=10)`; a wrong code registers a flood entry and blocks login. Password-reset one-time-login links are intercepted by `OneTimeLoginEventSubscriber` on the `user.reset.login` route: for a TFA user it validates the core `user_pass_rehash` hash, regenerates the session (session-fixation protection), stashes the uid in the `one_time_password` private tempstore, and redirects to `/otp/{uid}/{hash}` (`EntryForm`), whose `checkAccess` requires the tempstore uid plus a private-key-HMAC login hash before the same TOTP verification runs and `user_login_finalize` logs the user in. `RouteSubscriber` swaps the REST `user.login.http` controller for a subclass that additionally requires a valid `X-OTP` header. Optionally, `force_otp` (config `one_time_password.settings`, admin form at `/admin/config/people/one_time_password/settings`) makes `ForceOneTimePasswordSubscriber` redirect any authenticated user without 2FA to the setup form. The `one_time_password` field is force-forbidden from all entity field access so the secret is never exposed through the entity/REST API. Note: this branch has **no recovery/backup codes** — losing the authenticator means an admin must disable 2FA for the account. `hook_requirements` warns if other authentication providers are enabled that could bypass MFA.

---

- Add authenticator-app (TOTP) two-factor authentication to Drupal user accounts.
- Let a user self-enrol in 2FA by scanning a QR code at `/user/{uid}/two-factor-auth`.
- Prompt for a 6-digit time-based code on the standard username/password login form.
- Enforce 2FA on password-reset / one-time-login links so the reset link cannot bypass the second factor.
- Require a TOTP code (`X-OTP` header) on the REST `user/login` JSON endpoint.
- Force every authenticated user to set up 2FA site-wide via the `force_otp` setting.
- Rate-limit OTP guessing with per-user and per-IP flood control (5 attempts / hour).
- Prevent replay of a TOTP code within its accepted time window.
- Integrate with Google Authenticator, Authy, Duo Mobile, and other RFC 6238 apps.
- Generate a TOTP provisioning URI and QR code for enrolment from Drupal.
- Let an administrator (edit-any-user permission) disable 2FA for a locked-out account.
- Keep the TOTP secret out of REST/entity-API output (field access is always forbidden).
- Regenerate a fresh secret when a user re-enables 2FA after disabling it.
- Warn admins (via status report) when other auth providers could sidestep MFA.
- Protect the OTP entry step from session fixation by regenerating the session on the reset-link path.
- Provide a hidden per-user secret field without adding a configurable form/view display.
- Read a user's `OTPHP\TOTP` object in custom code via `$user->one_time_password->getOneTimePassword()`.
- Restrict who can change the module's force-OTP setting with a dedicated restricted-access permission.
- Comply with an organizational policy that mandates MFA for all logins.
- Offer near zero-configuration 2FA (one setting) as a lightweight alternative to the TFA module.
