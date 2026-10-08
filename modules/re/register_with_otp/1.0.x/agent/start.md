<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Register with OTP (register_with_otp) — agent index

**Adds a 5-digit email OTP verification step to the core anonymous user-registration form.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Mechanism:** hook_entity_type_alter swaps the user `register` form for `Drupal\register_with_otp\Form\RegisterWithOtp`.
- **Flow:** AJAX "Verify email" → sendOtp() emails a `random_int(10000,90000)` code (hook_mail, template `mail--otp-validate`) → OTP/time/email/`otp_verified` kept in session → validateForm enforces a 300s window and blocks registration until verified.
- **Requires:** a configured mail system (SMTP). No routes, no permissions, no config entity of its own.

**Verification:** the OTP is bound to the entered email and delivered to it; it is generated with `random_int` (`src/Form/RegisterWithOtp.php` sendOtp/validateForm).

See [configure/otp-flow.md](configure/otp-flow.md)
