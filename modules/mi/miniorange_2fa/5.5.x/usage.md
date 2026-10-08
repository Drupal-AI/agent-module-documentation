miniOrange 2FA adds Two-Factor / Multi-Factor Authentication to Drupal logins, supporting many second-factor methods (authenticator apps/TOTP, OTP over email/SMS/phone, push, QR, KBA, hardware tokens, grid pattern, WebAuthn) with role-, domain- and IP-based policies, recovery codes, and passwordless login. Most method setup and OTP verification are delegated to the miniOrange (Xecurify) cloud service, which requires registering a customer account from within the module.

---

The module inserts a second-factor step into Drupal's login. It overrides the core `user.login.http` REST route (`MoTfaController`) and prepends a submit handler to the `user_login_form`/`user_login_block` (`miniorange_2fa_form_alter_submit` → `MoAuthUtilities::invoke2faOrInlineRegistration`): after the password is checked, the flow is redirected to `/login/user/{user}/authenticate` (`MiniorangeAuthenticate`) where the user completes the challenge; only on a `SUCCESS` validate response does it call `user_login_finalize()`. The 2FA login-flow routes use `_access: TRUE` but are guarded by `mo_auth` session state (uid + `1ST_FACTOR_AUTHENTICATED` status), and the submit handler verifies uid/URL consistency and rejects reused OTPs. Second-factor methods are `authentication_type` plugins (`src/Plugin/AuthenticationType/*`, e.g. `google_authenticator`, `otp-over-email`, `otp-over-sms`, `push_notifications`, `qr_code`, `kba`, `hardware-token`, `grid_pattern`, `web-authn`); challenge/validate calls are made to the miniOrange cloud API using the site's stored customer id + api key (`AuthenticationAPIHandler`), so a miniOrange account is required. Admin configuration lives under `/admin/config/people/miniorange_2fa/*` (config object `miniorange_2fa.settings`): Account/License setup (the `configure` route `miniorange_2fa.customer_setup`), a 2FA Policy page (enable, role/domain-based 2FA, allowed methods, trusted/whitelisted IPs, passwordless, recovery codes), user management (reset/enable/disable per user), headless/API 2FA, and advanced add-ons. An **emergency backdoor** URL (`/user/login?skip_2fa=<customer_api_key>`) can be enabled to bypass 2FA for admin-role users — it is **off by default** and admin-only (see the configure doc for the caveat). Basic-Auth API requests are 2FA-gated via a decorator when `mo_auth_2fa_for_apis` is on. A Drush command can enable/disable a user's 2FA (only when `mo_auth_2fa_drush` is enabled). Two submodules extend it: `miniorange_webauthn` (WebAuthn/passkeys) and `registration_verification` (OTP-verify new registrations). Most admin tabs are behind `restrict access: true` permissions.

---

- Require a second factor at Drupal login for all users.
- Let users authenticate with a TOTP authenticator app (Google/Microsoft/Authy/Duo/…).
- Send a one-time passcode over email as the second factor.
- Send an OTP over SMS or a phone call (cloud-metered).
- Use push notifications or QR-code scan via the miniOrange authenticator app.
- Use Knowledge-Based Authentication (security questions) as a factor or backup.
- Support hardware tokens (e.g. YubiKey / OTP tokens).
- Offer a grid-pattern challenge as a second factor.
- Add WebAuthn / passkey / security-key 2FA (via the `miniorange_webauthn` submodule).
- Enforce 2FA only for specific roles (role-based 2FA).
- Enforce 2FA only for users with specific email domains (domain-based 2FA).
- Skip or force 2FA based on trusted / whitelisted IP ranges.
- Let end users pick and configure their own 2FA method from an allowed list.
- Restrict which 2FA methods are available site-wide.
- Provide recovery codes for account recovery when a device is lost.
- Enable passwordless login (second factor only, no password).
- Require 2FA during the password-reset flow.
- Verify new user registrations with an email/phone OTP (via `registration_verification`).
- Gate Basic-Auth API/REST requests behind completed 2FA (`mo_auth_2fa_for_apis`).
- Provide a headless 2FA challenge/validate API for decoupled front-ends.
- Reset or disable a specific user's 2FA from the user-management tab.
- Enable/disable a user's 2FA from the CLI (when Drush control is turned on).
- Configure an emergency backdoor URL for admins locked out of 2FA (off by default).
- Allow login by email address or phone number instead of username.
- Apply OTP flood control and limit the number of OTP attempts.
- Rebrand the 2FA screens with a custom organization name/branding.
- Enforce a minimum password length policy alongside 2FA.
- Remember trusted devices (RBA) to reduce repeat prompts.
