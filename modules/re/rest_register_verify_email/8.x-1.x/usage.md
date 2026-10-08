<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Register User with Email Verification adds REST endpoints to register a user (created blocked) and activate it via a random token sent by email.

---

REST Register User with Email Verification provides REST endpoints for a register-then-verify flow:
a client POSTs registration data to create an account, the account is created **blocked**, and a random
verification token is emailed to the user; the client then POSTs the username plus that token to a
verify endpoint to activate the account. It also provides a resend-token endpoint. It depends on core
REST.

The flow is soundly built: the account is explicitly `block()`ed on creation (so it can't be used until
verified), the registration field-set only accepts `field_*` custom fields guarded by `hasField()` (so
`roles`/`status`/`pass` can't be injected to bypass verification or escalate), and the verification
token is generated with `Crypt::randomBytesBase64()` (an 80-bit-plus cryptographically-random token),
stored in tempstore and compared strictly — so it cannot be guessed or brute-forced. CSRF header
requirements are removed from these routes, which is expected for anonymous registration endpoints (no
session exists yet). When adopting: serve it over HTTPS, keep the email channel trustworthy (the token
is a bearer credential in the email), and configure the token length/mail in the REST account settings.
This is the intended, verification-gated design — reviewed and found sound.

---

- Register a user via a REST endpoint.
- Create the account blocked until verified.
- Email a random verification token.
- Activate the account with the token.
- Resend the verification token.
- Depend on core REST.
- Generate the token with Crypt::randomBytesBase64.
- Compare the token strictly.
- Block role/status injection at registration.
- Accept only field_* custom fields.
- Serve the endpoints over HTTPS.
- Keep the email channel trustworthy.
- Configure token length in REST settings.
- Prevent unverified account use.
- Treat the token as a bearer credential.
- Remove CSRF for anonymous endpoints (expected).
- Verify email before activation.
- Register decoupled/app users.
- Store the token in tempstore.
- Support a register-then-verify flow.
