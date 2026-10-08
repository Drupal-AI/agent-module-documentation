<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Eurobank

Provides an off-site redirect payment gateway for the Eurobank / Modirum vPOS platform, validating each callback's SHA-256 digest against the order's shared secret before completing payment.

- Redirects the buyer to the Eurobank vPOS to enter card details.
- Receives a POST callback with the transaction result and a digest.
- Recomputes the digest from the response fields plus the shared secret and compares it.
- Only creates a completed payment when the digest matches and the status is CAPTURED/AUTHORIZED.

---

## Installation & configuration

- Requires `commerce`/`commerce_payment`; enable with `drush en commerce_eurobank_redirect`.
- Add a payment gateway of type "Eurobank Payment Redirect".
- Configure spec version, merchant ID, currency, confirm/cancel URLs, shared secret and the vPOS post URL.
- Point the Eurobank confirm/cancel URLs at the module's `/commerce_eurobank_redirect/callback` route.
- Change the default `shared_secret` ("SECRET") to the value issued by Eurobank.

---

## Usage & API

- The callback route `/commerce_eurobank_redirect/callback` is `_access: 'TRUE'` (public, as gateway callbacks must be).
- `CallbackController::calculateHash()` builds `base64(sha256(concatenated response fields + shared_secret))`.
- The digest comparison uses strict `!==`, so a wrong/absent digest is rejected.
- `processCallback()` only creates a payment when status is CAPTURED/AUTHORIZED and the digest matches.
- `createPayment()` sets the amount from `$order->getBalance()` (server-side), not from the raw callback amount.
- The order id is parsed from the signed `orderid` field and used to load the shared secret for verification.
- CANCELED status redirects the buyer to the checkout cancel step.
- Mismatched digest records an "Unvalidated" payment and logs an alert.
- All callback data is also logged into the order's `EurobankGatewayData` for auditing.
- The shared secret is per-gateway configuration and is the sole signature key.
- Because the digest binds order id, amounts and status, forged callbacks without the secret are rejected.
- Successful validation redirects the buyer to the checkout complete step.
- Suitable for Greek/Eurobank merchants on the Modirum vPOS.
- Ensure the shared secret is unique and secret in production.
- Test with the Eurobank test vPOS endpoint before going live.
- Logs success/failure to the `commerce_eurobank_redirect` channel.
