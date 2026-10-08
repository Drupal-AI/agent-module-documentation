# Commerce checkout order fields — setup

The module has **no settings form**. Configuration is done entirely through Commerce's
existing UIs. Four steps:

## 1. Add fields to the order type

*Commerce → Configuration → Order types → (your type) → Manage fields*
(`/admin/commerce/config/order-types/default/edit/fields`). Add whatever fields you want to
collect, e.g. a "Text (plain, long)" field for order comments. They attach to the
`commerce_order` entity, bundle = order type (e.g. `default`).

## 2. Enable the Checkout form display

*Manage form display* for the order type
(`/admin/commerce/config/order-types/default/edit/form-display`). At the bottom, tick the
custom display for **Checkout**, then Save. Now edit that Checkout display
(`.../form-display/checkout`), disable everything except your new fields, and order them.

The module provides the "Checkout" form mode via
`core.entity_form_mode.commerce_order.checkout`. The form-display config entity you are
editing is `core.entity_form_display.commerce_order.<order_type>.checkout`.

## 3. Place the pane in the checkout flow

*Commerce → Configuration → Checkout flows → (your flow)*
(`/admin/commerce/config/checkout-flows/manage/default`). Drag the pane **"Order fields:
Checkout"** (plugin id `order_fields:checkout`) from *Disabled* into a real step, e.g.
*Review* or *Order information*, and Save.

The flow config is `commerce_checkout.commerce_checkout_flow.<flow>`; placed panes live under
`configuration.panes.<pane_id>` with keys `step`, `weight`, and the pane's own
`configuration`. Example fragment after placement:

```yaml
configuration:
  panes:
    order_fields:checkout:
      step: review
      weight: 3
      wrapper_element: fieldset
      display_label: 'Order comments'
```

## 4. Pane configuration

Editing the pane (gear icon on the flow page) exposes:

| Key | Values | Meaning |
|---|---|---|
| `wrapper_element` | `container` \| `fieldset` | how the fields are wrapped in the checkout form. |
| `display_label` | string | legend text, used **only** when `wrapper_element` is `fieldset`. |

Defaults: `wrapper_element` = `container`, `display_label` = the pane's plugin label.

## drush snippets

```bash
# confirm the Checkout order form mode exists
drush config:get core.entity_form_mode.commerce_order.checkout

# inspect placed panes on a flow
drush config:get commerce_checkout.commerce_checkout_flow.default configuration.panes
```

The pane id is `order_fields:<form_mode>` — one derivative per non-`default` order form mode
(see [plugins/checkout-pane.md](../plugins/checkout-pane.md)). With only the shipped mode
that is `order_fields:checkout`.
