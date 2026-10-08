# commerce_checkout — agent start

Commerce submodule: configurable multi-step checkout. A **checkout flow** (config entity +
plugin) is ordered **steps** made of **checkout panes** (login, address, review, payment,
completion). Requires `commerce`, `commerce_order`, `commerce_cart`. Admin:
**/admin/commerce/config/checkout-flows** (`entity.commerce_checkout_flow.collection`).

- Configure checkout flows, steps, panes, permissions → [configure/flows.md](configure/flows.md)
- Checkout pane plugin (add a custom step field) → [plugins/checkout-pane.md](plugins/checkout-pane.md)
