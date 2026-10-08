<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirmation flows, callback URLs & MB WAY repayment

## Callback URLs to register in the ifthenpay backoffice

Notify uses core's `commerce_payment.notify` route (`_access: TRUE` by design — external servers must
reach it; each gateway authenticates the call with its anti-phishing key). Replace `GATEWAY_ID` with
the gateway machine name:

| Channel | URL |
|---|---|
| Multibanco, offline | `/payment/notify/GATEWAY_ID?chave=[KEY]&entidade=[ENTITY]&referencia=[REFERENCE]&valor=[AMOUNT]` |
| Multibanco, API (MB Key) | same, plus `&requestId=[REQUEST_ID]` |
| MB WAY | `/payment/notify/GATEWAY_ID?chave=[KEY]&idpedido=[REQUEST_ID]&estado=[STATE]` |

Credit card has **no notify URL** — it confirms on the browser return.

## Multibanco `onNotify()` (Ifthenpay.php)

Server-authoritative. Steps: require `referencia/chave/valor/entidade`; validate the anti-phishing
key with a **strict compare**; load *all* payments with that remote id (collision-aware, not just the
first); `selectBestPaymentCandidate()` picks a payment whose amount matches the callback `valor`
(±0.01), preferring `pending`; validate the **entity per payment** (API-mode payments against the
ifthenpay-assigned entity stored in order data, offline against the configured entity); validate the
optional **requestId** against the stored value; re-check the amount; and only then complete a
`pending` payment and settle the order balance. Already-processed references are logged and left
alone. Nothing in the request can under-report the amount to force cheap fulfilment.

## Credit card `onReturn()` (IfthenpayCC.php)

The browser-return path is the confirmation. It reads `status/requestId/amount/sk/id`, loads the
payment by `requestId`, and:

1. On `status === 'error'` or missing `sk` (cancel), deletes the payment and throws.
2. Recomputes `SK = SHA-256(orderId + amount + requestId + cccard_key)` using the **server-side order
   total** and rejects with a strict `!==` on mismatch (deletes payment, throws).
3. Re-checks `number_format(charged_amount) === number_format(order_total)`; mismatch → delete +
   throw.
4. Only then `setState('completed')`.

Forged or tampered returns without the CCARD key fail the SK check. Note there is no server-to-server
notify for CC, so completion depends on the shopper returning to the site.

## MB WAY `onNotify()` (IfthenpayMbway.php)

Validates the `callback_antiphishing` key, then on `estado === 'PAGO'` loads the payment by
`idpedido` (remote id) and completes it, settling the order balance. The anti-phishing shared secret
authenticates the call.

## Order balance settling — `SettlesOrderBalanceTrait`

Commerce recalculates `total_paid` at request shutdown, which races the customer's still-open checkout
request (acute for MB WAY, seconds apart). The trait calls
`PaymentOrderUpdaterInterface::updateOrder()` immediately after a notification completes a payment,
reloading and retrying up to 3× on `OrderVersionMismatchException`, so `order.paid` fires and the
order state transitions instead of stalling as "unpaid" with a completed payment.

## MB WAY storefront repayment endpoint

Route `commerce_ifthenpay_mbway.repayment` — **POST** `/commerce-ifthenpay/mbway/repayment/
{commerce_order}` (`MbwayRepaymentController::request`). Lets a customer re-send the push for an
unpaid order from order history without re-checkout.

- **Access** (`_custom_access`): authenticated **order owner**, or the anonymous **cart-session
  owner** (`CartSessionInterface` ACTIVE/COMPLETED) — mirrors `CheckoutController`.
- **CSRF**: validates the `X-CSRF-Token` header (obtain from `/session/token`) against core's
  `TOKEN_KEY` scope, with the legacy `rest` scope as fallback (core's header check skips anonymous,
  so this is done explicitly for every request).
- **Flood**: 5 attempts per order and 20 per IP, per hour (429 on exceed).
- `MbwayRepaymentService::requestPayment()` validates the mobile number (`^\d{9,15}$`), refuses
  canceled/already-paid orders, computes the amount from the **server-side order balance**, requests
  a fresh push via `sendPaymentRequest()` (past the duplicate guard, since a resend is deliberate),
  and only after ifthenpay accepts it does it locally void the previous authorization payments (a
  declined push leaves the old one — and its still-valid instructions — untouched). Returns JSON
  `{status, mbway_number, amount_number, amount_currency, amount_formatted}`. No JS ships with the
  module; the endpoint is meant to be driven by a custom storefront front-end.
