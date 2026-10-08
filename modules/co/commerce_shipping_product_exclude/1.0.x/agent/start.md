<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Product Exclude — agent index

Lets a Drupal Commerce **product or product variation** forbid specific **shipping methods**, so
a flagged item in the cart removes those methods from the checkout choices (e.g. a hazardous or
oversized product that a courier won't carry). Version **1.0.0-beta4** (pre-release / beta; project
is "Minimally maintained", "Maintenance fixes only", but security-advisory covered). Core
`^10 || ^11`. Depends on `commerce` and `commerce_shipping`. No admin settings page, no routes, no
permissions, no config schema of its own.

Two source files, no subdocs:

## The field type — `src/Plugin/Field/FieldType/ExcludeShippingMethodItem.php`
- Field type id `commerce_shipping_product_exclude_shipping_method` (constant `FIELD_ID`),
  label "Exclude Shipping Method", category `commerce`. Extends core `EntityReferenceItem`.
- Hard-codes `target_type => commerce_shipping_method` in `defaultStorageSettings()`; empties the
  storage-settings form and `getPreconfiguredOptions()` (no per-field target config — always points
  at shipping methods).
- Default widget `options_buttons`, default formatter `entity_reference_label`,
  list class `EntityReferenceFieldItemList`.
- `getSettableOptions()` restricts the widget's selectable options to shipping methods that are
  **enabled** (`status = TRUE`) **and** already have the `exclude_from_shipping` condition attached
  (queried from `commerce_shipping_method` storage, sorted by weight).
- Attach this field (cardinality Unlimited) to a product type and/or variation type; the value is
  the set of methods that item must not ship by.

## The condition — `src/Plugin/Commerce/Condition/ExcludeFromShipping.php`
- `@CommerceCondition` id `exclude_from_shipping`, label "Allow to exclude From Shipping",
  category "Commerce Order", `entity_type = "commerce_order"`. Extends `ConditionBase`, implements
  `ParentEntityAwareInterface` (via `ParentEntityAwareTrait`) — the parent entity is the shipping
  method the condition is enabled on.
- Enable this condition on each shipping method you want to be excludable; only such methods appear
  in the field widget (see above).
- `evaluate(OrderInterface $order)`: loops the order's items, and for each purchased
  `ProductVariationInterface` it scans **both** the variation's own fields **and** its parent
  product's fields for a field of type `FIELD_ID`. If any such field's value references the current
  shipping method (`target_id === $this->parentEntity->id()`) it returns **`FALSE`** — the method
  is excluded for this order. Otherwise returns `TRUE` (method allowed).
- Evaluation is entirely **server-side** against the order's real line items and the stored
  product/variation field values; the customer submits no shipping-exclusion input.
- Behaviour note: despite the README/inline comments describing the parent-product check as a
  *fallback* used only when the variation field is empty, the code checks the product field
  **unconditionally** after the variation field. Effective semantics are a **union** — a method is
  excluded if the variation **or** the parent product lists it — not a variation-overrides-product
  precedence.

## Integration
- No `hook_help`, no `.routing.yml`, `.permissions.yml`, `.services.yml`, or `config/schema`. The
  only tests is a `GenericModuleTestBase` install smoke test.
- Works through Commerce Shipping's normal rate/condition evaluation: excluded methods simply do not
  appear as selectable rates at checkout.
