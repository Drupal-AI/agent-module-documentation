<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule — `commerce_payment_extra_order`

"Commerce Payment Extra - Synchronize orders." Ties the [base API](api.md) to the order state machine:
capture on completion, void on cancellation, and cron auto-placement of fully-authorized abandoned orders.
Deps: `commerce_payment_extra`, `commerce:commerce_payment`, `commerce:commerce_order`,
`advancedqueue:advancedqueue`.

All three automations are **disabled by default** on a fresh install. (Historically the transition
capture/void ran unconditionally; update hook `commerce_payment_extra_order_update_8001` turns
`capture_payments_on_order_transition` and `cancel_payments_on_order_transition` ON for existing sites so the
old behavior is preserved on upgrade.)

## Settings

Route `commerce_payment_extra_order.settings` → `/admin/commerce/config/payment/extra-order`, form
`SettingsForm` (`ConfigFormBase`), permission **`administer commerce_payment_gateway`** (the restricted core
Commerce payment-admin permission). Menu link parents under `commerce_payment.configuration`.

Config object `commerce_payment_extra_order.settings`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `enable_cron` | bool | off | Run the auto-place manager in `hook_cron`. |
| `authorized_auto_place_min_threshold` | int (s) | 3600 | Order must have been unchanged at least this long before auto-placement (gives the customer time to return). |
| `authorized_auto_place_max_threshold` | int (s) | 2592000 | Ignore orders older than this (avoids scanning all abandoned orders). |
| `supported_payment_gateways` | array | `[]` | Only payments on these gateway ids count toward auto-placement. |
| `capture_payments_on_order_transition` | bool | off | Queue captures when an order is fulfilled. |
| `cancel_payments_on_order_transition` | bool | off | Queue voids when an order is canceled. |

## Order-transition subscribers

- **`CompleteOrderEventSubscriber::onComplete`** on `commerce_order.fulfill.post_transition`. Skips if
  `capture_payments_on_order_transition` is off. Loads capturable payments, walks them capping each capture at
  the remaining order **balance** (`amount = min(payment amount, balance)`), enqueues a
  `commerce_payment_extra_capture` job per payment (payload `payment_id`, `amount`), and stops once the
  balance reaches zero. If a null balance, returns early. Logs an **emergency** if payments cannot cover the
  balance.
- **`CancelOrderEventSubscriber::onCancel`** on `commerce_order.cancel.post_transition`. Skips if
  `cancel_payments_on_order_transition` is off. Enqueues a `commerce_payment_extra_void` job per voidable
  payment.

Both push onto the `commerce_payment_extra_order` queue. Jobs are not processed inline — run the queue:

```bash
drush advancedqueue:queue:process commerce_payment_extra_order
```

## Auto-place manager (cron)

`hook_cron` calls `commerce_payment_extra_order.order_authorized_manager` (`OrderAuthorizedManager`) only when
`enable_cron` is set. `processOrders()`:

1. Acquires a 900s lock (`commerce_payment_extra_order_process_authorized_orders`); warns and returns if
   already held.
2. Selects candidate order ids by direct DB query: `commerce_order` joined to `commerce_payment`, `state =
   draft`, `locked = 1`, and `changed` within the min/max threshold window.
3. For each order (`loadUnchanged`): confirms it is still `draft`; requires a `payment_gateway`; sums the
   amounts of capturable payments **whose gateway id is in `supported_payment_gateways`** against the balance.
   If no payments found → debug log and skip; if balance still positive (underpaid) → emergency log and skip;
   otherwise `applyTransitionById('place')`, `unlock()`, `save()`, notice log. Per-order exceptions are caught
   and logged.

This only **places** orders that are already authorized in full — it never captures here. It exists because
core Commerce auto-places captured orders but not merely-authorized ones (e.g. a customer paid in an app and
never returned to the completion page).

## Drush

`AuthorizedOrdersCommands` — `commerce-payment-extra-order:place-authorized-orders` (alias `cpeo:pao`) runs
the same `processOrders()` on demand.

## Queue

`config/install/advancedqueue.advancedqueue_queue.commerce_payment_extra_order.yml`: id
`commerce_payment_extra_order`, label "Process payment on order transition", `backend: database`,
`processor: daemon`, `lease_time: 300`. View items at
`/admin/config/system/queues/jobs/commerce_payment_extra_order`.
