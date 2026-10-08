<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The /cart-links URL contract

Route `commerce_cart_links.process_cart_links` → path `/cart-links` →
`CartLinksController::processCartLinks`. Multi-segment paths reach it through
`CartLinksPathProcessor` (inbound path processor, priority 200), which strips `/cart-links/`,
`explode('/')`s the rest into `products[]`, and forwards to `/cart-links`.

## Path: products
```
/cart-links/{entityId-quantity[-entityType]}[/{...}]
```
- `getProductPartsFromUrl()` splits each segment on `-`: `parts[0]=entity_id`, `parts[1]=quantity`,
  `parts[2]=entity_type` (optional).
- Both id and quantity must be non-empty integers or access is denied
  (`validateQueryParams()`; `intval` + `is_int`). Because `-` is the delimiter, a negative quantity
  cannot be expressed. There is no explicit upper bound on quantity beyond order-item validation.
- Each entity is loaded from its storage; if it doesn't load it is silently skipped. Prices and the
  order type are resolved server-side from the loaded purchasable entity — the URL never carries a
  price or adjustment.
- At least one valid product is required (`valid_products` is `FALSE` when `products` is empty).

## Query parameters
| Param | Values | Effect |
|-------|--------|--------|
| `existing` | `new` \| `empty` \| `delete` \| (omitted) | Cart strategy — see below. Any other value fails access validation. |
| `store` | store id | Force a specific `commerce_store` when resolving/creating the cart. |
| `default_entity_type` | purchasable entity type id | Override the default `commerce_product_variation` for segments without a third part. Must be a registered purchasable entity type. |
| (per-item 3rd segment) | purchasable entity type id | Same, but for a single product segment. Validated the same way. |
| `coupon_code` | coupon code | Applied after items are added, via `validateCouponCode()`. |
| `destination` | path | Post-processing redirect target (see below). |

### `existing` strategies
- **omitted** — add items to whatever cart `commerce_cart.cart_provider` resolves (creating one if
  none).
- **`new`** — always create a fresh cart order; for anonymous users the new cart id is registered in
  `commerce_cart.cart_session` so it is picked up on the next page load.
- **`empty`** — empty the resolved cart (`cartManager->emptyCart`) before adding.
- **`delete`** — delete the existing cart(s) and clear caches, then create a new cart.

### Redirect (`destination`)
`getRedirectUrl()` forces a leading `/` (if absent) and calls `Url::fromUserInput($destination)`;
absent `destination`, it redirects to route `commerce_cart.page`. External/protocol-relative inputs
are handled by core `Url` (no external redirect is produced).

### Coupons (`coupon_code`)
`validateCouponCode()` loads an enabled `commerce_promotion_coupon` by code, refuses duplicates and
already-applied non-stackable promotions, and requires `available()` + `applies()` before appending
to the cart's `coupons` field.

## Referer / access
Every request is also subject to `validateRefererUrl()` and the `view commerce cart links`
permission — see [../config/settings.md](../config/settings.md). If the `redirect` module is
enabled, `CartLinksRouteSubscriber` sets `_disable_route_normalizer` on this route so the
multi-segment path is not normalized into a 403.

## Programmatic building
`commerce_cart_links.cart_links_builder` (`CartLinksBuilder::buildUrl(OrderInterface $order)`)
returns an absolute `Url` of the form `/cart-links/{id-qty}/...?existing=empty` for an order's items
— see [../extend/share-cart.md](../extend/share-cart.md).
