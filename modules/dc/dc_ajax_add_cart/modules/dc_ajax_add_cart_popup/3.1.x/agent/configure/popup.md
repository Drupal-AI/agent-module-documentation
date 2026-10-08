<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The add-to-cart popup

No settings form. Enabling the submodule is the setup; customisation is via the view mode and the
Twig template.

## Setup

1. `drush en dc_ajax_add_cart_popup -y` (requires the parent `dc_ajax_add_cart` and its AJAX
   formatter already in use — see the parent's `configure/setup.md`).
2. Optionally arrange the popup contents at *Commerce → Configuration → Product variation types →
   (type) → Manage display*, view mode **dc_ajax_add_cart_popup** (a `config/optional` view mode
   `core.entity_view_mode.commerce_product_variation.dc_ajax_add_cart_popup` is provided).

The README also mentions enabling the "Ajax add to cart popup" custom display setting on the
product-variation type display — that exposes/uses the `dc_ajax_add_cart_popup` view mode.

## How it works

- **`AjaxAddToCartPopupSubscriber`** (service `ajax_add_to_cart_popup_subscriber`,
  ctor arg `@entity_type.manager`) subscribes to:
  - `CartEvents::CART_ENTITY_ADD` (`onAddToCart`) — stores the purchased variation entity.
  - `KernelEvents::RESPONSE` (`onResponse`) — returns early unless a variation was added **and**
    the response is an `AjaxResponse`; then renders the variation via the
    `commerce_product_variation` view builder in the `dc_ajax_add_cart_popup` view mode, wraps it in
    the `dc_ajax_add_cart_popup` theme, and adds an `OpenModalDialogCommand('', $content,
    ['width' => '700'])` to the response.
- **`hook_form_commerce_order_item_dc_ajax_add_cart_form_alter`** attaches
  `core/drupal.dialog.ajax` and sets `$form['actions']['submit']['#ajax']['disable-refocus'] =
  TRUE`.

## Template

Theme hook `dc_ajax_add_cart_popup` (registered in `.module`), template
`templates/dc-ajax-add-cart-popup.html.twig`. Variables:

| Variable | Value |
|---|---|
| `product_variation` | The rendered variation fields (from the popup view mode). |
| `product_variation_entity` | The variation entity. |
| `cart_url` | URL of the cart page (`commerce_cart.page`). |

Default markup: an "The item has been added to your cart." message, the rendered variation, and a
"View your cart" link. Override the template in your theme to change layout, add upsells, etc.
