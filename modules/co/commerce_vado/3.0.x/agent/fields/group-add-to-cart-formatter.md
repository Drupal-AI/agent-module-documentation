# Field formatter: `commerce_vado_group_add_to_cart`

A drop-in replacement for Commerce's Add-to-Cart field formatter that additionally renders the parent
variation's **variation groups** as selectable add-on widgets on the product's Add to Cart form.

- Class `Plugin\Field\FieldFormatter\VadoGroupAddToCartFormatter` extends
  `commerce_product\...\AddToCartFormatter`. Formatter id `commerce_vado_group_add_to_cart`, label
  "Group add to cart form", `field_types = { entity_reference }` — set it on the product's
  `variations` field display (Manage display for the product type) instead of the standard "Add to cart form".
- `viewElements()` renders via a `#lazy_builder`:
  `commerce_vado.lazy_builders:addToCartWithAddOnsForm(product_id, view_mode, combine)` (see api/entities.md).

## Formatter settings

Schema `field.formatter.settings.commerce_vado_group_add_to_cart` (`config/schema/commerce_vado.schema.yml`):

| Setting | Type | Meaning |
|---|---|---|
| `show_quantity` | boolean | Show a quantity input on the Add-to-Cart form. |
| `default_quantity` | string | Default quantity. |
| `combine` | boolean | Combine order items containing the same product variation. |

## Custom order-item form + form mode

- The lazy builder builds the order-item form in the **`vado_group_add_to_cart`** form mode. That form mode is
  installed by `config/install/core.entity_form_mode.commerce_order_item.vado_group_add_to_cart.yml`, and
  `hook_entity_type_build()` (`commerce_vado_entity_type_build()`) maps it to the form class
  `Form\VadoGroupAddToCartForm` (extends commerce_cart `AddToCartForm`).
- `VadoGroupAddToCartForm::buildForm()` adds a `commerce_vado_group` container and, for each group referenced
  by the selected variation's `variation_groups`, a `addon_group_<group_id>` element built by that group's
  widget plugin. `buildEntity()` stores the flattened selections as `selected_addon_group_items` on the order
  item (consumed by the cart event subscriber). Changing the variation clears prior group selections
  (`clearValues()` `#after_build`) so defaults re-apply.

Static-list groups don't need this formatter: `commerce_vado_form_commerce_order_item_add_to_cart_form_alter()`
injects their default items (`selected_addon_group_items`) into the ordinary Add-to-Cart form.
