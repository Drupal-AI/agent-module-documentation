<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncart services

Declared in `syncart.services.yml`.

## `syncart.cart` — `Service\SynCartService` (implements `SynCartServiceInterface`)
The cart write layer over `commerce_cart.cart_provider`. Key methods:
- `load()` / `getCurrentCart()` — the current session's cart for the module's order type
  (`getOrderType()`), creating one via `createCart()` against store `STORE_ID` and `current_user`.
- `addToCart(['vid','quantity','selected_products'])` — loads the variation, adds/updates an order item.
- `addOrderItem(OrderInterface $order)` — copies items from another order into the current cart (repeat order).
- `setOrderItemQuantity($order_item_id, $quantity)`, `removeOrderItem($item_id)`,
  `setOrderItemNote($item_id, $note)` — line-item mutations, resolved by loading the order item by id.
- `getOrderItemStock($vid)` — on-hand stock lookup; `isEmpty()`; `updateUserRegister($bool)`.

## `syncart.render` — `Service\SynRenderService` (implements `SynRenderServiceInterface`)
Builds the cart JSON payload consumed by the controllers.
- `data(int|false $cid = FALSE, array $render = [])` — returns `{id, qitems, quantity, price,
  subtotal, total, full_price, promotion, promosum, number, note, items…}`. Items come from
  `getVariationInfo()` (variation id/name/image/price/adjustments, optional per-item note, `uname`).
- `getCart($cid)` (private) — resolves which order to render: with no `$cid`, the current session cart;
  with a `$cid`, it is matched against `cartProvider->getCarts()`.
- Formats prices through `commerce_price` `CurrencyFormatter` and inline `commerce_price_format` templates.

## Other services
- `syncart.checkout` — `Service\CheckoutLink`: `generateUrl(OrderInterface)` builds the
  `/cart/checkout-link/{order}/{timestamp}/{hash}` URL; `generateHash($timestamp, $order, $use_changed)`
  produces the HMAC-style hash the controller checks with `hash_equals()`.
- `syncart.admin` — `Service\AdminService`: order types + number-pattern pattern/sequence/initial lookups
  and `resetNumberPatternSequence()`.
- `syncart.product` — `Service\ProductService`: product/variation helpers used by rendering.
- `syncart.install` — `Service\InstallService`: `updateOrInstallAdditionalConfig()` used by `hook_install`.

## Plugins, hooks, events
- `Plugin\Block\CartBlock` — themed cart block.
- `Plugin\Commerce\CheckoutPane\SyncartFinalize` — checkout finalize pane.
- `Routing\RouteSubscriber` — route alterations.
- `EventSubscriber\OrderCompleteSubscriber` — sends the receipt on order completion.
- `Hook\*` classes wired from `syncart.module` (presave for order/product/variation, several
  preprocess hooks, page attachments, and login/variation/checkout form alters).
