<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce AJAX Add to Cart Views — agent index

Submodule of `dc_ajax_add_cart`. Adds AJAX versions of the cart-form Views fields (remove line
item, edit quantity) so the cart View updates without a page reload. No config page
(`configure` null), no permissions, no Drush. Depends on `commerce_product`, `commerce_cart`,
`views`.

- **The two Views field handlers, their ids, and how to add them to the cart form View** →
  [plugins/views-fields.md](plugins/views-fields.md)

Key facts:
- `hook_views_data_alter` exposes on `commerce_order_item`: **Remove button (Ajax)**
  (`dc_ajax_add_cart_views_item_remove_button`) and **Quantity text field (Ajax)**
  (`dc_ajax_add_cart_views_item_edit_quantity`).
- Handlers `RemoveButton` / `EditQuantity` extend the `commerce_cart` handlers of the same name;
  they wrap the form in `#{view-id}-cart-ajax-wrapper`, attach `core/jquery.form` +
  `core/drupal.ajax`, and add `use-ajax-submit` + `#ajax['wrapper']` to submits.
- Schema adds `allow_decimal` to the ajax quantity field.
- Enable to inspect: `drush en dc_ajax_add_cart_views -y`.
