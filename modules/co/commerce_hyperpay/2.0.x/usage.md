<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Hyperpay

Integrates Drupal Commerce with HyperPay (OPPWA) using the COPYandPAY widget, plus an Apple Pay variant, confirming each payment by re-querying HyperPay's API server-side.

- Renders the HyperPay COPYandPAY widget for card entry on-site.
- On return, fetches the authoritative payment status from HyperPay via a server-to-server call.
- Verifies the returned amount matches the expected order amount before capturing.
- Supports stored payment methods, recurring payments and refunds.

---

## Installation & configuration

- Requires `commerce_payment`; enable with `drush en commerce_hyperpay`.
- Add a "Hyperpay COPYandPAY Payment" gateway (and optionally the Apple Pay gateway).
- Configure the Authorization Bearer token, Entity ID, server (oppwa.com or eu-prod), allowed cards and test mode type.
- Optionally enable reuse of payment methods and set the recurring Entity ID.
- Choose the widget style (Card or Plain).

---

## Usage & API

- `prepareCheckout()` calls `/v1/checkouts` to obtain a checkout ID and integrity hash for the widget.
- `onReturn()` requires a `resourcePath` and checkout `id`, loads the pre-authorized payment by remote checkout ID.
- It then GETs the `resourcePath` from HyperPay to obtain the real payment status and amount.
- The remote amount is compared to `$payment->getAmount()`; a mismatch throws `InvalidResponseException`.
- `onReturn()` also asserts the payment's order id matches the returning order id.
- Payment status is resolved by a `Factory` into typed status objects (Success, Rejected, Pending, etc.).
- A `SuccessOrPending` status applies the capture transition; a `Rejected` status throws.
- `createPayment()` (server-initiated, e.g. recurring) also validates the returned amount equals the expected amount.
- All API calls send a Bearer token over HTTPS to oppwa.com endpoints with default TLS verification.
- Refunds call `/v1/payments/{id}` with `paymentType: RF` and track partial/full refunds.
- Stored payment methods are created from the return response when reuse is enabled.
- An event (`AlterHyperpayAmountEvent`) lets other modules adjust the payable amount.
- Test mode injects a `testMode` parameter unless configured to NONE.
- Because status and amount are fetched server-side and bound to the order, forged browser returns cannot fraudulently capture.
- Suitable for Middle East/OPPWA merchants using HyperPay.
- Keep the Authorization Bearer token confidential; it authenticates all API calls.
