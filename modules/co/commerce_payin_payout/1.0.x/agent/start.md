<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Payin-Payout (commerce_payin_payout) — agent index

**Off-site Commerce payment gateway for the Payin-Payout service, completing orders from an md5-signed notification.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** commerce:commerce, commerce:commerce_payment
- **Gateway plugin:** `payin_payout` (OffsitePaymentGatewayBase), offsite-payment form `PayinPayoutForm`.
- **Notification:** `onNotify(Request)` — validates required fields, recomputes the md5 sign and compares with `hash_equals`, then creates a `completed` payment and returns an XML ack.
- **Sign:** `md5(implode('#', data) . '#' . md5(api_token))` (`PayinPayoutHelper`).
- **Config:** api_token, agent_id, agent_name, order_id_prefix, customer_phone_field_name, api_logging.
- **Endpoints:** live `https://lk.payin-payout.net/api/shop`, test `https://dev1.payin-payout.net`.

**Security:** the notify endpoint is anonymous (standard Commerce `onNotify` route) but order fulfillment is guarded by a token-derived signature verified with `hash_equals()`; forged or unsigned callbacks are rejected. Residual notes: the created payment amount/currency come from the (signed) notification rather than an independent re-fetch, and the API token is stored in plaintext gateway config. Sound posture overall for a callback-based gateway.

See [configure/gateway.md](configure/gateway.md).
