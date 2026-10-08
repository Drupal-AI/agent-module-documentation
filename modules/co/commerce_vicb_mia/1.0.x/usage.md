<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Victoria Bank MIA integrates the Victoria Bank MIA payment gateway (Moldova) with Drupal Commerce.

---

Commerce Victoria Bank MIA provides Commerce integration for Victoria Bank MIA — a payment gateway for Moldova — the shopper pays via a Victoria Bank MIA QR code and the bank posts a callback.

Security: the callback re-fetches the QR status SERVER-SIDE from the bank (authenticated Bearer GET, keyed on a DB-stored `qr_header_uuid` not the payload) and completes only on `STATUS_PAID`, using `$order`'s own total — safe against forged callbacks. NOTE: its JWT check is dead code (`verify_jwt($jwt, '')` with an empty secret + inverted guard), so the JWT signature is NOT actually validated; the security rests entirely on the server-side status re-fetch (fix the JWT check as defense-in-depth). Store the Victoria Bank MIA API credentials securely (env-backed), never committed. Depends on `commerce`, `commerce_payment`; supports Drupal per ^10 || ^11.

---

- Integrate the Victoria Bank MIA gateway.
- Serve Moldova.
- Redirect/charge via the provider.
- Complete the order after payment.
- the callback re-fetches the QR status SERVER-SIDE from the bank (authenticated Bearer GET, keyed on a DB-stored `qr_header_uuid` not the payload) and completes only on `STATUS_PAID`, using `$order`'s own total — safe against forged callbacks.
- Use Drupal Commerce payment.
- Store credentials securely (env-backed).
- Never commit credentials.
- Depend on `commerce`, `commerce_payment`.
- Support ^10 || ^11.
- Handle checkout.
- Process payments.
- Confirm the payment.
- Handle notifications.
- Support Commerce.
- Integrate Victoria Bank MIA.
- Charge customers.
- Reconcile orders.
