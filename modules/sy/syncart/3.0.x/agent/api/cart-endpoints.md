<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncart cart, favorites & checkout-link endpoints

All routes are in `syncart.routing.yml`. Cart mutation endpoints take a JSON request body
(`Json::decode($request->getContent())`) and return the current cart as JSON via
`SynRenderService::data()`. Storefront endpoints require `access content`; admin endpoints
require `administer commerce_order`.

## Read
- `GET /api/cart-load` and `GET /api/cart-load/{cid}` → `CartApiController::loadCart($cid)`.
  Returns `renderer->data($cid)`. `{cid}` is normalized with `ctype_digit` to an int.
- `GET /syncart/cart` → `CartApiController::cart()` (themed `syncart-cart`, `max-age 0`).
- `GET /syncart/debug` → `CartApiController::debug()` (perm `administer commerce_order`).

## Mutate (POST, `access content`)
- `POST /cart/add-item` → `CartController::addToCart()`. Body `{vid:int, quantity:string,
  selected_products?}`. If `syncart.settings.donation` is on, the body's `donation` (int) amount is
  used: `getRightVariation()` finds an existing variation of the product at that price, else
  `createVariation()` creates and saves one at the submitted amount. Otherwise `SynCartService::addToCart()`.
- `POST /cart/add-items` → `addToCartMultiple()`. Body `{vids:int[]}`, quantity 1 each.
- `POST /cart/set-variation-quantity` → `setVariationQuantity()` → `SynCartService::addToCart($params)`.
- `POST /cart/set-order-item-quantity` → `setOrderItemQuantity()`. Body `{item_id:int, quantity:numeric}`;
  quantity is `number_format(...,2)` then `SynCartService::setOrderItemQuantity()`.
- `POST /cart/set-item-note` → `setItemNote()`. Body `{itemId:int, note:string}` →
  `SynCartService::setOrderItemNote()`.
- `POST /cart/remove-cart-item` → `removeFromCart()`. Body `{item_id:int}` →
  `SynCartService::removeOrderItem()`, then redirect to `syncart.cart_controller_cart`.
- `POST /cart/refresh-stock` → `refreshStock()`. Body `{items:{<order_item_id>:{vid:int}}}` →
  per-item `SynCartService::getOrderItemStock()`.
- `GET /syncart/checkout` → `CartController::checkout()`: redirects the current cart into
  `commerce_checkout.form` at step `order_information`.
- `GET /cart-repeat-order/{commerce_order}` → `repeatOrder()`: copies a prior order's items into the
  current cart via `SynCartService::addOrderItem()`.

## Favorites (wishlist)
- `GET /favorites` → `FavoriteController::favoritesPage()` (themed `syncart-favorites`, cache killed).
  Product IDs come from the browser `favorites` cookie (`Json::decode`, `array_keys`); products are
  loaded and rendered as `teaser`, with a combined variation price.

## Checkout link
- `GET /admin/commerce/orders/{commerce_order}/checkout-link` → `CheckoutLinkController::admin()`
  (perm `administer commerce_order`): prints the absolute resume URL from `CheckoutLink::generateUrl()`.
- `GET /cart/checkout-link/{commerce_order}/{timestamp}/{hash}` → `CheckoutLinkController::checkout()`.
  Validates a 24h timeout (`hook_commerce_checkout_link_timeout_alter`) and `hash_equals()` against
  `CheckoutLink::generateHash()` (respecting `commerce_checkout_link.settings.use_changed_timestamp`),
  clears other carts, assigns the order to the current user (`commerce_order.order_assignment`), and
  redirects to `commerce_checkout.form`. A `CheckoutLinkEvent` allows altering the redirect URL.
