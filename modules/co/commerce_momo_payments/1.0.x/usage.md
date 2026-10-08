<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce MoMo Payments

Integrates Drupal Commerce with the MoMo (Vietnam) payment platform, providing Wallet, Pay-with-ATM and credit-card offsite gateways that sign requests and verify responses with HMAC-SHA256.

- Redirects the buyer to MoMo to complete payment, then handles the return and IPN.
- Signs outbound "create payment" requests with the merchant secret key.
- Verifies the HMAC-SHA256 signature on both the return and the IPN callback.
- Records a Commerce payment for the order on a successful, signed result.

---

## Installation & configuration

- Requires `commerce`/`commerce_payment`; enable with `drush en commerce_momo_payments`.
- Add a MoMo gateway (Wallet, Pay with ATM, or Credit Card).
- Configure partner code, access key, secret key and the MoMo API endpoint (test vs live).
- Provide MoMo with the IPN URL; the return URL is the standard Commerce checkout return.
- Ensure the API endpoint matches the selected mode.

---

## Usage & API

- `getPayUrl()` builds the request, signs it with `generateSignature()` (`hash_hmac('sha256', ...)`) and calls MoMo's `create` endpoint.
- `onReturn()` checks `resultCode`, then calls `verifySignature()` before creating a payment in `authorization` state.
- `onNotify()` (IPN) loads the payment by `transId`, then calls `verifySignature()` before setting it `completed`.
- `verifySignature()` recomputes the HMAC over the response fields and compares it to the provided signature.
- The signature check uses the merchant secret.
- Payments use `$order->getTotalPrice()` as the recorded amount.
- Result code 0 (SUCCESS) is treated as a completed remote state.
- Provides three gateway plugins sharing `MoMoOffsitePaymentGatewayBase`.
- The HTTP client posts JSON to the configured MoMo endpoint over HTTPS.
- Suitable for Vietnamese merchants using MoMo.
- Keep the secret key confidential; it is the sole signing key.
- Errors raise `PaymentGatewayException` and surface to the buyer/logs.
- Test against MoMo's sandbox endpoint before going live.
