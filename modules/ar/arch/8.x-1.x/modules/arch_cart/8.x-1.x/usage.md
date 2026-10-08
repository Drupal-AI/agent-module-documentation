<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Cart gives the storefront a session-backed shopping cart: customers collect products in a Cart object, manage it through a small JSON `/api/cart` API and a mini-cart block, and review it on the `/cart` page before checking out.

---

`arch_cart` provides the `arch_cart_handler` service (`CartHandler`) which loads/creates the current visitor's `Cart` from a `PrivateTempStore` (`private.cart_store`, 7-day expiry) and exposes it as a lightweight cart-line model plus a linked draft `order` entity. Line items are stored as `{type, id, quantity}`; product prices and cart totals are **always recomputed server-side** from each product's `getActivePrice()` (VAT-aware via `arch_price`), never from client input. The JSON API (`ApiController`, routes under `/api/cart`) supports reading the cart (`GET /api/cart`), adding an item (`POST /api/cart/add`), changing quantity (`POST /api/cart/quantity`) and removing an item (`POST /api/cart/remove`); each method enforces its HTTP verb (405 otherwise) and returns the rebuilt cart with formatted net/gross prices and a `do` list of UI actions. A `MiniCartBlock` (`arch_cart_mini_cart`) renders the header cart with per-bundle image-source/style settings, and `CartController` renders the `/cart` page (a `CartForm`). `CartConfigForm` at `/admin/store/settings/cart` stores two options in `arch_cart.settings`: `combine_items` (merge duplicate products on add) and `ajax_addtocart`. A `LoginRequestEventSubscriber` migrates the anonymous cart across login. JS libraries (`api-request`, `add-to-api-cart`, `api-cart`) drive the AJAX add-to-cart and mini-cart UI. The module depends on `arch_price`, `arch_product`, `arch_order` and `arch_checkout`.

---

- Add a product to the cart from a product page or listing (AJAX or POST).
- Show a persistent mini-cart in the site header.
- Let customers change item quantities without a full page reload.
- Let customers remove items from the cart.
- Show a full `/cart` review page before checkout.
- Persist a visitor's cart for up to 7 days via PrivateTempStore.
- Carry an anonymous cart over to the account on login.
- Combine duplicate product lines into one on add (`combine_items`).
- Toggle AJAX add-to-cart behavior site-wide (`ajax_addtocart`).
- Expose cart state to a decoupled/JS frontend through the `/api/cart` JSON endpoints.
- Return formatted net and gross totals (VAT-aware) for the current cart.
- Drive a headless "add to cart" button from custom JavaScript.
- Render per-product-bundle cart thumbnails using a configured image field + image style.
- Recompute all prices server-side from the product catalog (no client-trusted prices).
- Feed the linked draft order that checkout turns into a real order.
- Alter cart API output from custom code via the `api_cart_data` alter hook.
- Alter cart total base values via the `cart_total_base_values` alter hook.
- Provide the cart the checkout and onepage submodules read from.
- Configure cart behavior at Store → Settings → Cart settings.
