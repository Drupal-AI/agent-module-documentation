<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes Drupal Commerce's "Add to cart" work over AJAX: the product is added and the cart block and status messages refresh in place, with no full page reload. Provides the AJAX add-to-cart form as a product-variation display formatter, plus optional popup and Views submodules.

---

The module adds a `dc_ajax_add_cart` field formatter (extends Commerce's `AddToCartFormatter`)
that you select for the **Variations** field on a product type's display; it swaps the standard
add-to-cart form's `#lazy_builder` for its own so the form is built by
`ProductLazyBuilders::ajaxAddToCartForm()`. The form itself, `AjaxAddToCartForm` (extends
`commerce_cart`'s `AddToCartForm`, registered as a `dc_ajax_add_cart` form mode on
`commerce_order_item` via `hook_entity_type_build`), turns its submit button into a
`use-ajax-submit` button whose AJAX callback returns an `AjaxResponse` assembled by the
`RefreshPageElementsHelper` service. That helper (a) updates the form build id, (b) removes and
re-appends the `status_messages` block for the active theme, and (c) replaces the
`.cart--cart-block` markup with a freshly built `commerce_cart` block — so the mini-cart and any
"added to cart" messages update live. A `hook_form_alter` on the order-item form-display edit form
hides purchased-entity widget types that don't make sense for the AJAX flow. It depends on
`commerce_product` + `commerce_cart` (Commerce ^2.4 || ^3), has no settings page or permissions of
its own (it reuses the Commerce add-to-cart formatter settings: `show_quantity`,
`default_quantity`, `combine`), and ships two submodules: **dc_ajax_add_cart_popup** (a modal
confirmation dialog) and **dc_ajax_add_cart_views** (AJAX remove/update-quantity Views fields for
the cart form).

---

- Add products to the cart without a full page reload on product pages.
- Refresh the mini-cart block live as items are added.
- Refresh Drupal status messages ("added X to your cart") in place after adding.
- Keep the customer on the current page while shopping (better UX on catalog/landing pages).
- Enable AJAX add-to-cart by simply choosing a display formatter on a product type.
- Preserve Commerce's quantity field, default quantity, and order-item combine settings.
- Use on any product type's Variations display (default or custom view modes).
- Show a modal "added to cart" confirmation popup (via `dc_ajax_add_cart_popup`).
- Let customers remove a line item from the cart form via AJAX (via `dc_ajax_add_cart_views`).
- Let customers update line-item quantities in the cart form via AJAX (via `dc_ajax_add_cart_views`).
- Avoid writing custom JavaScript for an ajaxified add-to-cart.
- Reuse the `RefreshPageElementsHelper` service to build cart-refreshing AJAX responses in custom code.
- Combine identical variations into one order item as they're added (Commerce `combine`).
- Support multi-variation products (the default variation's form is lazy-built per product).
- Render the add-to-cart form correctly under render caching (lazy builder + trusted callback).
- Localise the ajax form per current language (translation loaded in the lazy builder).
- Speed up perceived add-to-cart on mobile by skipping page reloads.
- Drop the standard Commerce add-to-cart form in favour of the AJAX variant site-wide.
- Keep cart and messages in sync when multiple add-to-cart forms are on one page.
- Build a quick-add catalog grid where each card adds to cart without navigation.
