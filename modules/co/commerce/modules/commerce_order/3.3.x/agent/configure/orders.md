# Orders configuration

Entities:
- `commerce_order` (content) — customer, store, order items, billing profile, adjustments,
  state, order number.
- `commerce_order_item` (content) — references a purchasable entity, quantity, unit price.
- `commerce_order_type` / `commerce_order_item_type` (config) — bundles; extend with Field UI.
  Each order type binds a **workflow** and an order-number pattern.

Manage at `/admin/commerce/config/order-types` and
`/admin/commerce/config/order-item-types`; orders at `/admin/commerce/orders`.

## Workflows (State Machine)
Order lifecycle is a `state_machine` workflow (states + transitions), chosen per order type,
e.g. `order_default` (draft → completed) or fulfillment variants. Transitions fire events you
can subscribe to. Define custom workflows in a `*.workflows.yml` (State Machine Workflow
plugin group).

## Adjustments
Totals = sum of order-item prices + **adjustments** (a value object, not an entity).
Adjustment *types* are plugins — see [../plugins/adjustment-type.md](../plugins/adjustment-type.md).

## Availability
`Drupal\commerce_order\AvailabilityManager` (+ `AvailabilityCheckerInterface`) lets modules
veto adding an order item (e.g. stock). Register a service tagged
`commerce_order.availability_checker`.

## Permissions
Dynamic per order type plus `administer commerce_order` / `administer commerce_order_type`.
Config schema: `config/schema/commerce_order.schema.yml`.
