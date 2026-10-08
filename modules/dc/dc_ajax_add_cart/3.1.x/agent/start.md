<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce AJAX Add to Cart — agent index

Ajaxifies Commerce add-to-cart: adds the product and refreshes the cart block + status messages
without a page reload. No settings page (`configure` null), no permissions, no Drush. Depends on
`commerce_product` + `commerce_cart` (Commerce ^2.4 || ^3).

- **Turning it on (the `dc_ajax_add_cart` formatter, the order-item form mode, formatter settings)
  and how the AJAX round-trip is wired** → [configure/setup.md](configure/setup.md)
- **The `RefreshPageElementsHelper` service for building cart-refreshing AJAX responses in custom
  code** → [api/refresh-helper.md](api/refresh-helper.md)

Submodules (own docs):
- `dc_ajax_add_cart_popup` → [../../modules/dc_ajax_add_cart_popup/3.1.x/agent/start.md](../../modules/dc_ajax_add_cart_popup/3.1.x/agent/start.md)
- `dc_ajax_add_cart_views` → [../../modules/dc_ajax_add_cart_views/3.1.x/agent/start.md](../../modules/dc_ajax_add_cart_views/3.1.x/agent/start.md)

Key facts:
- Field formatter id `dc_ajax_add_cart` (`AjaxAddToCartFormatter extends AddToCartFormatter`),
  set on a product type's **Variations** display. Reuses settings `show_quantity`,
  `default_quantity`, `combine`.
- Order-item form mode `dc_ajax_add_cart` → form class `AjaxAddToCartForm` (registered via
  `hook_entity_type_build`). Submit button gets `use-ajax-submit`; AJAX callback
  `refreshAddToCartForm` returns the helper's `AjaxResponse`.
- Lazy builder `dc_ajax_add_cart.lazy_builders:ajaxAddToCartForm` (`ProductLazyBuilders`,
  `TrustedCallbackInterface`) builds the form per product/default variation.
- Service `dc_ajax_add_cart.refresh_page_elements_helper` refreshes build id + status messages
  block + `.cart--cart-block`.
