Commerce checkout order fields lets you collect extra data on the order entity during Commerce checkout by exposing an order form-display mode as a checkout pane, so any field you add to the order type can be filled in mid-checkout without custom code.

---

The module ships a `Checkout` form-display mode for the `commerce_order` entity (config `core.entity_form_mode.commerce_order.checkout`) and a checkout pane plugin `order_fields` whose derivatives are generated per non-default order form mode by `OrderFieldsPaneDeriver` (so the usable pane id is typically `order_fields:checkout`). You add fields to the order type under *Manage fields*, enable the custom **Checkout** form display under *Manage form display*, arrange which fields appear there, then place the derived "Order fields: Checkout" pane into a step of the checkout flow. At checkout the pane renders that form display against the current order (`buildPaneForm`/`validatePaneForm`/`submitPaneForm` delegate to the `EntityFormDisplay`), so the fields save straight onto the order; the coupons component is stripped from the rendered display. The pane's own configuration (schema `commerce_checkout.commerce_checkout_pane.order_fields:*`) offers a `wrapper_element` (`container` or `fieldset`) and a `display_label` used when the wrapper is a fieldset. A `buildPaneSummary()` renders the collected values on the checkout review step using the matching view-display mode when one exists. The module has no settings form of its own — all configuration is done through Commerce's field UI, form-display UI, and checkout-flow UI.

---

- Collect an "order comments" / special-instructions text field during checkout.
- Ask for a preferred delivery date on the order at checkout.
- Capture a PO (purchase order) number for B2B orders mid-checkout.
- Add a "gift message" field that saves onto the order entity.
- Collect a VAT / tax ID during checkout for business customers.
- Require a "how did you hear about us?" select on the order.
- Gather event or booking details as order fields during checkout.
- Add a delivery-instructions field shown inside a fieldset with a custom label.
- Present extra order fields wrapped in a plain container (no visible legend).
- Collect a loyalty / referral code on the order at checkout.
- Add a checkbox for "leave at door" or contactless delivery.
- Capture a company name field for invoicing on the order.
- Place the order-fields pane in the Review step vs the Order information step.
- Collect multiple custom order fields that all appear together at one checkout location.
- Show the collected order-field values on the checkout review summary.
- Add a required terms-acknowledgement field stored on the order.
- Gather a requested delivery window via a time-range order field.
- Collect a second contact phone number on the order.
- Add a free-text "engraving text" field for personalised products.
- Keep custom checkout data on the order entity (not the profile) so it exports with the order.
- Configure everything through Field UI / form display without writing a custom checkout pane.
- Reuse an existing order form-display mode as a checkout data-collection step.
