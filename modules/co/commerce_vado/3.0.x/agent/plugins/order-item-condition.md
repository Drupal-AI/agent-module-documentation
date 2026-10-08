# Commerce condition: `order_item_vado`

Class `Plugin\Commerce\Condition\OrderItemVado` (extends commerce `ConditionBase`).

```
@CommerceCondition(
  id = "order_item_vado",
  label = "Exclude variation add-on",
  display_label = "Exclude variation add-on",
  category = "Products",
  entity_type = "commerce_order_item",
)
```

Purpose: a promotion/offer condition (entity type `commerce_order_item`) that lets a Commerce
**promotion** skip VADO-generated add-on order items. `evaluate()` returns **FALSE** for any order item
that has a `commerce_vado_combo_id` data value (i.e. a parent or child that is part of a VADO bundle) and
**TRUE** otherwise.

Use it when a store-wide promotion should apply only to normal purchases and not double-discount items that
already carry a `vado_discount`. Add the "Exclude variation add-on" condition to the promotion; it is
selectable wherever order-item conditions are offered (it is auto-discovered by the commerce condition
plugin manager — no config needed here).
