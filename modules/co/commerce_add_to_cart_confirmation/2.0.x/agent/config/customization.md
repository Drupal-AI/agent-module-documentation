<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customising the confirmation (no settings form)

README states the module "has no menu nor modifiable settings." All customisation is done by editing
config the module ships, not a form.

## The confirmation body is a View

- **View id:** `confirm_message_product_display` (label "Commerce add to cart confirmation").
- Ships as **optional** config (`config/optional/views.view.confirm_message_product_display.yml`);
  enforced-dependency on `commerce_add_to_cart_confirmation`.
- Base table `commerce_order_item`, base field `order_item_id`; single `default` (Master) display,
  **no page display / no path**.
- Contextual argument `order_item_id` (numeric) — set at render time to the just-added order item.
- `access: { type: none }` and `pager: none`. Default title: *"Item successfully added to your cart"*
  (used as the modal title via `$view->getTitle()`).
- Default fields: order item `title` (excluded), `purchased_entity` (rendered with the
  `add_to_cart_confirmation` view mode), `quantity`, `total_price__number`. Footer uses the core
  `commerce_order_total` area handler.

To show related products, recently-viewed items, free-shipping progress, etc., **edit this view**
(add fields, an embedded view, or the area handlers below). If the view is deleted, the module's
runtime requirements check emits a warning and no dialog is shown (`renderMessage()` returns early
and logs to the `commerce_add_to_cart_confirmation` channel).

## The two view modes

Editing the *product* display for the confirmation is done through these view modes (Manage display):

- `commerce_product.add_to_cart_confirmation_view` — label "Add to cart confirmation".
- `commerce_product_variation.add_to_cart_confirmation` — label "Add to cart confirmation".

Both ship in `config/install/` and are enforced-dependent on the module. The view's
`purchased_entity` field renders the variation with the `add_to_cart_confirmation` view mode.

## Views area handlers you can add to the footer

Registered in `commerce_add_to_cart_confirmation.views.inc` (`hook_views_data`), both require an
**order item ID argument** in the view:

- **`commerce_add_to_cart_confirmation_order_item_order_total`** ("Order total for views with order
  item id argument") — `OrderItemOrderTotal`, extends Commerce's `OrderTotal`; renders the parent
  order's `total_price` (label inline).
- **`commerce_add_to_cart_confirmation_order_other_count`** ("Order other total count") —
  `OrderOtherCount`; renders "1 other item in your Cart" / "@count other items in your Cart" plus the
  price of everything *except* the just-added item. Renders nothing when there are no other items.

## Markup / styling

- Override the theme template `commerce_add_to_cart_confirmation.html.twig` (title, "Go to cart"
  link to `commerce_cart.page`, "Continue shopping" close link).
- Restyle via `css/commerce_add_to_cart_confirmation.css` (targets `.ui-dialog.commerce-confirmation-popup`).
- The dialog width (745) and classes are set in `js/commerce_add_to_cart_confirmation.js`.
