<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events & order subscriber (extension points)

## Events (`Event/AffirmEvents.php`)

Two event constants, both `commerce`-style events (`EventBase`):

- **`AffirmEvents::AFFIRM_TRANSACTION_DATA_PRESEND`** (`commerce_affirm.transaction_data_presend`) —
  dispatched with `AffirmTransactionDataPreSend($checkout_settings, $order)` inside
  `Redirect::getAffirmCheckoutSettings()`, **after** the module has assembled the full Affirm checkout
  object (totals, items, billing/shipping, discounts) and **before** it is handed to `affirm.js`.
  Subscribers use `getData()` / `setData()` to add or rewrite the checkout object, and `getOrder()` for
  context. Use this to send extra metadata, tweak item breakdowns, etc.

- **`AffirmEvents::AFFIRM_LOCALE`** (`commerce_affirm.locale`) — dispatched with
  `AffirmLocaleEvent($locale)` inside `Redirect::getLocale()`, seeded from the gateway's
  `default_locale` config. Subscribers call `getLocale()` / `setLocale()` to override the locale sent to
  Affirm (e.g. per current language or per order). `getLocale()` is used both for the JS settings and the
  messaging widgets.

Neither event class carries logic beyond simple getters/setters.

## Order subscriber (`EventSubscriber/OrderSubscriber.php`)

Service `commerce_affirm.order_subscriber` (constructor arg: `entity_type.manager`). Subscribes to
`commerce_order.place.post_transition` at priority **-20** (runs late, after placement).

`onOrderPlaced()`:

1. Bails unless the order's payment gateway plugin is the Affirm `Redirect` plugin.
2. Loads the order's payments, keeps only the ones belonging to this Affirm gateway, takes the first.
3. Calls `Redirect::updatePayment($order, $payment)`, which sends an `update` request to Affirm with the
   Drupal **order number** as `order_id` — so the finalized Drupal order number is written back onto the
   Affirm charge once the order is actually placed (the charge was created earlier keyed only by the
   checkout token / remote id).

This is the mechanism that reconciles the Affirm-side record with the human-readable Drupal order number
after checkout completes.
