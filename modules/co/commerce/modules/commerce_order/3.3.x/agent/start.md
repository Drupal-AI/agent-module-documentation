# commerce_order — agent start

Commerce submodule: the transactional core. Defines `commerce_order`, `commerce_order_item`,
**adjustments** (discounts/taxes/fees line items) and State-Machine-driven order workflows.
Requires `commerce`, `commerce_price`, `commerce_store`, `commerce_number_pattern`,
`entity_reference_revisions`, `profile`, `state_machine`. Config:
**/admin/commerce/config/order-types** (`commerce_order.configuration`).

- Order types, workflows, adjustments overview, permissions → [configure/orders.md](configure/orders.md)
- Adjustment type plugin (`commerce_order.adjustment_type`) → [plugins/adjustment-type.md](plugins/adjustment-type.md)
