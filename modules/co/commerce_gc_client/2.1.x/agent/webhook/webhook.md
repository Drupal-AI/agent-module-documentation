<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook receiver

`Controller/WebhookHandler::webhook()` — route `commerce_gc_client.webhook`,
`POST /gc_client/webhook`, `_permission: 'access content'`. Delivered directly by GoCardless
(not proxied through the partner). This is how asynchronous bank-payment state (pending →
confirmed / failed / charged_back), mandate state, and subscription state are reconciled back
onto Commerce orders and payments.

## Signature verification (done before any processing)

1. Reads request headers (`getallheaders()` or an `HTTP_`-prefix fallback for nginx),
   lowercased. Picks the `webhook-signature` header and derives `mode` from the `origin`
   header (`sandbox` if it contains "sandbox", else `live`).
2. Loads the per-mode secret with `commerce_gc_client_get_webhook_secret($mode)` (private
   file `private://commerce_gc_client/webhook_secret_<mode>`, config fallback). If unset →
   `403 Forbidden` and a warning is logged.
3. Computes `hash_hmac('sha256', file_get_contents('php://input'), $secret)` over the raw
   body and compares to the provided signature with `hash_equals()` (a constant-time
   fallback `hashEquals()` exists for PHP < 5.6). Mismatch → `403 Forbidden` (error logged).

Only when the signature matches are events decoded (`json_decode`) and processed. On success
the controller returns an empty `200` response.

## Event processing

Events are re-ordered by `created_at` (`usort` on timestamp). For each event, by
`resource_type`:

- **`mandates`** — resolve order via `getOrderId(mandate_id)`; update
  `commerce_gc_client.gc_mandate_status` to the event action; log a `webhook_description`
  commerce_log entry.
- **`subscriptions`** — resolve order via subscription id; update
  `commerce_gc_client_item.gc_subscription_status` (except `payment_created`/`amended`).
- **`payments`** — **re-fetch the payment from the GC API by id** (does not trust posted
  amounts), then resolve the order (recurring_order_id metadata → mandate lookup →
  order_id metadata) and call `payments()`:
  - `created` + no existing local payment → create a `commerce_payment` in state `new` with
    the server-side amount (order/item total, FX-adjusted) and `remote_id`/`remote_state`.
  - existing payment → transition state: `pending_*`/`submitted` → `authorization`;
    `confirmed`/`paid_out` → `completed`; `cancelled`/`customer_approval_denied`/`failed`/
    `charged_back` → `authorization_voided` (failed also logs `payment_failed`).
- **`billing_requests`** (action `fulfilled` only) — re-fetch billing request; if the order
  has no `commerce_gc_client` row yet, finish mandate creation (`GoCardlessClient::processMandate`)
  and create the item's payment/subscription (covers the case where the mandate was not ready
  when the customer returned to the site).

After each processed event: optionally logs the raw event (`log_webhook`), then dispatches the
`WEBHOOK` event (`Event/WebhookEvent`, carries event + order id) so other modules can react.

`getOrderId()` maps a GC mandate id (prefix `MD`) or subscription id back to the
`commerce_gc_client.order_id` via the local tables.
