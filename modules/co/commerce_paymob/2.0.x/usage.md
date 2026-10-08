<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Drupal Commerce payment gateway integrating the Paymob provider, offering both an offsite redirect flow and an onsite "Pixel" flow with stored payment methods.
---
Two gateway plugins extend a shared `PaymobBase` (an `OffsitePaymentGatewayBase`): `paymob_redirect` sends the customer to Paymob and back, while `paymob_pixel` supports on-site tokenized payments and reusable cards. The gateway builds a payment *intention* (`createIntention`) with the order total (converted to minor units), billing data and a `notification_url`, then calls the Paymob API with the secret key as a bearer token over the region-specific HTTPS base URL (Egypt/Oman/Saudi/UAE). On the customer's return (`onReturn`) and on the server-to-server webhook (`onNotify`), the response is verified with `Paymob::verifyHmac()` against the configured HMAC secret before any payment state transition is applied; refunds are supported via the void/refund endpoint.

Security-relevant behaviour is sound for the campaign's checks: TLS is not disabled (Guzzle over `https://` region hosts); the webhook and return callbacks are HMAC-verified before fulfilment (a bad/absent signature throws `PaymentGatewayException`); the Pixel flow additionally re-checks that the charged amount equals the expected amount; and card tokens (not PANs) are stored. Credentials (secret key, api key, HMAC) are stored in gateway configuration as plain config values. Setup: add a Paymob payment gateway under Commerce → Payment gateways, choose the region/server, and enter the public/secret/api keys, payment integration id(s) and HMAC.
---
- Accept card payments via Paymob on a Drupal Commerce store.
- Offer an offsite redirect checkout (`paymob_redirect`).
- Offer an onsite tokenized checkout (`paymob_pixel`).
- Select the Paymob region/server (Egypt, Oman, Saudi Arabia, UAE).
- Enter public, secret, api and HMAC keys in the gateway form.
- Configure one or more Paymob payment integration IDs.
- Verify return and webhook responses with Paymob HMAC.
- Reject unsigned/invalid callbacks with a gateway exception.
- Build a payment intention with order total and billing data.
- Send the customer's phone from a configurable profile field.
- Store reusable card tokens (up to Paymob's max of 3) for a customer.
- Save a payment method automatically on successful tokenized payment.
- Capture or authorize based on Paymob's standalone/auth flags.
- Refund full or partial amounts via the void/refund endpoint.
- Convert prices to/from minor units for the API.
- Re-verify the charged amount matches the expected amount (Pixel).
- Use a per-payment special reference for reconciliation.
- Fulfil the order from the webhook if the return handler was missed.
- Cache token webhook payloads briefly to attach card data.
- Delete stored payment methods when required.