<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Register with OTP bolts a 5-digit email OTP check onto Drupal's core user registration form so that anonymous users must prove control of their email address before an account is created.

---

The module swaps the user `register` form class for `Drupal\register_with_otp\Form\RegisterWithOtp` (via hook_entity_type_alter). For anonymous users it adds a "Verify email" AJAX button and a hidden OTP field. Clicking the button (sendOtp) generates an OTP with `random_int(10000, 90000)`, emails it via hook_mail using the themed `mail--otp-validate` template, and stores the OTP, a timestamp, the email, and an `otp_verified` flag in the PHP session. On submit, validateForm checks that the entered OTP matches the session OTP within a 300-second (5-minute) window; changing the email after verification forces re-verification, and registration is blocked until `otp_verified` is TRUE. Session OTP data is cleared on successful submit. A working mail system (SMTP or equivalent) is required, since the OTP is delivered only by email.

Because the OTP is bound to the email in the session and delivered to that address, a user cannot verify an address they do not control.
---
- Require email verification before any anonymous account is created.
- Reduce automated/bot registrations on an open-registration site.
- Send a one-time code to the entered email during sign-up.
- Enforce a 5-minute validity window on each OTP.
- Force re-verification when a user edits their email after verifying.
- Deliver OTP mail through the site's configured SMTP/mail system.
- Customize the OTP email markup via the `mail--otp-validate` template.
- Style the verification widget by overriding the `validator_styles` CSS library.
- Keep the flow AJAX-driven so users stay on the registration page.
- Block the final "Create account" button until the email is verified.
- Log OTP issuance events for the `register_with_otp` channel.
- Pair with core "Visitors can register" settings for gated self-service signup.
- Provide a free, dependency-light alternative to CAPTCHA for signup protection.
- Verify a user controls the mailbox before provisioning an account.
- Reset the verification state automatically after a successful registration.
- Show inline email-field errors during the verify step.
- Prevent registering with a mistyped/undeliverable email address.
- Add signup friction for spammers without third-party services.
- Audit registration attempts through the module's logger notices.
- Combine with role assignment so only verified users get authenticated roles.
