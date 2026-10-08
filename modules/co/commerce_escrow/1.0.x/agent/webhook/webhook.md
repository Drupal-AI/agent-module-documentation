<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook & state-machine sync

## Route
`commerce_escrow.webhook` (`commerce_escrow.routing.yml`):
`POST /payment/webhook/escrow` → `EscrowController::webhook()`. This is the endpoint you
register in your Escrow.com account so it can post transaction events back to the site.
Configure it on Escrow.com as `https://yourwebsite.com/payment/webhook/escrow`.

## Controller flow (`src/Controller/EscrowController.php::webhook`)
1. Decodes the JSON body and requires the keys `event`, `event_type`, `transaction_id`,
   `reference` (else `400 {"error":"invalid payload"}`).
2. Loads the order by `reference` (the Drupal order id); `400` if not found.
3. If the order is still `draft` (Offer flow, where the buyer is not redirected back), applies
   the `place` transition, `unlock()`s and saves the order.
4. Resolves the payment by `remote_id == transaction_id`. If none:
   - Offer `create` event: adopts existing order payment(s) by setting their remote id.
   - Otherwise creates a payment (`state=new`, `amount=$order->getBalance()`,
     `remote_state=create`, the given `remote_id`).
5. Sets `payment.remote_state = event`.
6. **Offer `payment_sent` only:** re-reads the transaction from Escrow
   (`getEscrowByOder` → `getTransactionByReference`) and rewrites each order item's unit price
   and the payment amount from the **remote** schedule totals (server-fetched, not from the
   body), then `orderRefresh->refresh()`.
7. Dispatches `EscrowEvents::ESCROW_WEBHOOK` (`EscrowWebhookEvent`). If a subscriber called
   `setStopWebhook()`, returns `200` early (lets sites replace the automated logic).
8. Writes a `commerce_log` entry via template `escrow_event`
   (`commerce_escrow.commerce_log_templates.yml`), with a human description looked up from
   `EscrowItemInterface::ESCROW_TRANSACTION_EVENTS[event]` and the transaction id.
9. Applies the transition **named after `event`** to the order state machine, and separately
   to the payment state machine, when each transition is currently allowed.
10. Returns `200 []`.

The set of recognised Escrow event names and their descriptions is the
`ESCROW_TRANSACTION_EVENTS` map in `Entity/EscrowItemInterface.php` (create, agree,
payment_sent/received/approved/rejected/refunded/disbursed, ship/receive/accept/reject and
their `_return` variants, complete, cancel, offer_accepted, refund_resolved/rejected).

## Events for integrators
- **`EscrowEvents::ESCROW_ORDER_PAYLOAD`** (`EscrowOrderPayloadEvent`, get/setPayload,
  getOrder) — alter the transaction payload before it is sent to Escrow (dispatched in
  `EscrowTrait::buildOrderPayload`).
- **`EscrowEvents::ESCROW_WEBHOOK`** (`EscrowWebhookEvent`, get/setPayload, getOrder,
  `setStopWebhook()`/`stopWebhook()`) — react to inbound events, mutate the payload, or halt
  the module's automatic order/payment transitions.
