<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twilio Otp Login (twilio_otp_login) — agent index

**Passwordless login/registration by mobile number + Twilio-delivered SMS one-time password.**

- **Version:** 2.1.x
- **Core:** ^9 || ^10
- **Configure:** `/admin/config/twilio_otp_login/settings` (`administer site configuration`)

**Routes:** `/login-otp` (OTPForm, `_access: TRUE`), `/login-otp/resend` (`access content`), `/register-otp`, `/register-otp/verify`, `/register-otp/resend` (all `_access: TRUE`), settings form. **Services:** `twilio_otp_login.otp` (`Otp`: `@database`,`@password`,tempstore), `twilio_otp_login.localStorage`, registration redirect subscriber.

**OTP storage:** login/registration/resend routes are public by design (they serve anonymous users); OTPs are hashed (Drupal password hasher) and expire.
