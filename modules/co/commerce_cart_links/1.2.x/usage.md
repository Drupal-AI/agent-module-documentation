<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Cart Links lets a URL add one or more products to a Drupal Commerce cart (optionally emptying/deleting the existing cart, applying a coupon, and redirecting), plus a "Share cart" button that generates such a link for the current cart.

---

The module registers one processing route, `commerce_cart_links.process_cart_links` at `/cart-links`, whose `_controller` is `CartLinksController::processCartLinks`. Because a route can't take an arbitrary number of path arguments, an inbound path processor (`CartLinksPathProcessor`, priority 200) rewrites `/cart-links/57-2/384-1` into a `products[]` query array and forwards to `/cart-links`. Each product segment is parsed by `getProductPartsFromUrl()` as `entityId-quantity[-entityType]` (split on `-`). Access is a `_custom_access` check, `CartLinksController::checkAccess`, that AND-combines three conditions: `validateQueryParams()` (each product's entity id and quantity must be non-empty integers; any per-product `entityType`, and a `default_entity_type` query param, must be a registered purchasable entity type per `commerce.purchasable_entity_type_repository`; `existing`, if present, must be one of `new`/`empty`/`delete`), `validateRefererUrl()` (matches the request `referer` host against the admin `allowlist_urls` list via `path.matcher`; an empty allowlist allows any referer, and a missing referer is allowed unless `require_referer_url` is on), and the `view commerce cart links` permission. `prepareOrderItems()` then loads each purchasable entity (default entity type `commerce_product_variation`), builds order items via `commerce_cart.cart_manager`, groups them by the resolved order type, validates each order item and drops any with constraint violations (surfacing the message). Prices are taken from the loaded entities — the URL never carries a price or adjustment. The `existing` param selects the cart strategy: `new` always creates a fresh cart (and, for anonymous users, registers the new cart id in `commerce_cart.cart_session`), `empty` empties the resolved cart first, `delete` deletes existing cart(s) first, and absent it adds to whatever cart `commerce_cart.cart_provider` resolves. `store=#` forces a specific `commerce_store`; `coupon_code=#` is validated against enabled, applicable `commerce_promotion_coupon`s before being appended. Finally it issues a `RedirectResponse` to the `destination` query param (routed through `Url::fromUserInput()` with a forced leading slash) or to `commerce_cart.page`. Configuration lives in `commerce_cart_links.settings` (`allowlist_urls`, `require_referer_url`), edited at `/admin/commerce/config/orders/cart-links` behind `administer commerce_cart_links` (restricted). Separately, the "Share cart" feature — a Views area plugin `commerce_cart_links_share_cart_button` (exposed on `commerce_order` via `hook_views_data_alter`) opening an AJAX modal (`ShareCartModalController`), backed by the `commerce_cart_links.cart_links_builder` service (`CartLinksBuilder::buildUrl`) — turns the current cart into a `/cart-links/...?existing=empty` URL; its access requires the order to be one of the current user's carts plus the `generate cart share links` permission. A route subscriber disables route normalization when the `redirect` module is present (which would otherwise 403 the multi-segment path).

---

- Add a specific product variation and quantity to the cart from a link: `/cart-links/57-2`.
- Add several products at once: `/cart-links/57-2/384-1`.
- Send an ad/campaign link (e.g. Google Merchant Center) that lands the advertised product in the cart.
- Put an "add to cart" URL in a marketing email so recipients arrive with items pre-loaded.
- Encode a re-order link (a QR code / SMS) that rebuilds a known set of products.
- Empty the customer's existing cart before adding the link's products: append `?existing=empty`.
- Force a brand-new cart without touching the customer's other carts: `?existing=new`.
- Delete the customer's existing cart(s) so a new one is always created: `?existing=delete`.
- Add to whatever cart already exists (default when `existing` is omitted).
- Auto-apply a promotion coupon when the products are added: `?coupon_code=SUMMER25`.
- Redirect the shopper to a landing/checkout page after processing: `?destination=/checkout`.
- Default to the cart page after processing when no `destination` is given.
- Target a specific store on a multi-store site: `?store=2`.
- Add a purchasable entity that is not a product variation by overriding the default type: `?default_entity_type=commerce_product` or a per-item third segment `/cart-links/57-2-commerce_product_variation`.
- Give shoppers a "Share cart" button in a cart view that produces a copyable link to their cart.
- Let a customer send their built-up cart to a friend or another device via the shared link.
- Restrict which referring domains may trigger cart links by configuring the referer allowlist.
- Require a referer to be present before any cart link is processed (`require_referer_url`).
- Build a punchout-style flow where an external catalog hands off to Commerce with a pre-filled cart.
- Generate cart links programmatically from an order with the `CartLinksBuilder` service.
- Combine cart-strategy and coupon params for a promo drop: `/cart-links/57-1?existing=empty&coupon_code=WELCOME`.
- Add a large quantity of one item in a single click for wholesale/bulk reorder links.
- Keep cart links working alongside the `redirect` module (normalization is auto-disabled for the route).
