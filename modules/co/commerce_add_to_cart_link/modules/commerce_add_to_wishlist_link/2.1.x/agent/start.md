<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce add to wishlist link — agent index

Wishlist twin of Commerce Add To Cart Link: renders an add-to-**wishlist** link
(GET `/add-to-wishlist/{product}/{variation}/{token}`) instead of a form. Requires
`commerce_add_to_cart_link` **and** `commerce_wishlist`. No settings form, no config of its
own (`configure: null`) — it reuses the parent's `commerce_add_to_cart_link.settings` and the
shared `commerce_add_to_cart_link.token` service. Unlike the parent it ships **no** Views field.

- **Enable the link (pseudo field `add_to_wishlist_link` on view displays); shared settings**
  → [configure/display.md](configure/display.md)
- **Route, `AddToWishlistController`, `AddToWishlistLink` (extends `AddToCartLink`), shared token**
  → [api/link-controller.md](api/link-controller.md)

Parent module: [Commerce Add To Cart Link](../../../../2.1.x/agent/start.md)

Key facts: pseudo field id **`add_to_wishlist_link`** (hidden by default) on
`commerce_product` and `commerce_product_variation` displays. Route requires the
`access wishlist` permission. CSRF protection & `redirect_back` come from the **parent's**
`commerce_add_to_cart_link.settings` (`csrf_token.roles`, `redirect_back`).
