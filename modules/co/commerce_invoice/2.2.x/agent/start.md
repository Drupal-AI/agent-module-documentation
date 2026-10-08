<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Invoice — agent index

Adds an **Invoice** content entity to Drupal Commerce: numbered, workflow-driven invoices and
credit memos generated from orders, rendered as PDFs (Entity Print) and optionally emailed to
the customer. Entities: `commerce_invoice` (content), `commerce_invoice_type` (bundle config),
`commerce_invoice_item` (line items). Depends on Commerce + number_pattern, order, price, store,
profile, state_machine, token, file, entity_print.

- **Invoice types (the `commerce_invoice_type` config entity), number patterns, workflow, and
  automatic generation on order placed/paid** → [configure/invoice-types.md](configure/invoice-types.md)
- **Generate invoices in code: `InvoiceGenerator`, print/file builders** →
  [api/generate.md](api/generate.md)
- **Invoice lifecycle events (`InvoiceEvents`)** → [api/events.md](api/events.md)
- **Permissions (entity-based)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Shipped invoice types: `default` ("Invoice") and `credit_memo` ("Credit memo"). Bundle config
  prefix `commerce_invoice.commerce_invoice_type.*`.
- Invoice type keys: `numberPattern`, `workflow` (default `invoice_default`), `footerText`,
  `paymentTerms`, `dueDays`, `logo`, `sendConfirmation`, `confirmationBcc`, `privateSubdirectory`.
- Workflow `invoice_default`: states draft, pending, paid, refund_pending, refunded, canceled.
- Auto-generation is per **order type** via third-party settings
  `commerce_order.commerce_order_type.*.third_party.commerce_invoice`
  (`invoice_type`, `order_placed_generation`).
- Admin: invoice types `/admin/commerce/config/invoice-types`; invoice item types
  `/admin/commerce/config/invoices/invoice-item-types`; per-order Invoices/Credit memos tabs.
- Generator service: `commerce_invoice.invoice_generator`
  (`Drupal\commerce_invoice\InvoiceGeneratorInterface::generate()`).
