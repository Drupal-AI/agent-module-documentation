<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Cart: the Cart model and `/api/cart` JSON API

## The Cart object

`arch_cart_handler` (`CartHandler`) `->getCart()` returns a `Cart` (`Cart\CartInterface`) held in a
`PrivateTempStore` (`private.cart_store`, 7-day TTL). It stores line items as arrays
`{type: 'product', id, quantity}` and lazily exposes a linked draft `order` entity
(`$cart->getOrder()`), which checkout finalizes. Totals (`getTotalPrice()`, `getGrandTotal()`,
`getShippingPrice()`) are computed from product prices via `arch_price`, so the cart never trusts a
client-sent price. `LoginRequestEventSubscriber` moves the anonymous cart into the logged-in
account.

## JSON API — `ApiController`

All four routes require `_permission: 'access content'` and enforce their HTTP method (wrong verb →
`405`). Responses are `JsonResponse`.

| Route | Method | Path | Method on controller |
|---|---|---|---|
| `arch_cart.api.cart` | GET | `/api/cart` | `cart()` |
| `arch_cart.api.cart_add` | POST | `/api/cart/add` | `addItem()` |
| `arch_cart.api.cart_quantity` | POST | `/api/cart/quantity` | `quantity()` |
| `arch_cart.api.cart_remove` | POST | `/api/cart/remove` | `removeItem()` |

### add

Body: `id` (product id), `quantity` (cast to `float`). `loadProduct($id)` must resolve an existing
`product` entity (else `400 Invalid product id`). On success the item is added
(`Cart::addItem`) and the rebuilt cart is returned with `do: ['update_cart','show_cart']`.

### quantity / remove

Body: either `type` + `id`, or a line `key`. `quantity()` calls
`updateItemQuantityById()`/`updateItemQuantity()` (a not-found code `1001` falls back to adding the
item); `removeItem()` calls `removeItemById()`/`removeItem()`. Errors return `400` with the
exception message.

### Response shape (`buildCart()`)

```json
{
  "cart": {
    "items": [ /* per-line: product_id, title, url, quantity,
                  net_price/net_total/price/total {raw, formatted}, image */ ],
    "products": 2,
    "quantity": 3,
    "total":     { "raw": 0, "formatted": "…" },   // gross
    "net_total": { "raw": 0, "formatted": "…" },
    "messages": []
  },
  "error": false,
  "messages": []
}
```

Every price is re-derived from `Product::getActivePrice()` and formatted via `price_formatter`
(net and gross). Alter hooks: `cart_total_base_values` (base totals) and `api_cart_data` (final
payload). Missing products are silently dropped from the cart during rebuild.

## Mini-cart block

`MiniCartBlock` (`arch_cart_mini_cart`) renders the header cart. Per product bundle it can be
configured with an `image_source` (`field:subfield`, image or media-reference field) and an
`image_style` (default `thumbnail`); `ApiController::getProductImageFile()` resolves the file and
`showImage()` renders it. JS: attach `arch_cart/api-cart` (+ `add-to-api-cart`) to wire the UI to
the endpoints above.

## Settings

`CartConfigForm` (`/admin/store/settings/cart`, perm `administer cart settings`) writes
`arch_cart.settings`:

- `combine_items` (bool, default `true`) — merge duplicate product lines on add.
- `ajax_addtocart` (bool, default `false`) — AJAX vs. plain add-to-cart form.
