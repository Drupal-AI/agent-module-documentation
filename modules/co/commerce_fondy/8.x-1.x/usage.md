<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fondy Commerce Payment Gateway adds a Fondy off-site gateway with signature- and amount-checked callbacks.

---

Fondy Commerce Payment Gateway is an off-site Drupal Commerce payment gateway for Fondy — the shopper is redirected to Fondy's hosted payment page and the order is completed on return and on the server-to-server notification. The gateway plugin id is `fondy_redirect`; you add it under Commerce's payment-gateway configuration and enter a Fondy merchant ID and secret key (plus an optional card-form language and a pre-authorization toggle).

Security: both `onReturn` and `onNotify` call `isPaymentValid()`, which (1) confirms `merchant_id`, (2) checks the callback **currency and amount** against the order (Fondy sends the amount in minor units, divided by 100 and compared to the order total), and (3) recomputes the Fondy **signature** — `sha1(secret_key + '|'-joined sorted params)` — and compares it to the posted `signature`. Only on success is a `commerce_payment` created in `completed` state, and it is created with the **order's own total**, never a value taken from the callback. Store the Fondy merchant ID and secret key securely (they live in the payment-gateway config entity — keep that config out of version control, or override it from `settings.php` via an environment variable). Depends on `commerce_payment` and `commerce`; the module declares core `^8 || ^9 || ^10 || ^11`.

---

- Provide a Fondy off-site redirect gateway (`fondy_redirect`).
- Redirect the shopper to Fondy's hosted payment page.
- Complete the order on browser return and on Fondy's server notification.
- Sign the outbound checkout request with the merchant secret.
- Verify the merchant ID on every callback.
- Recompute and verify the Fondy response signature.
- Check the callback currency and amount against the order.
- Complete the payment with the order's own total.
- Reject on invalid signature or amount/currency mismatch.
- Cancel the order on an `expired` or `declined` notification.
- Choose the card-form language (Russian, Ukrainian, English, Polish, Latvian, or the user's).
- Optionally send pre-authorization (`preauth=Y`) transactions.
- Pass billing-profile details to Fondy as `merchant_data`.
- Support anonymous and authenticated checkout.
- Store the merchant ID and secret key in gateway configuration.
- Depend on `commerce_payment` and `commerce`.
- Declare support for Drupal core `^8 || ^9 || ^10 || ^11`.
- Keep card entry off your server (small PCI scope).
- Handle Fondy notifications idempotently (de-dupe by `payment_id`).
- Integrate with Commerce checkout without custom code.
