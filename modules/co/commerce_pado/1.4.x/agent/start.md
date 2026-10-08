<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Add On (commerce_pado) — agent index

Lets one Commerce product offer OTHER products (and their variations) as selectable add-ons
directly in its Add to Cart form — e.g. warranty, gift wrap, accessories. Each chosen add-on
becomes its own order item at its own server-resolved price. Configured entirely through a
**field formatter** on the product's `variations` field — no settings page, no routes, no
permissions, no Drush. Requires `commerce_cart` + `commerce_product` (project `drupal/commerce`).

- **Offer add-on products on a product's Add to Cart form** → [configure/add-to-cart-form.md](configure/add-to-cart-form.md)
- **Theme the add-on form and labels (e.g. show the price)** → [theme/templates.md](theme/templates.md)

Key facts:
- Formatter plugin `commerce_pado_add_to_cart` ("Add to cart form with add-ons"),
  class `Drupal\commerce_pado\Plugin\Field\FieldFormatter\PadoAddToCartFormatter` (extends
  commerce_product's `AddToCartFormatter`). Set it on the `variations` field in **Manage display**.
- Formatter settings: `add_on_field` (machine name of an `entity_reference`→`commerce_product`
  field on the same product type, whose referenced products' variations become the add-ons),
  `multiple` (bool; multiple selection vs. single), plus inherited `combine`.
- Config schema key: `field.formatter.settings.commerce_pado_add_to_cart` (extends
  `field.formatter.settings.commerce_add_to_cart`).
- Service `commerce_pado.lazy_builders` → `PadoLazyBuilders::addToCartWithAddOnsForm()`
  (extends `ProductLazyBuilders`) lazy-builds the add-on form so the display stays cacheable.
- `hook_entity_type_build()` registers order-item form class `PadoAddToCartForm` for the
  `pado_add_to_cart` operation (extends commerce_cart `AddToCartForm`); it renders the add-on
  checkboxes/selects and, on submit, adds one order item per selection.
- `hook_form_entity_view_display_edit_form_alter()` + `commerce_pado_entity_view_display_form_validate()`
  require `add_on_field` to be set whenever the `variations` component uses this formatter.
- Ships config/install: order-item form mode `pado_add_to_cart` (+ its form display) and
  `add_on` view modes for `commerce_product` and `commerce_product_variation`.
- Theme hooks: `commerce_pado_add_to_cart_form`, `commerce_pado_addon_product_label`,
  `commerce_pado_addon_product_variation_label` (each with a per-bundle suggestion).
