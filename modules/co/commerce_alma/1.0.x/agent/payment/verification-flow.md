<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Offsite flow, verification, refunds & reconciliation

All method references are in
`src/Plugin/Commerce/PaymentGateway/OffsitePaymentGateway.php` unless noted.

## 1. Redirect out (createPayment)

`RedirectCheckoutForm::buildConfigurationForm()` calls
`OffsitePaymentGateway::createPayment($payment, $return_url, $cancel_url)`, then
`buildRedirectForm(... $remote_payment->url ...)` to POST the shopper to Alma.

`createPayment()` builds the Alma params entirely from server-side order/payment data:
- `payment.purchase_amount = (int) $payment->getAmount()->multiply('100')` (cents) — never a
  request value;
- `payment.return_url` / `customer_cancel_url` (from the offsite form) and
  `payment.ipn_callback_url = $this->getNotifyUrl()` (the Commerce IPN route);
- `order.merchant_url` / optional `customer_url` built with `Url::fromRoute(...)`;
- optional billing/shipping/customer blocks from the order's profiles;
- installments/deferred from the configured `fee_plan` key.

It dispatches `commerce_alma.create_payment` (`CreatePaymentEvent`) so other modules can alter the
params, then `$this->api->payments->create($params)`, storing the returned `remote_id` and
`remote_state` on the local payment (which is in `new` state). A `RequestError` becomes a
`PaymentGatewayException`.

## 2. Return / IPN verification — server-authoritative

Both handlers take **only** the `pid` query param and re-fetch from Alma; neither trusts a
client-supplied status or amount.

- `onReturn(OrderInterface $order, Request $request)` — no `pid` → `PaymentGatewayException`;
  else `$this->api->payments->fetch($pid)` then `validatePayment($remote_payment)`.
- `onNotify(Request $request): JsonResponse` — same fetch+`validatePayment`, then sets the
  payment's remote state and amount and applies a transition: `authorize_capture` when Alma reports
  `STATE_PAID`, otherwise `authorize`. Returns an empty `JsonResponse`.

`validatePayment(RemotePayment $remote_payment): PaymentInterface`:
1. `loadByRemoteId($remote_payment->id)` — missing local payment → exception.
2. Idempotency: returns early if the order `isPaid()` or is `canceled` (no double capture).
3. Requires remote `state ∈ {STATE_IN_PROGRESS, STATE_PAID}`; otherwise flags Alma-side
   `FRAUD_STATE_ERROR` and throws.
4. Requires the remote `purchase_amount` (÷100 EUR) to equal the local payment amount
   (`compareTo !== 0` → flags `FRAUD_AMOUNT_MISMATCH`, throws).
5. Requires the remote amount not to exceed `$order->getBalance()`.

The Alma API host is fixed by the SDK from the `mode` (test/live) enum, and the fetch is
authenticated with the merchant `api_key`, so `pid` acts purely as a lookup key.

## 3. Refunds

`SupportsRefundsInterface`. `canRefundPayment()` returns TRUE only if `payments->fetch(remoteId)`
succeeds. `refundPayment()` asserts the payment is in `completed`/`partially_refunded`
(`REFUNDABLE_PAYMENT_STATES`) and the amount is valid, then calls `payments->partialRefund(id, amount×100)`
for a partial or `payments->fullRefund(id)` for a full refund, and sets the local state to
`partially_refunded` / `refunded` with the accumulated refunded amount. `RequestError` →
`PaymentGatewayException`.

## 4. Cron / queue reconciliation

Because Alma installment payments settle over time, a second path captures in-progress payments:
- `Cron` (`commerce_alma.cron`, invoked by `hook_cron`): if the
  `commerce_alma_payment_updater` queue is empty (guard against unbounded growth), it loads Alma
  gateways with `update_payments = TRUE` and enqueues every `commerce_payment` whose
  `remote_state = in_progress` for those gateways.
- QueueWorker `PaymentUpdater` (`@QueueWorker`, `cron = {"time" = 60}`): for each queued payment it
  re-checks it is an `alma` gateway with `update_payments`, `getApi()->payments->fetch(remoteId)`,
  and — if Alma now reports `STATE_PAID` and the `capture` transition is allowed — applies
  `capture`; it always updates the stored `remote_state`. Failures are logged as a warning; the item
  is not requeued forever because the cron only refills an empty queue.
