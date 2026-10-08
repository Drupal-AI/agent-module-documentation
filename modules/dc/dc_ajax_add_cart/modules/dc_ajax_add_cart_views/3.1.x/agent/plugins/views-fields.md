<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX cart Views fields

Two Views field handlers on the `commerce_order_item` base table, exposed by
`hook_views_data_alter` (`dc_ajax_add_cart_views.views.inc`). They subclass Commerce's cart-form
field handlers and only add AJAX wiring — the cart-form submit logic (remove / update quantity) is
inherited from `commerce_cart`.

| Views field title | Views data id | Handler (`@ViewsField`) | Extends |
|---|---|---|---|
| Remove button (Ajax) | `dc_ajax_add_cart_views_remove_button` | `dc_ajax_add_cart_views_item_remove_button` (`RemoveButton`) | `commerce_cart` `RemoveButton` |
| Quantity text field (Ajax) | `dc_ajax_add_cart_views_edit_quantity` | `dc_ajax_add_cart_views_item_edit_quantity` (`EditQuantity`) | `commerce_cart` `EditQuantity` |

## Add them to the cart View

1. Edit the cart form View (the Commerce default cart form, or your own View of
   `commerce_order_item` that renders the cart-edit form).
2. Add field **Remove button (Ajax)** for ajax line-item removal, and/or **Quantity text field
   (Ajax)** for ajax quantity edits (in place of the standard non-ajax ones).
3. Save. Submitting remove/update now refreshes the View over AJAX.

## What the handlers do (`viewsForm`)

Both compute `$wrapper_id = "{view-storage-id}-cart-ajax-wrapper"`, attach `core/jquery.form` +
`core/drupal.ajax`, set `#prefix`/`#suffix` to wrap the form in `<div id="{$wrapper_id}">`, and
add `use-ajax-submit` + `#ajax['wrapper' => $wrapper_id]` to the submit action.

- **`RemoveButton::viewsForm`** additionally builds one submit button **per result row**:
  `#type submit`, `#value` Remove, `#name` `delete-order-item-{row}`, `#remove_order_item TRUE`,
  `#row_index`, classes `delete-order-item use-ajax-submit`, and an `#ajax` wrapper.
- **`EditQuantity::viewsForm`** calls the parent (renders the quantity input + Update button) then
  applies the same ajax wrapper/classes.

## Settings

Schema `views.field.dc_ajax_add_cart_views_item_edit_quantity` (extends `views.field.field`) adds:

| Setting | Type | Meaning |
|---|---|---|
| `allow_decimal` | boolean | Allow decimal quantities in the ajax quantity field. |

## Tests

`tests/modules/dc_ajax_add_cart_views_test` ships two sample cart-form Views
(`..._cart_form`, `..._update_cart_form`) used by the FunctionalJavascript tests — handy as
reference View config.
