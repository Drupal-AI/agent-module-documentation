<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Off-site payment flow

Source: `src/Plugin/Commerce/PaymentGateway/BtcPayRedirect.php`,
`src/PluginForm/BtcPayRedirectForm.php`, `src/InvoiceStatus.php`,
`src/WebhookEventStorage.php`.

## Invoice creation + redirect

`BtcPayRedirectForm::buildConfigurationForm()` (the `offsite-payment` form) calls
`BtcPayRedirect::createInvoice($payment, $options)`, which uses the Greenfield `Invoice` client
(`getInvoiceClient()`) to create an invoice on `store_id` with the payment's **immutable amount**
(`PreciseNumber::parseString`), currency, `orderId` metadata, the return URL as the redirect, and the
buyer email **only** when `send_buyer_email` is enabled (default off).

The form then binds the local payment to the remote invoice **before** redirecting:
`$payment->setRemoteId($invoice_data['id'])`, `setRemoteState(status)`, and stores
`$order->setData('btcpay', ['invoice_id' => …])`. It rejects an invoice missing `id`,
`checkoutLink`, or `status`. Redirect is `REDIRECT_GET` to `checkoutLink`. The order-data copy is only
used to locate the invoice on customer return; webhooks resolve the payment by remote invoice ID.

## `onReturn()` — customer return leg

1. Reads `invoice_id` from order data; requires it.
2. Acquires a per-invoice lock (`commerce_btcpay.invoice.<sha256(gateway\0invoice)>`, 30s).
3. `loadPaymentForInvoice()` — entity query on `remote_id`; requires **exactly one** match (returns
   NULL for 0 or >1, which is treated as an error).
4. Re-fetches the invoice from BTCPay: `getInvoice($invoice_id)` → `Invoice::getInvoice(store_id, id)`.
5. `assertInvoiceBinding()` (see below).
6. `applyAuthoritativeState()` sets the payment state from `InvoiceStatus::paymentState($invoice_data)`;
   throws unless `InvoiceStatus::isCheckoutComplete()` (status `Settled`).

The return leg never trusts any query/redirect parameter for status — state comes only from the
re-fetched invoice.

## `onNotify()` — BTCPay webhook / IPN

Route `commerce_btcpay.notify` (POST, `_access: TRUE`) → Commerce's
`PaymentNotificationController::notifyPage` → this method. Order of checks:

1. **HMAC signature.** `validWebhookRequest($signature, $payload)` requires the `BTCPay-Sig` header
   and validates it over the **unmodified raw body** with the stored webhook secret via
   `Webhook::isIncomingWebhookRequestValid()`. Missing/invalid → `403`.
2. **Payload validation.** `validateWebhookPayload()` decodes JSON (depth 32) and requires string
   `deliveryId`, `webhookId`, `storeId`, `invoiceId`, `type` (each non-empty, ≤255 chars); `type`
   must be one of the six subscribed invoice events; a redelivery must carry `originalDeliveryId`;
   `timestamp` must be a positive int. Malformed → `400`.
3. **Store/webhook match.** `hash_equals` on configured `store_id` and `webhook_id` → mismatch `403`.
4. **Idempotency.** `WebhookEventStorage::isProcessed()` checks both the delivery ID and its original
   delivery ID; already processed → `200` (no-op).
5. **Authoritative re-fetch.** `getInvoice($event['invoice_id'])` — the current invoice is fetched
   from BTCPay; if unavailable → `503 Retry-After`. The event type is **never** used to decide the
   resulting payment state (explicit code comment: "Always fetch current authoritative state").
6. `loadPaymentForInvoice()` — must resolve to exactly one pre-existing local payment (else `409`).
7. `assertInvoiceBinding()` (below); mismatch → `400`.
8. **Ordering.** Only applies state when `event.timestamp >= last stored timestamp` for the invoice,
   then `markProcessed()` records both delivery IDs and advances the timestamp. `200`.

All state updates run under the same per-invoice lock as `onReturn`, so return and webhook cannot
race. Any unexpected throw → `500`.

## `assertInvoiceBinding()` — cross-checks

Guards against cross-order / arbitrary-invoice substitution. Requires (all via `hash_equals` /
precise compare):

- Re-fetched invoice `id` == local `payment->getRemoteId()`.
- `payment->getPaymentGatewayId()` == this gateway.
- Payment's order == the (optional) expected order.
- Invoice `metadata.orderId` == the payment's order id.
- Invoice `storeId` == configured `store_id` (non-empty).
- **Amount + currency:** invoice currency == payment currency, and invoice amount == payment amount
  compared with `bccomp` at full sub-unit scale (`decimalAmountsEqual`) — blocks crypto
  underpayment / wrong-currency settlement.

## Invoice → Commerce state mapping (`InvoiceStatus`)

- `Settled` with `additionalStatus` in {`None`, `PaidOver`, `Marked`} → `completed`; other
  `additionalStatus` on Settled → no transition.
- `additionalStatus == PaidPartial` → `authorization`.
- `New` → `new`; `Processing` → `authorization`; `Expired` → `authorization_expired`;
  `Invalid` → `authorization_voided`.
- `canTransition()` enforces **monotonic** transitions (e.g. from `new`→auth/completed,
  `authorization`→expired/voided/completed); non-monotonic transitions are ignored (logged only in
  debug mode). `isCheckoutComplete()` is true only for `Settled`.

`applyAuthoritativeState()` also records the raw remote state (`status[:additionalStatus]`) on the
payment and saves.
