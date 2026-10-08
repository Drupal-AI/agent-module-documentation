<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CoinsPaid Commerce adds a CoinsPaid crypto off-site gateway with signature-verified callbacks.

---

CoinsPaid Commerce (module `commerce_coinspaid`, project `coinspaid`) is a Drupal Commerce off-site payment gateway for CoinsPaid — letting customers pay in cryptocurrency by redirecting to CoinsPaid and completing the order on callback.

Security: the callback (`onNotify`) verifies an **HMAC-SHA512 signature** (`X-Processing-Signature`) of the callback body against the configured secret key and throws on mismatch (no payment on an invalid signature), and it records the payment using the **order's own total** rather than a callback-supplied amount — the correct, defensive pattern. The public and secret keys are entered in the payment gateway configuration form; keep the secret key confidential (it is what keys signature verification). Depends on `commerce_payment` (and `commerce`); the module declares `core_version_requirement: ^8 || ^9 || ^10 || ^11`.

---

- Provide a CoinsPaid crypto gateway.
- Redirect to CoinsPaid to pay.
- Complete the order on callback.
- Accept cryptocurrency.
- Verify an HMAC-SHA512 callback signature.
- Throw on signature mismatch.
- Record payment using the order total.
- Not trust a callback-supplied amount.
- Enter public/secret keys in the gateway config; keep the secret confidential.
- Depend on `commerce_payment` and `commerce`.
- Support Drupal 8, 9, 10, and 11.
- Handle crypto checkout.
- Process payments
- Verify callbacks
- Support Commerce.
- Confirm securely.
- Handle CoinsPaid.
- Keep keys secure
