<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item Fields — setup

No settings form. Configuration is done through Commerce's existing UIs. The pane derivative
for an order item type only exists once that type has at least one **qualifying field**.

## 1. Add fields to the order item type

*Commerce → Configuration → Order item types → (your type) → Manage fields*
(`/admin/commerce/config/order-item-types/{type}/edit/fields`). Add the fields to collect
per unit (e.g. *Attendee name*, *Attendee email*). They attach to the `commerce_order_item`
entity, bundle = order item type (e.g. `ticket`).

Adding/updating/deleting a `commerce_order_item` field, or an order item type, clears the
checkout-pane plugin definition cache automatically (entity CRUD hooks in
`commerce_order_item_checkout_fields.module`), so the derivative list stays fresh without
`drush cr`.

Almost any field type works: `string`, `string_long`, `email`, `integer`, `decimal`,
`float`, `boolean`, `list_*`, `datetime`, `daterange`, `telephone`, `link`, `entity_reference`,
`address`, `custom_field`. **Excluded by default**: `file`, `image`,
`entity_reference_revisions` (Paragraphs) — skipped silently with a debug log entry.

## 2. (Recommended) Pick fields with a form display mode

*Manage form display* for the order item type. The pane renders **whatever fields are placed
on the chosen form display mode**. Create a dedicated mode (e.g. "Checkout") to control
exactly which fields and widgets appear, then select it in the pane settings (step 4). Only
fields present in the selected mode are rendered, validated and stored.

## 3. Place the pane in the checkout flow

*Commerce → Configuration → Checkout flows → (your flow)*
(`/admin/commerce/config/checkout-flows`). Drag the pane whose label ends with **"… fields"**
(plugin id `order_item_fields:<order_item_type>`, e.g. `order_item_fields:ticket`) from
*Disabled* into a real step, and Save.

The flow config is `commerce_checkout.commerce_checkout_flow.<flow>`; placed panes live under
`configuration.panes.<pane_id>` with keys `step`, `weight`, plus the pane's own settings.
Example fragment:

```yaml
configuration:
  panes:
    order_item_fields:ticket:
      step: order_information
      weight: 3
      form_display_mode: checkout
      require_complete: true
```

## 4. Pane settings

Editing the pane (gear icon) exposes, on top of the standard pane options (step, weight,
display label override, wrapper element):

| Key | Values | Default | Meaning |
|---|---|---|---|
| `form_display_mode` | any form mode id on `commerce_order_item` | `default` | Which form display mode supplies the fields/widgets rendered per product. |
| `require_complete` | bool | `false` | On combined items (quantity > 1), require a value in every field for every product so stored deltas stay aligned. No effect on quantity-1 (Path B) checkout. |

Saving the pane raises a **non-blocking warning** listing any collected field that lacks
unlimited cardinality (via `OrderItemFields::findLimitedCardinalityFields()`); the same list
appears at *Reports → Status report* (`hook_requirements`). Set those fields to unlimited
cardinality if the products can be combined in the cart.

## Cardinality (combined items)

A combined order item stores one value per product as a **field delta**, so a field collected
on a product type that can be combined in the cart must have **cardinality Unlimited** (or at
least the max buyable quantity). Fields on never-combined products (quantity 1) work with
cardinality 1. The module warns but does not block — combinability cannot be reliably
detected at config time.

## Keeping products aligned (empty deltas)

Drupal drops empty field deltas on save (`filterEmptyItems()`), so a product left blank is
omitted and can misalign *multiple separate* fields. Options: enable `require_complete`, mark
the fields Required, or use one **composite field per product** (`address` / `custom_field`)
so a product's whole record lives in one delta.

## drush snippets

```bash
# inspect placed panes on a flow
drush config:get commerce_checkout.commerce_checkout_flow.default configuration.panes

# list form modes on the order item entity
drush config:status | grep entity_form_mode.commerce_order_item
```
