<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Magic Login Link provides secure passwordless login via time-sensitive magic links.

---

Magic Login Link **provides passwordless login via secure magic links** — a user requests a link, receives a
one-time login URL by email, and clicking it logs them in. It depends on core User.

Use it for secure passwordless login. It is an **authentication** feature built the right way (a positive contrast
to weaker OTP modules): the link's token is generated with **core's `user_pass_rehash()`** — the same secure HMAC
Drupal uses for password-reset links (over uid/timestamp/last-login/password-hash), so it is **unguessable and tied
to the user** (not a short brute-forceable code); the token is **single-use** (deleted from State on successful
login), has a **15-minute expiry**, is compared with **`hash_equals`** (timing-safe), and login requests are
**flood-limited** (50/hour per IP, 5/hour per user). The login route is intentionally `_access: TRUE` because the
token itself is the credential (as with core's `user.reset` route). Security notes inherent to magic-link auth:
account security becomes **email-account security + link delivery** — use TLS mail and keep the short expiry. It has
no access-control role. Configure the magic-link login.

---

- Provide passwordless magic-link login.
- Email a one-time login URL.
- Log the user in on click.
- Depend on core User.
- Serve authentication.
- Offer secure passwordless login.
- USE core's user_pass_rehash() for the token (unguessable HMAC, tied to the user — not a brute-forceable code).
- Make the token single-use (deleted on login) + 15-min expiry + hash_equals compare.
- FLOOD-limit requests (50/hr per IP, 5/hr per user).
- Use _access: TRUE because the token is the credential (like core user.reset).
- REDUCE account security to email + link delivery (TLS mail, short expiry).
- Configure the magic-link login.
- Handle magic-link login.
- Send links.
- Configure the login.
- Log users in.
- Verify the token.
- Rate-limit requests.
- Deliver links securely.
- Provide secure magic-link login.
