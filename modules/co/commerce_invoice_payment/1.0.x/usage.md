<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bridges the Commerce Invoice and Commerce Order systems so a customer can select outstanding invoices and pay them through the normal Commerce checkout.

---
It makes the `commerce_invoice` entity purchasable (a custom `Invoice` entity class via `hook_entity_type_build()`), and provides a Views Bulk Operations "Pay invoice" action: selected invoices are turned into order items on an `invoice_payment` order, which is then sent to the standard Commerce checkout (`review` step) for real payment. An `OrderPaidSubscriber` listens for Commerce's `ORDER_PAID` event and, for each invoice line item, transitions the invoice's workflow state (`confirm` if draft, then `pay`) and saves it. A checkout-complete pane lists the invoices that were paid and offers a return link.

Crucially, invoices are only marked paid **in response to Commerce's own `ORDER_PAID` event**, i.e. after the order has actually been paid through a configured payment gateway — the module never marks an invoice paid on an unverified request. The "Pay invoice" VBO action is access-controlled: it requires both `update` access on the invoice entity *and* the `use pay invoice action` permission (which is flagged `restrict access: true`). Setup is: enable the module, add the "Pay invoice" action to an invoices View, and grant the permission to the appropriate role.
---
- Let customers pay outstanding invoices online.
- Add a "Pay invoice" bulk action to an invoices View.
- Convert selected invoices into a payable order.
- Route invoice payment through standard Commerce checkout.
- Automatically mark invoices paid once the order is paid.
- Transition a draft invoice to confirmed then paid on payment.
- Show a "you paid these invoices" confirmation pane.
- Offer a return-to-overview link after payment.
- Make Commerce invoices purchasable entities.
- Restrict who can trigger invoice payment via permission.
- Require entity update access before paying an invoice.
- Batch-pay multiple invoices in one order.
- Integrate invoice settlement with any Commerce payment gateway.
- Track invoice state through the Commerce workflow.
- Send customers straight to the review/checkout step.
- Build a customer invoice portal on top of Commerce.
- Reconcile invoices automatically on successful payment.
- Keep invoice payment inside the trusted checkout flow.