<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Quantity Increments (commerce_quantity_increments) — agent index

A tiny Drupal Commerce add-on that constrains the orderable quantity of a **product variation** to a
configured step. It adds one base field (`qty_increments`) to `commerce_product_variation`; when set
`> 0` it is both the **minimum** and the required **multiple**. Package `Commerce (contrib)`.
Hard dependency `commerce:commerce_product`; soft dependency on `commerce_cart` (the form-alters
target its forms). Core `^10 || ^11`, Composer `drupal/commerce ^2.29 || ^3`. License
GPL-2.0-or-later. Version 3.x (installed 3.0.3).

- **The field, the two form-alters, the validation logic, install behaviour, and how to operate it** →
  [fields/qty_increments.md](fields/qty_increments.md)

## What it actually is

- **No** `src/`, `config/`, `*.services.yml`, `*.routing.yml`, `*.permissions.yml`, Drush, plugin
  types, or settings form. The whole module is three files: `.info.yml`, `.install`, `.module`.
- One base field **`qty_increments`** (decimal, unsigned, min 0, default 1, `#type number` widget,
  weight 10) added to `commerce_product_variation` via
  `commerce_quantity_increments_entity_base_field_info()`. Not translatable; not required (blank/0 =
  unconstrained).
- Two `hook_form_BASE_FORM_ID_alter()` implementations attach client hints **and** server-side
  validation to the quantity element:
  - `_form_commerce_order_item_add_to_cart_form_alter()` → the add-to-cart form.
  - `_form_views_form_commerce_cart_form_default_alter()` → the default Views cart form
    (`edit_quantity` per row).
- Helper `commerce_quantity_increments_get_increments_from_product_variation()` reads
  `$variation->get('qty_increments')->value` and casts a whole-number value to `int`, keeping
  fractions as `float` (returns `NULL`/`0`/empty when unset → no constraint).
- `hook_install()` → `commerce_quantity_increments_update_form_displays()` ensures the `quantity`
  component is shown on the `commerce_order_item.product_variation.add_to_cart` form display.

## Mechanism (from source)

- Both alters set `#min`, `#step` (and a `#default_value`) on the quantity element to the increment —
  these are **client-side hints** only.
- The real enforcement is the appended `#element_validate` callback
  (`..._add_to_cart_form_validate_qty_increments` / `..._commerce_cart_form_validate_qty_increments`),
  which runs **server-side** during Form API validation: it re-loads the variation, recomputes the
  increment, and calls `$form_state->setError()` when `$qty < $qty_increments` **or**
  `fmod($qty, $qty_increments) != 0`. Message: *"This product is available for purchase in increments
  of @increments only."* (`@increments` placeholder → auto-escaped by `t()`).
- The active variation id is stashed in `$form_state` (`commerce_quantity_increments_active_variation`)
  so the validate callback recomputes from storage, not from a submitted value.

## Notes / caveats

- Enforcement lives at the **Form API layer** (add-to-cart form + Views cart form). There is no
  order-item entity constraint, so the rule applies to those two form paths; operate accordingly and
  see the field doc for details.
- The single field value serves as **both** minimum and step — there is no separate max, and no
  separate minimum independent of the step.
- No configuration UI beyond editing the `qty_increments` field on the variation edit form; no
  permissions of its own (gate it via product-variation edit access).
