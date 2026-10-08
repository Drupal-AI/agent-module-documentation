<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# qty_increments field + quantity validation (commerce_quantity_increments)

Everything the module does, grounded in `commerce_quantity_increments.module` and
`commerce_quantity_increments.install`. No `src/`, no config objects, no routes/permissions/services.

## Install / enable

```
composer require drupal/commerce_quantity_increments
drush en commerce_quantity_increments -y
```

`hook_install()` (`.install`) calls `commerce_quantity_increments_update_form_displays()`, which
loads the `entity_form_display` `commerce_order_item.product_variation.add_to_cart` and, **if the
`quantity` component is not already present**, adds it (`type: number`, `weight: 1`) and saves. This
guarantees the customer sees a quantity input on the add-to-cart form so the step/validation can
apply. It only touches the `product_variation` order-item bundle and never removes an existing
component.

## The field

`commerce_quantity_increments_entity_base_field_info(EntityTypeInterface $entity_type)` adds, only
when `$entity_type->id() === 'commerce_product_variation'`, one base field:

- Machine name **`qty_increments`**, type **`decimal`**, label "Quantity increments".
- Settings: `unsigned: TRUE`, `size: normal`, `min: 0`. Not required, not translatable.
- **Default value `1`** (so a fresh variation is effectively unconstrained — step of 1).
- Form widget `number` at weight 10; display-configurable for both `form` and `view`.

Edit it on the product-variation edit form. A value of `0`, blank, or `NULL` means **no constraint**
(the helper returns a falsy value and both alters skip). There is **no** separate max and **no**
minimum independent of the step — the single value is used as both, see below.

## The increment helper

`commerce_quantity_increments_get_increments_from_product_variation(ProductVariationInterface $pv)`:

- Reads `$pv->get('qty_increments')->value`.
- If truthy and equal to `round()` of itself → cast to **`int`** ("no fraction → integer");
  otherwise the raw (fractional) value is returned as a **`float`**.
- Returns `int|float|null`; a falsy stored value yields no constraint.

## Add-to-cart form (`commerce_order_item_add_to_cart_form`)

`commerce_quantity_increments_form_commerce_order_item_add_to_cart_form_alter()`:

1. Only runs if `$form['quantity']['widget'][0]['value']` exists.
2. Resolves the variation: prefers `$form_state->get('selected_variation')` (AJAX variation switch),
   else `$form_object->getEntity()->getPurchasedEntity()`.
3. If it is a `ProductVariationInterface` **and** the helper returns a truthy increment:
   - Stashes the variation id in `$form_state` under `commerce_quantity_increments_active_variation`.
   - Appends validator `commerce_quantity_increments_add_to_cart_form_validate_qty_increments` to the
     element's `#element_validate`.
   - Sets `#default_value`, `#min`, and `#step` on the quantity element to the increment.

**Validator** `commerce_quantity_increments_add_to_cart_form_validate_qty_increments()` runs
server-side: re-loads the stashed variation, recomputes the increment, reads
`$qty = $values['quantity'][0]['value']`, and calls
`$form_state->setError($element, t('This product is available for purchase in increments of @increments only.', ['@increments' => $qty_increments]))`
when `$qty < $qty_increments` **or** `fmod($qty, $qty_increments)` is non-zero. It recomputes from
storage rather than trusting a submitted increment value.

## Views cart form (`views_form_commerce_cart_form_default`)

`commerce_quantity_increments_form_views_form_commerce_cart_form_default_alter()` iterates the view
rows; for each order item whose purchased variation has an increment it sets `#min`/`#step` on
`$form['edit_quantity'][$row->index]` and appends
`commerce_quantity_increments_commerce_cart_form_validate_qty_increments`. For **fractional**
increments it also resets `#default_value` to the current order-item quantity (so a valid stored
fractional quantity isn't clobbered by the step). The validator mirrors the add-to-cart one, indexing
`$values['edit_quantity'][$index]` and resolving the variation from the view result row's
`_relationship_entities['order_items']`.

## Operating notes

- Enforcement is at the **Form API layer** of these two forms. The `#min`/`#step` attributes are
  browser hints; the authoritative check is the server-side `#element_validate` callback. Rely on the
  validator, not the attributes, when reasoning about what quantities the form path accepts.
- The increment value is read from the variation entity (an admin/catalog-managed field), never from
  a shopper-submitted increment — the submitted quantity is only compared, not trusted as the rule.
- The error message uses a `t()` placeholder (`@increments`), so the increment value is
  auto-escaped in output.
- To change behaviour per product, set different `qty_increments` on each variation; there is no
  global setting.
