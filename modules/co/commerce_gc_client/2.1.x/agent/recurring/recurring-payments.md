<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recurring payments, subscriptions & mandate self-service

## Payment types (per product variation)

Set on GoCardless-enabled product variation types via the Recurrence Rules subform:

- **Instant payment** — single open-banking payment at checkout, no mandate (UK/DE only).
- **Subscription** (`gc_type = 'S'`) — GoCardless creates the recurring payments on a schedule
  (interval/start/end/count/day-of-month/month) defined in the variation's `data`.
- **One-off** (`gc_type = 'P'`) — mandate-backed payments the **site** creates: immediately at
  checkout (`gc_create_payment`) and/or on a schedule computed by `startDateCalculate()`, then
  driven by cron.

## Checkout-time creation (static helpers on `GoCardlessClient`)

- `processMandate($order, $billing_request, $mandate_id)` — inserts the `commerce_gc_client`
  row (order_id, mandate id, scheme, `pending_submission`, serialized billing_request/customer
  ids, sandbox flag).
- `processPayment($payment_request, $partner, $item, $data, $calculate, $mandate_id, $gcid, $on_return=true)`
  — for one-off items: creates an immediate GC payment (unless an instant payment already
  covered it) with a UUID `idempotency_key`, dispatching `PAYMENT_NEXT` (first/next date) and
  `PAYMENT_DETAILS` (alter payload) and `PAYMENT_CREATED`. Records `next_payment` in
  `commerce_gc_client_item`. On no-response/500 it persists `payment_details` for a same-key
  retry.
- `processSubscription(...)` — creates a GC subscription, storing `gc_subscription_id`;
  dispatches `SUBS_DETAILS`. On failure persists `subs_details` for cron retry.

## Cron — `commerce_gc_client_cron()` (`commerce_gc_client.module`)

Guarded by a `commerce_gc_client_cron` lock (avoids duplicate payment creation across
overlapping runs). Selects `commerce_gc_client_item` rows with `next_payment <= now` and
non-cancelled mandates, then per item:

- Verifies the mandate is still valid via the GC API.
- **Subscriptions**: retries a failed checkout-time creation from stored `subs_details`.
- **One-off**: enforces the daily `payment_limit` (emails `email_warnings` and skips if
  exceeded — `payment-limit-reached` mail); recomputes the amount with
  `commerce_gc_client_price_calculate($order, $item, $payment)` (server-side, incl. scheduled
  adjustments and FX); validates amount (< 1 warns + `payment-less-than-one` mail, == 0 skips);
  optionally creates a **recurring child order** (`commerce_gc_client_recurring_order()`); then
  creates the GC payment with a UUID idempotency key. No-response/500 persists `payment_details`
  for a same-key retry on the next run. Updates `next_payment` (dispatching `PAYMENT_NEXT`).

Recurring child orders reference the parent (and vice-versa) in order `data['gc']`, can be
placed as `completed` or `draft` (to email an invoice), and are surfaced on the order receipt
via `hook_preprocess_commerce_order_receipt`.

## Mandate self-service & admin

- Admin: `commerce_gc_client_commerce_order_view` renders `Form/MandatePaymentsForm` on the
  order (component `commerce_gc_client_mandate_info`) — a mandate selector + live GC payments
  table (fetched via the partner API) + Cancel / Update-payment-account / Create-new-mandate
  action links. An admin "GoCardless" tab (route `commerce_gc_client.mandate`, `Form/Mandate`)
  and adjustment/payment-cancel forms are gated by `administer commerce_order`.
- Customer: routes `mandate_cancel` / `mandate_change` / `mandate_reinstate` (+ their
  `*_complete` controllers `Controller/MandateChangeComplete`) live under
  `/user/{user}/orders/{commerce_order}/…`, gated by `_entity_access: commerce_order.view` and
  `view own commerce_order+administer commerce_order`. "Update payment account" creates a new
  mandate via a billing-request flow, migrates pending payments onto it, and cancels the old
  one; "reinstate" creates a fresh mandate after cancellation.
- `commerce_gc_client_mandate_cancel()` cancels GC mandate(s) for an order and clears
  scheduled payments; `hook_commerce_order_delete` cancels the mandate then purges local rows.
