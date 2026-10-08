# Commerce checkout order fields — agent index

Collects extra data on the **order** entity during Commerce checkout by exposing an order
form-display mode as a checkout pane. No settings form of its own (`configure: null`); you
wire it up through Commerce's Field UI, form-display UI, and checkout-flow UI.

- **End-to-end setup: add fields, enable the Checkout form display, place the pane, pane
  config keys (`wrapper_element`, `display_label`)** → [configure/setup.md](configure/setup.md)
- **The `order_fields` checkout pane plugin and its per-form-mode deriver** →
  [plugins/checkout-pane.md](plugins/checkout-pane.md)

Key facts:
- Ships form mode `core.entity_form_mode.commerce_order.checkout` (label "Checkout").
- Pane plugin id `order_fields`, **derived per non-default order form mode** →
  usable id like `order_fields:checkout`.
- Pane config schema: `commerce_checkout.commerce_checkout_pane.order_fields:*` →
  `wrapper_element` (`container`|`fieldset`), `display_label`.
- Panes are placed in the checkout flow config
  `commerce_checkout.commerce_checkout_flow.<flow>` under `configuration.panes`.
- Dependencies: `commerce` (>=3), `commerce_checkout`, `field_ui`.
