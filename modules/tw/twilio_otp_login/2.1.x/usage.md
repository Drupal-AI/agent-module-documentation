<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twilio Otp Login lets users authenticate (and register) with a mobile number and a one-time password delivered via Twilio SMS, instead of a password.

---

The `/login-otp` form (`_access: TRUE`) collects a phone number, the `Otp` service generates a numeric code, hashes it with Drupal's password hasher, stores it in the `twilio_otp_login` table with a short expiry, and sends it through the configured Twilio account. A registration flow (`/register-otp`, `/register-otp/verify`, `/register-otp/resend`) creates new accounts after phone verification, and resend endpoints reissue codes. Twilio SID/token, sender number and message text are configured at `/admin/config/twilio_otp_login/settings` (`administer site configuration`). A redirect event subscriber steers users through the OTP flow.

Setup: enable the module, add Twilio credentials on the settings form, expose the login/registration links, and map the phone field to users. The stored code is hashed and time-limited.

---
- Let users log in with a phone number and an SMS one-time code.
- Register new accounts via `/register-otp` after phone verification.
- Verify a registration code at `/register-otp/verify`.
- Resend a login code from `/login-otp/resend`.
- Resend a registration code from `/register-otp/resend`.
- Configure Twilio SID, token and sender number at the settings form.
- Customise the OTP SMS message text.
- Provide passwordless authentication for mobile-first audiences.
- Store OTPs hashed with a short expiry rather than in plaintext.
- Redirect users through the OTP flow via the event subscriber.
- Offer OTP login as an alternative to the standard password form.
- Reduce password-reset support by removing passwords from login.
- Map a mobile-number field to user accounts for lookups.
- Enforce a time window after which an unused OTP expires.
- Localise the login/registration form titles and messages.
- Test SMS delivery with the resend endpoints.
- Gate the admin settings behind `administer site configuration`.
