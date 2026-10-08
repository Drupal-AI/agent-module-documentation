<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce AJAX Add to Cart – Popup — agent index

Submodule of `dc_ajax_add_cart`. After an AJAX add-to-cart, opens a modal dialog confirming the
add and showing the product variation + a cart link. No config page (`configure` null), no
permissions, no Drush. Depends only on `dc_ajax_add_cart`.

- **How the popup is wired (event subscriber, view mode, template) and how to customise it** →
  [configure/popup.md](configure/popup.md)

Key facts:
- Event subscriber `AjaxAddToCartPopupSubscriber` (service `ajax_add_to_cart_popup_subscriber`):
  `CartEvents::CART_ENTITY_ADD` → store purchased variation; `KernelEvents::RESPONSE` → if response
  is an `AjaxResponse` and something was added, add `OpenModalDialogCommand` (width 700).
- Variation rendered in the `dc_ajax_add_cart_popup` view mode of `commerce_product_variation`
  (shipped as `config/optional`).
- Theme hook `dc_ajax_add_cart_popup` / template `dc-ajax-add-cart-popup.html.twig` (vars:
  `product_variation`, `product_variation_entity`, `cart_url`).
- `hook_form_..._alter` attaches `core/drupal.dialog.ajax` and sets `#ajax['disable-refocus']`.
- Enable to inspect: `drush en dc_ajax_add_cart_popup -y`.
