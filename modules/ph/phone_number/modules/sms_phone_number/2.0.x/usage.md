<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS Phone Number extends the Phone Number module with SMS verification and two-factor authentication: an `sms_phone_number` field type that can require a phone number to be verified by a texted code, plus a TFA plugin that uses it.

---

The submodule defines an `sms_phone_number` field type (subclass of `phone_number`'s
`PhoneNumberItem`) that adds two field settings — `verify` (`none` / `optional` / `required`)
and a `message` template — and tracks a **verified** status. Its widget
(`sms_phone_number_default`) can send a verification code by SMS and require the user to enter it;
formatters mirror Phone Number's plus a `sms_phone_number_verified` formatter. Sending is done via
a pluggable **SMS callback** (defaults to SMS Framework's `sms_send` when installed) that other
modules can override with `hook_sms_phone_number_send_sms_callback_alter()`. All verification
logic lives in the `sms_phone_number.util` service (`SmsPhoneNumberUtilInterface`) —
`generateVerificationCode()`, `sendVerification()`, `verifyCode()`, `isVerified()`, flood control,
etc. A REST resource (`request_verification_code`, `/sms-phone-number/request-code/{number}`)
lets a client request a code, and a TFA validation/sending plugin (`SmsPhoneNumberTfa`) plugs the
field into the `tfa` module for SMS-based two-factor login. Global config lives in
`sms_phone_number.settings` (`tfa_field` — which user phone field to use for TFA — and
`verification_secret`). A permission `bypass phone number verification requirement` lets trusted
roles save unverified numbers. There is no admin settings page (`configure: null`); everything is
per-field plus that config object. Actual SMS delivery requires an external gateway (e.g. SMS
Framework), so on a site without one, verification is configured but codes cannot be sent.

---

- Require a user's phone number to be SMS-verified before it can be saved (`verify: required`).
- Offer optional phone verification (`verify: optional`).
- Add SMS-based two-factor authentication via the TFA module and the SmsPhoneNumberTfa plugin.
- Choose which user phone field is used for TFA (`sms_phone_number.settings:tfa_field`).
- Send a verification code by SMS using SMS Framework's `sms_send` by default.
- Override how texts are sent with `hook_sms_phone_number_send_sms_callback_alter()`.
- Customise the verification SMS message template per field (`message`).
- Show whether a stored number is verified using the `sms_phone_number_verified` formatter.
- Let trusted roles bypass the verification requirement (`bypass phone number verification requirement`).
- Request a verification code from a decoupled front-end via the REST resource.
- Rate-limit verification attempts and SMS sends with the built-in flood control.
- Store a verification secret used to hash/validate codes (`verification_secret`).
- Verify a code programmatically with `sms_phone_number.util::verifyCode()`.
- Check if a number is verified in code with `isVerified()`.
- Generate a verification code with `generateVerificationCode()`.
- Collect verified mobile numbers for SMS marketing consent flows.
- Gate account actions behind a verified phone number.
- Add a "verified phone" trust signal to user profiles.
- Integrate phone verification into a custom registration flow.
- Reuse Phone Number's country/validation features while adding verification.
- Switch an existing phone field to sms_phone_number to add verification.
