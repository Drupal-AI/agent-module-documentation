# miniOrange Registration Verification — agent index

Submodule of **miniOrange 2FA** ([parent](../../../../5.5.x/agent/start.md)). Verifies new registrations
with an email/phone OTP before activating the account, using the parent's miniOrange cloud OTP service.
Provides a config schema; no permissions of its own. Requires a registered miniOrange account.

- **Settings, the registration→OTP→activation flow, and the verify endpoint** →
  [configure/verification.md](configure/verification.md)

Key facts:
- Config object `registration_verification.settings`: `enable` (bool, default off),
  `verification_method` (`email` | `phone` | `email_phone`), `phone_field`,
  `redirect_after_registration`. Settings form at
  `/admin/config/people/miniorange_2fa/registration-verification` (perm `administer site configuration`).
- `hook_form_user_register_form_alter` (skips `administer users` accounts) creates the account as
  **blocked** (`status = 0`), stores session data, sends OTP, redirects to `registration_verification.verify`
  (`/user/register/verify`, `_access: TRUE`, guarded by session).
- `OtpVerificationForm` validates the OTP via `OtpService::validateOtp` → parent
  `AuthenticationAPIHandler::validate` (cloud); on success `$user->activate()` + `user_login_finalize()`.
- Session TTL 30 min (`OtpService::SESSION_TIMEOUT`); expired/invalid session deletes the pending blocked
  account.
