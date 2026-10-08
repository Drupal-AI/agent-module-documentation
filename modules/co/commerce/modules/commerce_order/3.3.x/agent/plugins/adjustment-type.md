# Adjustment type plugin

Plugin type `commerce_order.adjustment_type` — categorizes the adjustments (discount, tax,
fee, shipping, etc.) applied to an order/order item.

- Manager: `plugin.manager.commerce_adjustment_type`
  (`Drupal\commerce_order\AdjustmentTypeManager`).
- Defined in `commerce_order.plugin_type.yml`; plugins are declared as YAML definitions
  (`commerce_adjustment_types` in a `*.commerce_adjustment_types.yml` plugin file / discovery)
  with a label, singular/plural labels, whether it has a percentage, and weight.
- An **Adjustment** itself (`Drupal\commerce_order\Adjustment`) is a value object with a
  `type` (this plugin id), label, amount (Price), source id, and flags (included, locked,
  negative). Modules (promotion, tax, shipping) create adjustments of the appropriate type
  and add them to the order via the order/order-item, and the order refresh process collects
  and totals them.

To add a custom adjustment category (e.g. a handling fee), define a new adjustment type and
create `Adjustment` objects with that type in your order processor / event subscriber.
Order total collection runs through `commerce_order`'s order refresh and processor services.
