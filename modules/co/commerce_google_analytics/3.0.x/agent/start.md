<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Google Analytics — agent start

Sends **Google Analytics e-commerce (transaction) tracking** for a Drupal Commerce order when the
order is **placed**. Version **3.0.1**, core `^10 || ^11`. Depends on `commerce_order` and
`ga_push`. No routes, no forms, no permissions, no config, no JS, no templates — the whole module
is one event subscriber.

## How it works (from source)

- `src/EventSubscriber/SendOrderAnalyticsSubscriber.php` subscribes to
  `commerce_order.place.post_transition` (a `state_machine` `WorkflowTransitionEvent`) at
  priority **-100**, method `sendOrderAnalytics()`. This fires once, when an order transitions
  into the *placed* state (checkout completion) — it does **not** track product views,
  add-to-cart, or per-step checkout events.
- `buildGaPushParams(OrderInterface $order): array` assembles the payload:
  - **`trans`** (transaction): `order_id` (order number), `affiliation` (store label), `total`
    (`$order->getTotalPrice()->getNumber()`), `currency`, `total_tax` (hard-coded `0` — see the
    `@todo` at line 83), `total_shipping` (summed `shipping`-type adjustments, only when
    `commerce_shipping` is enabled), and billing-address `city` / `region` / `country` taken from
    the order's billing profile `address` field (empty strings when there is no billing profile).
  - **`items`**: one entry per order item — `order_id`, `sku`, `name` (item title), `category`,
    `price` (adjusted unit price number), `currency`, `quantity`. For a
    `ProductVariationInterface` purchased entity, `sku` becomes the variation SKU and `category`
    becomes `"Product: {bundle}"`; otherwise `sku` falls back to the order-item entity id and
    `category` is `ucfirst(bundle)`.
- The payload is handed to **`ga_push_add_ecommerce($ga_push_params)`** (a procedural function
  from the `ga_push` module). This module does not talk to Google directly — transport (server-side
  PHP-GA library vs. client-side dataLayer), the GA property/account, and any consent gating are
  all owned by **`ga_push`** and its configuration.
- Wiring: `commerce_google_analytics.services.yml` registers the subscriber with
  `@module_handler` injected; it uses the module handler to (a) conditionally sum shipping and
  (b) invoke the alter hooks below.

## Extending it (alter hooks)

Defined/documented in `commerce_google_analytics.api.php`, invoked via `moduleHandler->alter()`:

- `hook_commerce_google_analytics_transaction_alter(&$transaction, $context)` — `$context['order']`.
- `hook_commerce_google_analytics_item_alter(&$item, OrderItemInterface $order_item, $context)` —
  `$context` has `transaction` + `order`. Emptying `$item` drops that item from the payload.
- `hook_commerce_google_analytics_items_alter(&$items, $context)` — final items array;
  `$context` has `transaction` + `order`.

See [hooks.md](hooks.md) for signatures and examples.

## Notes / gotchas

- **Requires `ga_push`.** With `ga_push` absent/misconfigured the call to
  `ga_push_add_ecommerce()` is a no-op (or fatal if the function is missing) — nothing reaches GA.
  Configure GA Push (recommended: PHP-GA / UTMP-PHP for reliable server-side sends) before relying
  on data.
- **No Rules integration in 3.0.x.** Older 7.x branches used Rules; the 3.0.x branch is purely the
  `commerce_order.place` event subscriber. Ignore Rules references in legacy project text.
- **Tax is always `0`** (`total_tax` is a hard-coded placeholder, `@todo`).
- **Billing geo (city/region/country)** from the order's billing profile is included in the
  transaction payload sent onward to GA via `ga_push` — a privacy/consent consideration for any
  analytics deployment; wire consent/disclosure at the `ga_push` layer.
- No config schema shipped despite any older metadata; the module is configuration-free.
