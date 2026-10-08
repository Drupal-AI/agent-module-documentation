<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Links (commerce_cart_links) — agent index

A URL that manipulates a Drupal Commerce cart. `/cart-links/57-2/384-1` adds 2 of purchasable
entity 57 and 1 of 384, then redirects. Query params control cart strategy, store, entity type,
coupon and redirect. Also ships a "Share cart" button/modal that generates such a link for the
current cart. Depends on `commerce:commerce_cart`. Configure at
`/admin/commerce/config/orders/cart-links`. Core `^9 || ^10 || ^11` (installed 1.2.0).

## What you'd do → where
- **The `/cart-links` URL grammar and every query parameter (`products`, `existing`, `store`,
  `default_entity_type`, per-item entity type, `coupon_code`, `destination`)** →
  [api/url-format.md](api/url-format.md)
- **Referer allowlist and the two settings, admin form/permission** →
  [config/settings.md](config/settings.md)
- **"Share cart" button (Views area), the modal, and the `CartLinksBuilder` service** →
  [extend/share-cart.md](extend/share-cart.md)

## Key facts (real names)
- Route `commerce_cart_links.process_cart_links` → `/cart-links` →
  `CartLinksController::processCartLinks`. `_custom_access` = `CartLinksController::checkAccess`.
- `CartLinksPathProcessor` (inbound, priority 200) rewrites `/cart-links/<segments>` into a
  `products[]` query array, then forwards to `/cart-links`.
- Product segment grammar (`getProductPartsFromUrl`): `entityId-quantity[-entityType]`, split on `-`.
  Default entity type `commerce_product_variation`.
- `checkAccess` AND-combines: `validateQueryParams()` + `validateRefererUrl()` +
  `view commerce cart links` permission.
- `existing` values: `new` (fresh cart), `empty` (empty resolved cart first), `delete` (delete
  existing cart(s) first), or omitted (add to resolved cart). Uses `commerce_cart.cart_manager` /
  `commerce_cart.cart_provider`; anonymous new carts registered via `commerce_cart.cart_session`.
- Prices/order type resolved server-side from loaded entities; URL carries only IDs, quantities,
  options. Order items are `->validate()`-checked and violating ones dropped.
- Config object `commerce_cart_links.settings`: `allowlist_urls` (string, one domain per line),
  `require_referer_url` (bool). Form `CartLinksSettings`, permission `administer commerce_cart_links`
  (`restrict access: true`).
- Permissions: `view commerce cart links`, `generate cart share links`,
  `administer commerce_cart_links`.
- Share cart: Views area `commerce_cart_links_share_cart_button` (on `commerce_order`) →
  `ShareCartModalController::modal` → service `commerce_cart_links.cart_links_builder`
  (`CartLinksBuilder::buildUrl`). Route `commerce_cart_links.share_cart_modal`.
- `CartLinksRouteSubscriber` sets `_disable_route_normalizer` when the `redirect` module is enabled.
