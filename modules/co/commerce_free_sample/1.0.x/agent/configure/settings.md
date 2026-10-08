<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Free Sample

Route `commerce_free_sample.admin_settings_form` at `/admin/commerce/free-samples` (`administer commerce_product`) → config `commerce_free_sample.settings`.

## Settings
- `free_sample_ids` — the commerce_product ids offered as samples (the widget shows only these, published).
- `product_bundle` — the product bundle treated as "free sample" when detecting/removing an existing sample order item (default `free_sample`).
- `order_item_type` — the order-item type used when adding the sample line (default `default`).
- `eligibility_field` + `eligibility_values` — optional. When both are set, the sample selector is offered only if every order item's purchased variation's `eligibility_field` value is in `eligibility_values`; otherwise the widget is hidden (`#access = FALSE`).

## Field/widget setup
The module relies on a `field_free_sample` entity-reference field rendered by the `free_sample_widget` on the checkout order-information step (see `commerce_free_sample.install`). The widget builds options from `free_sample_ids`.

## Runtime behaviour
- On the `order_information` step: eligible orders see the selector; a submit handler processes the choice.
- Selecting a sample removes any existing item whose product bundle == `product_bundle`, then adds the selected product's default variation as an `OrderItem` with `unit_price` = the variation's price.
- On other steps the selector is hidden.

## Operator guidance
- Price sample product variations at **0** — "free" comes from the product's own price, not an adjustment.
- The submit/AJAX handlers do not re-check that the posted id is within `free_sample_ids`; keep sample variations at price 0 so a tampered selection cannot yield an underpriced legitimate product.
