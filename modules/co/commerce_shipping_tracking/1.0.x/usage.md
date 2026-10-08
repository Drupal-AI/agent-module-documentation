<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Tracking provides a self-service form for customers to check whether their order has shipped.

---

Commerce Shipping Tracking adds an order-tracking form to a Drupal Commerce store. A visitor enters
their **order number** and the **email address used on the order**; the form then reports, via AJAX,
a configured message together with a friendly label mapped from the shipment's workflow state. A status
is returned only when an order with that number exists, the submitted email matches the order's own
email, and the order has a shipment; otherwise the site's configured error message is shown. The form
is rendered as a block (place it with Block Layout) and is also reachable as a standalone page.

It depends on Commerce Shipping, is configured at `commerce_shipping_tracking.settings` (Commerce »
Configuration » Shipping » Order Tracking Settings), and is in the Commerce (contrib) package. On the
settings page an administrator maps shipment workflow machine names to display labels and sets the
success and error messages. The tracking form shows only a mapped shipment-state label — not order
details, and not a carrier tracking number (the module does not read or store one).

---

- Let customers check whether an order has shipped.
- Provide a self-service order-tracking form.
- Enter an order number and the order email.
- Match the submitted email to the order's email.
- Show a label mapped from the shipment state.
- Display a configured success or error message.
- Render the form as a placeable block.
- Reach the same form on a standalone page.
- Depend on Commerce Shipping.
- Map shipment workflow states to labels.
- Configure messages on the settings form.
- Provide a settings-page permission.
- Translate the configured messages.
- Report shipment status, not order details.
- Not store a carrier tracking number.
- Configure at the Order Tracking Settings page.
- Handle the lookup through an AJAX callback.
- Track order fulfillment status.
- Check shipping status.
- Offer self-service tracking.
