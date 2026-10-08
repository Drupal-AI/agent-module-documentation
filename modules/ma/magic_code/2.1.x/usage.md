<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Magic Code allows the use of a "Magic Code" for authentication/verification.

---

Magic Code provides a **"Magic Code" authentication/verification system** — issuing short codes (e.g. for
passwordless email login or verifying an action) that a user submits to authenticate, with an
`magic_code_email_login` and `magic_code_verify_form` submodule. It depends on Consumers and Verification, in
the Authentication package.

Use it for passwordless login / action verification. It is an authentication feature and it is implemented
**carefully**: codes are generated with a **CSPRNG** (`random_int`), stored with an **expiry (TTL)** and a
single-use **status** flag, and — crucially — verification is **flood-protected** (modeled on core `basic_auth`):
independent **IP and per-user** limits on both code creation and verification (default ~50 failed verifications
per hour per IP), checked **before** any lookup, so guessing codes is rate-limited. A verification only succeeds
when a non-expired, active code matches the user + email + operation + client. Because verification is
flood-limited and codes are unguessable and expiring, brute force is well-mitigated. Configure the code TTL,
flood limits and the login/verify flow. Handle any email delivery of codes over your normal (secure) mail path.

---

- Provide magic-code auth/verification.
- Support passwordless email login.
- Verify actions with codes.
- Depend on Consumers and Verification.
- Generate codes with a CSPRNG (random_int).
- Store codes with expiry + single-use status.
- Flood-protect verification (IP + per-user).
- Check flood limits BEFORE any lookup.
- Scope a code to user+email+operation+client.
- Rate-limit brute force (default ~50/hour/IP).
- Configure TTL and flood limits.
- Deliver codes over a secure mail path.
- Handle magic codes.
- Verify codes.
- Configure the flow.
- Issue codes.
- Handle authentication.
- Check codes.
- Rely on the flood control.
- Provide magic-code auth.
