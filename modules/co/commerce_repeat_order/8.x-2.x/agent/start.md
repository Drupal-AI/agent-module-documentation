<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Repeat Order (commerce_repeat_order) — agent index

Rebuilds a customer's **cart from one of their own past Commerce orders** via a single route.
Version **8.x-2.4**. Core `^9 || ^10 || ^11`. Package `Commerce`. License GPL-2.0-or-later.
Depends on `commerce` and `commerce_cart` (from the Commerce project). No composer.json ships.

- **The reorder route + controller, ownership check, cart rebuild, config, permissions** →
  [api/repeat-order.md](api/repeat-order.md)

## What it actually is (from source)

- **One controller**: `Drupal\commerce_repeat_order\Controller\CommerceRepeatOrder::repeatOrder()`
  (`src/Controller/CommerceRepeatOrder.php`). Services injected: `commerce_cart.cart_manager`,
  `commerce_cart.cart_provider`, `messenger`, `event_dispatcher`.
- **Two routes** (`commerce_repeat_order.routing.yml`):
  - `commerce_repeat_order.repeat_order` — `GET /commerce-repeat-order/{commerce_order}`,
    param upcast to `entity:commerce_order`, requirement `_permission: 'view own commerce_order'`.
    The action itself is state-changing (modifies the cart) and redirects to `commerce_cart.page`.
  - `commerce_repeat_order.settings_form` — `/admin/commerce/config/order/repeat-order`,
    requirement `_permission: 'commerce repeat order admin access'`.
- **One settings form**: `Form\CommerceRepeatOrderSettingsForm` (config `commerce_repeat_order.settings`,
  keys `add_or_override` = `add`|`override`, `status_message` = `show`|`hide`).
- **One event**: `Event\OrderCloneEvent` (constant `ORDER_CLONED = 'commerce_repeat_order.order_cloned'`),
  dispatched once per copied item with `getOriginal()` / `getNew()`.
- **One permission** declared: `commerce repeat order admin access` (guards only the settings form).
  The reorder route reuses Commerce's own `view own commerce_order` permission.
- No entities, plugins, fields, widgets, hooks, Drush, `config/install`, or `config/schema`.
  `provides_config_schema` is **false** — the `commerce_repeat_order.settings` object has no schema
  and no install defaults.

## Mechanism in one paragraph

`repeatOrder(Order $commerce_order)` compares `currentUser()->id()` to
`$order->getCustomerId()`; only if they are equal (and the order uid is non-empty) does it proceed,
otherwise it sets an error and redirects. It gets/creates the `default` cart for the order's store,
empties it first when config is `override`, then for each order item whose purchased product is
**published** it calls `$order_item->createDuplicate()` (resetting ids + `enforceIsNew()`), saves
it, and `cartManager->addOrderItem($cart, $new)`. Unavailable items are skipped (optional status
message). Redirects to the cart page. Details, config, and operating notes in
[api/repeat-order.md](api/repeat-order.md).
