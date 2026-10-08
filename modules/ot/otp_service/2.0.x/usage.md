<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OTP Service provides an OTP-token setup form and a validation service for gating access.

---

OTP Service provides a form to set up a one-time-password (OTP) token and a service to validate access using it — a building block for adding OTP-based verification/2FA-style gating to flows, where users enter an OTP to proceed. Other code uses the validation service.

The validation form `/otp/validation` is gated by `use otp_service form` (not anonymous), and settings by `administer otp_service` — so OTP validation is not an open brute-force surface. Supports Drupal 10.3+ and 11.

---

- Set up an OTP token via a form.
- Validate access with an OTP.
- Provide a validation service.
- Support OTP-based gating.
- Add 2FA-style verification.
- Let code reuse validation.
- Gate the form with `use otp_service form`.
- Gate settings with `administer otp_service`.
- Not expose an open brute-force surface.
- Support Drupal 10.3+ and 11.
- Verify OTPs.
- Gate flows with OTP.
- Provide OTP building blocks
- Configure the token
- Enter OTP to proceed.
- Support access control.
- Validate tokens.
- Secure flows
