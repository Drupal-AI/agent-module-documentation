<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cart (arch_cart) — agent index

Session-backed shopping cart for the Arch suite. Depends on `arch_price`, `arch_product`,
`arch_order`, `arch_checkout`. Part of project `arch` (`8.x-1.0-alpha26`).

- **The `/api/cart` JSON API, the Cart model & mini-cart** → [api/cart.md](api/cart.md)

## Provides

- Service **`arch_cart_handler`** (`Cart\CartHandler`) → `getCart()` returns the current
  `Cart\Cart` (`CartInterface`), backed by `private.cart_store` (`PrivateTempStoreFactory`,
  `cartstore.expire = 604800` s). Also `arch_cart.request_subscriber`
  (`LoginRequestEventSubscriber`) to carry the cart across login.
- Routes (`arch_cart.routing.yml`):
  - `arch_cart.content` `/cart` — `CartController::content` (custom access `_access_arch_cart` →
    `CartAccessCheck`, needs `access content`).
  - `arch_cart.settings` `/admin/store/settings/cart` — `CartConfigForm`
    (perm `administer cart settings`).
  - `arch_cart.api.cart` `GET /api/cart`, `arch_cart.api.cart_add` `POST /api/cart/add`,
    `arch_cart.api.cart_quantity` `POST /api/cart/quantity`, `arch_cart.api.cart_remove`
    `POST /api/cart/remove` — all `_permission: access content`, handler `Controller\Api\ApiController`.
- Block **`arch_cart_mini_cart`** (`Plugin\Block\MiniCartBlock`).
- Permission **`administer cart settings`** (`restrict access: true`).
- Config object **`arch_cart.settings`** (`combine_items` bool, `ajax_addtocart` bool); schema
  `arch_cart.schema.yml`.
- Interface `CartPluginInterface` (no plugin manager — plain interface).
- JS libraries: `api-request`, `add-to-api-cart`, `api-cart` (+ `arch/underscorejs`).

## Key behavior

- `Cart` line items are `{type:'product', id, quantity}`. `ApiController` reads `id`/`quantity`
  from the request but **prices come from `Product::getActivePrice()`**, so totals are
  server-computed (`totalPrice()`, `buildCart()`), not client-supplied.
- `CartConfigForm.combine_items` merges duplicate product lines on add.
