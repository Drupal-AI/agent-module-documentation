<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Commerce AJAX Add to Cart that adds AJAX versions of the cart-form Views fields: a "Remove button (Ajax)" and a "Quantity text field (Ajax)", so customers can remove line items and update quantities in the cart View without a page reload.

---

`dc_ajax_add_cart_views` extends Commerce's cart-form Views field handlers so their submit actions
run over AJAX. It provides two `commerce_order_item` Views fields, exposed via
`hook_views_data_alter`: **Remove button (Ajax)** (`dc_ajax_add_cart_views_item_remove_button`,
handler `RemoveButton extends commerce_cart`'s `RemoveButton`) and **Quantity text field (Ajax)**
(`dc_ajax_add_cart_views_item_edit_quantity`, handler `EditQuantity extends commerce_cart`'s
`EditQuantity`). Each override wraps the cart form in a `<div id="{view-id}-cart-ajax-wrapper">`,
attaches `core/jquery.form` + `core/drupal.ajax`, and marks its submit button(s) with the
`use-ajax-submit` class and an `#ajax` wrapper so the cart view refreshes in place. The remove
handler builds one AJAX submit button per result row (`#remove_order_item`, class
`delete-order-item use-ajax-submit`). A schema file adds the `allow_decimal` setting to the ajax
quantity field. You add these fields to your cart form View (typically the default Commerce cart
form) in place of, or alongside, the standard ones. Depends on `commerce_product`,
`commerce_cart`, and `views`. Ships a test-only helper module and sample cart-form views under
`tests/`.

---

- Let customers remove a product from the cart View via AJAX (no page reload).
- Let customers change a line-item quantity in the cart View via AJAX.
- Add a "Remove button (Ajax)" field to the cart form View.
- Add a "Quantity text field (Ajax)" field to the cart form View.
- Keep the cart page interactive when editing quantities on the fly.
- Provide a per-row AJAX remove button in the cart line-item table.
- Allow decimal quantities on the ajax quantity field (`allow_decimal` setting).
- Refresh the cart View in place using a per-view ajax wrapper id.
- Reuse Commerce's cart-form logic while adding only the AJAX behaviour.
- Build a smoother cart-editing UX without custom JavaScript.
- Combine with `dc_ajax_add_cart` (add) and `dc_ajax_add_cart_popup` (confirm) for a full AJAX cart.
- Swap the standard cart Remove/Quantity fields for their AJAX equivalents.
- Support multiple cart-form Views, each with its own ajax wrapper.
- Update order totals as line items change without leaving the cart page.
- Give shoppers instant feedback when adjusting their cart contents.
