<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Drupal Commerce payment gateway for Khalti (Nepal), with session-bound verified callbacks.

---

Khalti provides the Khalti payment gateway for Commerce payments — letting a Nepali store accept payments via Khalti (redirect/e-wallet), with a transaction admin UI.

Security: the return handler (`/khalti/success/{token}`) is defensively built — the `{token}` is a CSRF-like value stored in the session during checkout and compared with **`hash_equals()`** (403 on mismatch), and the controller explicitly **verifies the payment server-side via Khalti's lookup API** rather than trusting the callback parameters ("Never trust the callback parameters alone") — the correct, defensive pattern. Store the Khalti secret key securely (env-backed). Depends on the Commerce suite; supports Drupal 10 and 11.

---

- Provide the Khalti gateway.
- Accept e-wallet/redirect payments.
- Serve Nepali stores.
- Bind the callback to the session token.
- Compare tokens with `hash_equals()`.
- Verify the payment via Khalti's lookup API.
- Not trust callback params alone.
- Store the secret key securely.
- Depend on the Commerce suite.
- Support Drupal 10 and 11.
- Handle checkout.
- Confirm payments
- Support Drupal.
- Support Drupal.
- Support Drupal.
