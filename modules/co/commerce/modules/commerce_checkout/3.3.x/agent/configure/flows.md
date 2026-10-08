# Checkout flows configuration

- `commerce_checkout_flow` (config entity) — a named flow with a flow **plugin** and its
  step/pane configuration. Manage at `/admin/commerce/config/checkout-flows`
  (`entity.commerce_checkout_flow.collection`). Each **order type** selects a flow.
- The flow's edit form lets you assign each **checkout pane** to a **step** (e.g. `login`,
  `order_information`, `review`, `payment`, `complete`), set weights and per-pane settings.

Managers/services:
- `plugin.manager.commerce_checkout_flow` (`CheckoutFlowManager`) — flow plugins.
- `plugin.manager.commerce_checkout_pane` (`CheckoutPaneManager`) — pane plugins.
- `CheckoutOrderManager` — resolves the flow + current step for an order and guards access.

## Permissions (`commerce_checkout.permissions.yml`)
- `access checkout` — proceed through checkout for own orders.
- `administer commerce_checkout_flow` — manage flows (restricted).

Config schema: `config/schema/commerce_checkout.schema.yml`. To add form fields to a step,
implement a checkout pane — see [../plugins/checkout-pane.md](../plugins/checkout-pane.md).
