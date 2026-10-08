<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Invoice adds an Invoice content entity to Drupal Commerce: it generates numbered, workflow-driven invoices (and credit memos) from orders, renders them as printable PDFs via Entity Print, and can email a confirmation to the customer.

---

The module defines two entities — `commerce_invoice` (a fieldable content entity, base table `commerce_invoice`) and its bundle config entity `commerce_invoice_type` — plus an `commerce_invoice_item` entity for line items. Two invoice types ship by default: `default` ("Invoice") and `credit_memo` ("Credit memo"), each bound to a `commerce_number_pattern` (invoice_default / invoice_credit_memo) that produces sequential invoice numbers, and to the `invoice_default` state-machine workflow (states draft → pending → paid, plus refund_pending/refunded/canceled). An invoice type carries settings such as `numberPattern`, `workflow`, `footerText`, `paymentTerms`, `dueDays`, a `logo` file UUID, and `sendConfirmation`/`confirmationBcc` for the customer email. Invoices are created programmatically through the `commerce_invoice.invoice_generator` service (`InvoiceGenerator::generate()`), from the order admin UI ("Invoices"/"Credit memos" tabs under an order), or automatically: the module alters the order-type form to add a per-order-type "invoice_type" and an "order placed generation" toggle (stored as `commerce_order.commerce_order_type.*.third_party.commerce_invoice`), and its `OrderPlacedSubscriber`/`OrderPaidSubscriber` event subscribers generate invoices when an order is placed/paid. Rendering and files go through `InvoicePrintBuilder`, `InvoiceFileManager` and Entity Print (PDF), and a rich `InvoiceEvents` set of events fires around invoice/item load/create/presave/insert/update/delete plus a filename event. Permissions are entity-based (administer invoice types, view/update/create/delete invoices, view own invoices). Invoice item types are managed at `/admin/commerce/config/invoices/invoice-item-types` and invoice types at `/admin/commerce/config/invoice-types`.

---

- Generate a numbered PDF invoice for a completed Commerce order.
- Automatically create an invoice when an order is placed (per order type).
- Automatically create an invoice when an order is fully paid.
- Issue a credit memo against an order using the shipped `credit_memo` invoice type.
- Define a custom invoice type (e.g. a pro-forma invoice) with its own number pattern and footer.
- Apply a sequential, formatted invoice number via a Commerce number pattern.
- Move an invoice through its workflow: draft → pending → paid, or refund/cancel.
- Email the customer an invoice confirmation with the PDF attached when it is generated.
- BCC accounts payable on every invoice confirmation email via `confirmationBcc`.
- Add a company logo and payment-terms text to generated invoices.
- Set net payment terms / due days on an invoice type.
- Let staff create an invoice manually from the order's Invoices tab.
- List all invoices for an order (and separately its credit memos) in the admin UI.
- Show a customer their own invoices (via the `view own commerce_invoice` permission).
- Render an invoice to a downloadable PDF using Entity Print.
- Customize the generated invoice filename with the `commerce_invoice.filename` event.
- React to invoice lifecycle with `InvoiceEvents` (e.g. sync to accounting on invoice insert).
- Split order-level adjustments across invoice items with the price splitter.
- Add custom fields to an invoice type (it is a fieldable bundle).
- Generate per-language invoice translations for a multilingual store.
- Programmatically build an invoice from one or more orders via `InvoiceGenerator::generate()`.
- Store generated invoice PDFs in a per-type private subdirectory.
- Provide an invoice total summary display (subtotal, adjustments, total) on the invoice.
- Expose invoices to customers under their user account's Invoices view.
- Regenerate/resend an invoice confirmation email from the admin UI.
- Track paid vs pending invoices for reconciliation.
