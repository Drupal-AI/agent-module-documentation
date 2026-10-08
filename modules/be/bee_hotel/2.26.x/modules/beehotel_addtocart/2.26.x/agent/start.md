<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEE Hotel Add to Cart (beehotel_addtocart) — agent index

Helpers to add Bee Hotel units to the **Commerce cart** programmatically. No hard deps in
info.yml. Core `^9.4 || ^10 || ^11`.

## Surface

- **Route** `beehotel_addtocart.list` — `/add/product/{productId}` (`productId: \d+`,
  perm `access content`) → `Controller\BeeHotelAddToCart::addToCart`: loads the product, gets or
  creates the cart for its store, and redirects to `commerce_cart.page`. (It does **not** itself
  add an order item.)
- **Service** `beehotel_addtocart.addtocart` (`AddToCart`) — scaffold wired with cart
  manager/provider + ETM + config; `add()` is a stub.
- **Hook** `beehotel_addtocart_preprocess_status_messages()` hides the "added to cart" status
  message when the current flow (`session beehotel_data.from`) is one of Bee Hotel's own forms
  (`bee_hotel_hide_message_from_these_forms()`).

Minimal module — no solution subpages.
