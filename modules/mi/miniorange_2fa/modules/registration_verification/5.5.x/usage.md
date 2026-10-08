Submodule of miniOrange 2FA that verifies new user registrations with a one-time passcode over email and/or phone before the account is activated, using the parent module's miniOrange cloud OTP service.

---

`registration_verification` alters the user registration form (for non-`administer users` visitors) to require OTP verification. When enabled, it optionally adds/requires a phone field (with a country-flag dropdown), and on submit it creates the account as **blocked** (`status = 0`), stores registration data in the session, sends an OTP via the parent module's cloud API (`OtpService::sendOtp` → `AuthenticationAPIHandler::challenge`), and redirects to `/user/register/verify` (`OtpVerificationForm`). That form validates the entered OTP against the cloud (`validateOtp`), and only on success activates the account (`$user->activate()`) and logs the user in. The verification session expires after 30 minutes; on an expired/invalid session the half-created blocked account is deleted. A settings form (`registration_verification.settings`, `/admin/config/people/miniorange_2fa/registration-verification`, permission `administer site configuration`) selects the verification method (`email`, `phone`, `email_phone`), the phone field, and a post-registration redirect. Config default is disabled. There are no permissions of its own; OTP generation/validation is delegated to the miniOrange cloud, so a registered miniOrange account is required.

---

- Require email OTP verification before a new account is activated.
- Require phone/SMS OTP verification at registration.
- Require both email and phone verification (`email_phone`).
- Collect and validate a phone number (with country code) during sign-up.
- Prevent activation of unverified self-registered accounts (created blocked until verified).
- Auto-delete abandoned/unverified registrations when the 30-minute session expires.
- Let users resend the OTP from the verification screen.
- Redirect users to a configured URL after successful verification.
- Reduce spam/bot sign-ups by gating registration behind an OTP challenge.
- Reuse the parent module's miniOrange cloud OTP delivery (email/SMS).
- Exempt admins (`administer users`) from the OTP step when creating accounts.
- Add a country-flag phone dropdown to the registration form.
- Validate phone numbers against an `+<digits>` format before sending an OTP.
- Verify contact details are real at the point of registration.
- Keep the verification flow bound to a session so codes can't be reused across users.
