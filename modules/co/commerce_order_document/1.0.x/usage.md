<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Order Document provides order-document functionality for Drupal Commerce, generating documents such as invoices for orders.

---

Commerce Order Document adds order-document functionality to Drupal Commerce — generating documents
(invoices, order confirmations, packing slips, pro forma, credit memos) associated with orders, so
stores can produce and provide formal order paperwork. Unlike the heavier Commerce Invoice module it
does not store the documents; each is rendered on the fly from a Twig template and can be viewed,
downloaded as PDF, or emailed. It depends on Commerce and Commerce Order and provides its own
permissions.

You define reusable document configs (config entities) bound to an order type and optional conditions.
From an order's admin pages, staff view, download, or email a document; a Receipt document can also
auto-email the customer when an order is placed. Access is staff-scoped by design: the per-order
view/download/email routes require the Commerce `administer commerce_order` permission, and managing the
document configs requires `administer commerce_order document`. There is no customer-facing document
URL — customers receive documents by email sent to the order's own address — and downloaded PDFs are
streamed to the browser rather than written to a stored file. Configure the document types/templates as
needed (Twig templates control the rendered layout).

---

- Generate order documents for Commerce.
- Produce invoices for orders.
- Create order confirmation documents.
- Produce packing slips, pro forma, and credit memos.
- Depend on Commerce and Commerce Order.
- Provide its own permissions.
- Manage per-order documents.
- Define reusable document configs per order type.
- Gate per-order actions behind `administer commerce_order`.
- Gate document config behind `administer commerce_order document`.
- Stream downloaded PDFs without storing files.
- Email documents to the order's own address.
- Auto-email a receipt when an order is placed.
- Render documents from overridable Twig templates.
- Extend via the order-document plugin type.
- Filter documents per order with conditions.
- Produce order paperwork.
- Configure document types/templates.
- Generate formal order docs.
- Create billing documents.
- Support store paperwork.
