<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure add-on products on the Add to Cart form

There is no settings page. You configure add-ons per product-type display by swapping the
formatter used for the `variations` field.

## Prerequisites (one field per host product type)

Add an **Entity reference** field to the product type that should OFFER add-ons, targeting
`Product` (`commerce_product`) — cardinality usually unlimited. This field holds the products
whose variations you want offered as add-ons. Only fields whose storage `target_type` is
`commerce_product` on the same bundle are eligible (see `getReferenceFieldOptions()`).

## Enable via UI

1. Product type → **Manage display** (the product view display, e.g. `default`).
2. On the **Variations** field, choose format **"Add to cart form with add-ons"**
   (formatter id `commerce_pado_add_to_cart`).
3. In the formatter settings cog choose:
   - **The product reference field to select add-ons from** → the field you created (`add_on_field`, required).
   - **Let customers select multiple add-ons** → `multiple` (on = checkboxes / multi-select; off = single select).
4. Usually set the add-on reference field itself to **Hidden** on the same display.
5. Save. A validate handler blocks saving if the formatter is selected but no add-on field is chosen
   (error: "Please select a product add-on field.").

## Formatter settings

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `add_on_field` | string | `''` | Machine name of the `entity_reference`→`commerce_product` field on this product type. The referenced products' **enabled, published** variations become the add-ons. Required. |
| `multiple` | boolean | `TRUE` | `TRUE` → customers may pick several add-ons (checkboxes when a product has several variations); `FALSE` → single choice (select/radio). |
| `combine` | boolean | (inherited) | Inherited from `commerce_add_to_cart`; `TRUE` combines identical variations into one order-item line. |

Config schema: `field.formatter.settings.commerce_pado_add_to_cart` (extends
`field.formatter.settings.commerce_add_to_cart`) with `add_on_field` (string) + `multiple` (boolean).

## Set via config YAML

The formatter lives inside the product's view display, e.g.
`core.entity_view_display.commerce_product.<bundle>.<view_mode>`:

```yaml
content:
  variations:
    type: commerce_pado_add_to_cart
    label: hidden
    settings:
      add_on_field: field_add_ons   # your entity_reference(commerce_product) field
      multiple: true                # false = single selection
      combine: true                 # inherited from commerce_add_to_cart
    weight: 0
hidden:
  field_add_ons: true               # hide the reference field itself
```

## Set via PHP / drush

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('commerce_product', 'default', 'default');
$display->setComponent('variations', [
  'type' => 'commerce_pado_add_to_cart',
  'label' => 'hidden',
  'settings' => ['add_on_field' => 'field_add_ons', 'multiple' => TRUE, 'combine' => TRUE],
])->removeComponent('field_add_ons')->save();
```

Inspect a display: `drush cget core.entity_view_display.commerce_product.default.default --format=yaml`.

## What happens at runtime

- `PadoAddToCartFormatter::viewElements()` replaces the standard add-to-cart element with a
  `#lazy_builder` call to `commerce_pado.lazy_builders:addToCartWithAddOnsForm`, passing the
  product id, view mode, `combine`, `add_on_field`, `multiple` — so the display stays cacheable.
- `PadoLazyBuilders::addToCartWithAddOnsForm()` builds an order item from the product's default
  variation and instantiates `PadoAddToCartForm` (order-item form operation `pado_add_to_cart`,
  registered by `hook_entity_type_build()`; form id is namespaced by product id).
- `PadoAddToCartForm::buildForm()` loops the referenced add-on products (`$product->{add_on_field}
  ->referencedEntities()`), loads each product's **enabled** variations, keeps only **published**
  ones, and renders per add-on product: a single `checkbox` (1 variation), or `checkboxes`
  (`multiple` on) / `select` with a "- None -" option (several variations). Titles come from the
  theme hooks (see theme/templates.md).
- `PadoAddToCartForm::submitForm()` runs the parent add-to-cart submit for the main product, then
  for each selected variation id creates an order item, resolves its price server-side via the
  chain price resolver (`chainPriceResolver->resolve()`), sets the unit price, and adds it to the
  cart honoring `combine`. Quantity is always 1 (a `@todo` notes per-add-on quantity is unsupported).
  So every add-on is a normal order item — its own price, stock, tax and fulfilment.

## Shipped config (config/install)

- `core.entity_form_mode.commerce_order_item.pado_add_to_cart` + matching form display (shows
  `purchased_entity` as `commerce_product_variation_attributes`).
- `core.entity_view_mode.commerce_product.add_on` and
  `core.entity_view_mode.commerce_product_variation.add_on` — the **"Add On"** view modes. Configure
  each add-on product/variation type's **Add On** display to control how add-ons render as the
  checkbox `#description`.
