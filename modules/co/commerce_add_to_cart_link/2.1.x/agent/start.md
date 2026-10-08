<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Add To Cart Link — agent index

Replaces the Commerce add-to-cart **form** with a **link** (GET `/add-to-cart/{product}/{variation}/{token}`)
for listings, blocks and AJAX views. Depends on `commerce_cart` + `commerce_product`.
Defines no plugin type. Config entity: `commerce_add_to_cart_link.settings`.
Configure route: `commerce_add_to_cart_link.settings`
(`/admin/commerce/config/add-to-cart-link`).

- **Enable the link (pseudo field on view displays), the Views field, and the settings form
  keys** → [configure/display-and-settings.md](configure/display-and-settings.md)
- **Route, controller behaviour, `AddToCartLink` helper, `CartLinkToken` service, AJAX event**
  → [api/link-token-controller.md](api/link-token-controller.md)
- **Twig template & theme suggestions (customise markup / enable `use-ajax`)**
  → [theming/template.md](theming/template.md)

Submodule (mirrors everything for Commerce Wishlist, needs `commerce_wishlist`):
[Commerce add to wishlist link](../../modules/commerce_add_to_wishlist_link/2.1.x/agent/start.md)

Key facts: the pseudo field id is **`add_to_cart_link`** on both `commerce_product` and
`commerce_product_variation` displays (hidden by default). Settings: `csrf_token.roles`
(sequence of role ids to protect with a token) and `redirect_back` (bool). Token service id
`commerce_add_to_cart_link.token`.
