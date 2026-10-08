<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Commerce Product Availability Webform Request

`modules/commerce_product_availability_webform_request/` — adds an **"Order request"**
link/button beside Add to Cart that points shoppers to a chosen Webform (e.g. to request
a currently unavailable product). Depends on the parent module + `webform:webform`.
Enable with `drush en commerce_product_availability_webform_request`.

Everything is procedural hooks in
`commerce_product_availability_webform_request.module` — no services, routes, or
permissions of its own.

## Configuration (per Product Availability field, via third-party settings)

`hook_form_field_config_edit_form_alter` injects settings onto any
`commerce_product_availability_product_availability` field's config form; they are saved
by an `#entity_builders` callback (`..._third_party_settings_setter`) into third-party
settings namespaced `commerce_product_availability_webform_request`
(schema in `config/schema/...schema.yml`):

- `cpawr_enable_webform_request` (bool) — master on/off.
- `cpawr_webform` (webform entity id, autocomplete).
- `cpawr_link_display_mode` — `regular` | `blank` (new tab) | `modal` (the `modal` option
  is only offered when Webform's page-wide dialog support is on).
- `cpawr_additional_link_classes` (sequence of strings).
- `cpawr_override_link_label` (defaults to "Order request").
- `cpawr_only_show_if_not_available` (bool) — only render when `orderable` is false.

## Rendering the button

`hook_form_commerce_order_item_add_to_cart_form_alter` →
`commerce_product_availability_webform_request_add_request_button()`. It resolves the
selected variation (same selected-vs-purchased comparison as the parent, issue 3469910),
returns early unless the field has webform-request enabled and a webform selected (and,
if `cpawr_only_show_if_not_available`, unless the product is non-orderable), then builds
`$form['webform_request']` with `#theme`
`commerce_product_availability_webform_request_link`.

The link URL targets route `entity.webform.canonical` for the selected webform with query
params `product_variation_id`, `source_entity_type=commerce_product_variation`,
`source_entity_id` (the variation id), so the webform submission knows its source entity.
`modal` mode adds the `webform-dialog` class. Deliberately placed outside `['actions']`
for easier theming (issue 3468292).

## Theming

Template `templates/commerce-product-availability-webform-request-link.html.twig`
(`<a{{ attributes }}>{{ label }}</a>`). `hook_theme_suggestions_HOOK` adds suggestions by
orderable state and status, e.g.
`commerce_product_availability_webform_request_link__non_orderable`,
`..._link__status_out_of_stock`, and the combined
`..._link__non_orderable__status_out_of_stock`.
