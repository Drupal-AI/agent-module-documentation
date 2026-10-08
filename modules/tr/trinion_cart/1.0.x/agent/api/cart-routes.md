<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trinion cart — routes & access

All cart state lives in a `zakaz_klienta` node with `field_tc_status_korziny = cart`, resolved
per request by uid (authenticated) or `field_tc_sid` = session id (anonymous).

## Mutating routes
| Path | Controller | Access requirement |
|------|-----------|--------------------|
| `/cart/add/{nid}` | CartController::cartButton | `_add_to_cart_one` (bundle is a configured product; NO permission) |
| `/cart/fast-checkout/{nid}` | fastCheckout | `_add_to_cart_one` |
| `/cart/delete/{nid}` | deleteItem | `_remove_from_cart` (nid must be in current cart) |
| `/cart/clear` | clearCart | `access content` |
| `/cart/recalculate` | cartRecalculate | `access content` (reads `data[]` qty from request) |
| `/cart/coupon/apply/{coupon}` | addCoupon | `access content` |
| `/cart/coupon/remove/{coupon}` | removeCoupon | `access content` |
| `/cart/coupon/activate/{coupon}/{op}` | activateCoupon | `access content` |
| `/cart/checkout` | CheckoutForm | `_checkout` (cart not empty) |
| `/cart/success` | successPage | `access content` |

## Security review notes
- **Anonymous mutation:** `access content` is granted to anonymous by default, and add-to-cart
  requires no permission at all — anonymous visitors can create order nodes and mutate cart
  contents. `addToCart()` bails only when `HTTP_REFERER` is empty.
- **Coupons by title:** `getCouponByName()` loads a `kupon` node by `title`; anyone who knows/guesses
  a coupon code can apply its discount (`applyCoupon`/`activateCoupon` take the value from the URL).
- **Client-driven quantities:** `cartRecalculate()` applies `data[]['qty']` from the request with the
  `=` op — no server-side clamp, so arbitrary (incl. non-positive) quantities can be set.
- **Not a cross-user IDOR:** the cart is always re-loaded for the current uid/session, so a visitor
  cannot address another user's cart via these routes.

## Configuration
`/admin/config/system/trinion-store` (`administer trinion_cart configuration`) sets
`default_responsible` and `company_nid` used when a new cart order node is created.
