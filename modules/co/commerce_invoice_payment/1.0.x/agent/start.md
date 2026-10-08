<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Invoice Payment (commerce_invoice_payment) — agent index

**Makes Commerce Invoices payable: a VBO 'Pay invoice' action turns invoices into an `invoice_payment` order for checkout, and the `ORDER_PAID` event transitions those invoices to paid.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11 · **Package:** Commerce (contrib)
- **Dependencies:** commerce, commerce_order, commerce_invoice:commerce_invoice, views_bulk_operations
- **Permission:** `use pay invoice action` (`restrict access: true`).
- **Pieces:** `Plugin/Action/PayInvoiceAction` (VBO), `EventSubscriber/OrderPaidSubscriber` (listens `OrderEvents::ORDER_PAID`), `Plugin/Commerce/CheckoutPane/InvoicePaymentOrderCompletePane`, `Entity/Invoice` (set via `hook_entity_type_build()`), example submodule.
- **Security:** invoices are marked paid **only** in the `ORDER_PAID` handler — i.e. after the order is genuinely paid through a Commerce gateway — never on an unverified/inbound request; there is no webhook/callback route. The `PayInvoiceAction::access()` requires **both** `update` access on the invoice **and** the restricted `use pay invoice action` permission. No anonymous or mutating endpoint. No security findings.

See [plugins/pay-invoice.md](plugins/pay-invoice.md)
