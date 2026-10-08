<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up Commerce AJAX Add to Cart

No config form (`configure` null) and no permissions. You "configure" it by choosing the AJAX
formatter on a product type's display; behaviour otherwise reuses Commerce's add-to-cart settings.

## Enable the AJAX add-to-cart form

1. Go to *Commerce → Configuration → Product types → (your type) → Manage display*
   (`admin/commerce/config/product-types/default/edit/display`).
2. For the **Variations** field, choose formatter **Ajax add to cart form** (`dc_ajax_add_cart`).
3. Save. The product's add-to-cart form now submits over AJAX.

Do this per product type / per view mode you want ajaxified.

## Formatter settings (inherited from Commerce)

`AjaxAddToCartFormatter extends AddToCartFormatter`, so the same settings apply (schema
`field.formatter.settings.dc_ajax_add_cart`):

| Setting | Meaning |
|---|---|
| `show_quantity` | Show a quantity input on the add-to-cart form. |
| `default_quantity` | Default quantity value. |
| `combine` | Combine order items for the same variation into one line. |

## How the AJAX round-trip is wired (mechanics)

- **`hook_entity_type_build`** registers a `dc_ajax_add_cart` form mode on `commerce_order_item`
  with form class `AjaxAddToCartForm`.
- **Formatter** (`viewElements`) takes Commerce's add-to-cart render element and repoints its
  `#lazy_builder` to `dc_ajax_add_cart.lazy_builders:ajaxAddToCartForm` (skipped when the product
  is being previewed / `in_preview`).
- **Lazy builder** `ProductLazyBuilders::ajaxAddToCartForm($product_id, $view_mode, $combine,
  $langcode)` (a `TrustedCallbackInterface`) loads the product (translated to context), creates an
  order item from the **default variation**, gets the `commerce_order_item` form object in the
  `dc_ajax_add_cart` mode, sets a product-id-based form id, and builds the form. Returns `[]` if the
  product has no default variation.
- **`AjaxAddToCartForm`** (`extends AddToCartForm`) attaches `core/jquery.form` +
  `core/drupal.ajax`, and in `actions()` wraps the submit button in a unique-id div, gives it class
  `use-ajax-submit`, and sets `#ajax['callback'] = '::refreshAddToCartForm'`.
- **Callback** `refreshAddToCartForm()` returns
  `RefreshPageElementsHelper::updatePageElements($form)->getResponse()` — see
  [../api/refresh-helper.md](../api/refresh-helper.md).

## Form-display edit tweak

`hook_form_entity_form_display_edit_form_alter` — on the `commerce_order_item` `dc_ajax_add_cart`
form-display edit screen, it removes purchased-entity widget options that don't fit the AJAX flow
(`commerce_entity_select`, the entity-reference autocompletes, `inline_entity_form_complex`,
`options_buttons`, `options_select`).

## Requirements / expectations

- The **Cart** block (`commerce_cart`, markup class `.cart--cart-block`) should be placed so the
  live update has something to replace.
- A **status messages** block must be placed for the active theme for message refresh to work
  (the helper looks up the `system_messages_block` for the active theme).
