<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Document — agent index

Lightweight, **non-storing** order-document generator for Drupal Commerce: define reusable document
configs (invoice / packing slip / pro forma / receipt) that staff **view / download (PDF) / email**
from an order, plus a **Receipt** that can auto-email the customer when an order is placed. Documents
are rendered on the fly from Twig templates via `entity_print` — nothing is persisted. Version
**1.0.2**, core `^10.1 || ^11`. Requires `commerce`, `commerce_order`.

- **Config entity, plugin config (default/receipt), routes, permissions, admin flow** →
  [configure/configure.md](configure/configure.md)
- **Plugin type, base class, email sending, entity_print renderer, events, extending** →
  [plugins/plugins.md](plugins/plugins.md)

## Key facts

- **Config entity** `commerce_order_document` (config prefix `commerce_order_document.commerce_order_document.*`,
  admin_permission `administer commerce_order_document`). Exported keys: `id`, `label`, `weight`,
  `orderType`, `status`, `plugin`, `configuration`, `conditions`, `conditionOperator`. Collection at
  `/admin/commerce/config/order-documents`.
- **Plugin type** `commerce_order_document.order_document` (namespace `Plugin/Commerce/OrderDocument`,
  annotation `@CommerceOrderDocument`, manager `plugin.manager.commerce_order_document`). Two built-in
  plugins: `default` (`DefaultOrderDocument`) and `receipt` (`Receipt`).
- **Per-order UI**: `commerce_order_document.order_documents_page` →
  `/admin/commerce/orders/{commerce_order}/documents` (a `Documents` local task + entity operation on
  the order). Radios of eligible documents with View / Download / Email buttons.
- **View / Download / Email routes** all require `_permission: 'administer commerce_order'` (a Commerce
  admin permission). No customer-facing document route exists — customers only receive documents by
  email pushed to the order's own address.
- **Download** streams a PDF via `entity_print` (`StreamedResponse` → `PrintBuilder::deliverPrintable`);
  documents are not written to disk.
- **Receipt** plugin: when `send_receipt` is on, auto-emails the customer on the order `place`
  transition (via `OrderEventEmailSubscriber` on `commerce_order.post_transition`, weight -100).
- **Eligibility**: `OrderDocumentStorage::loadMultipleForOrder()` returns enabled documents matching the
  order's `orderType`, filtered by the `FilterOrderDocumentsEvent`, then by each plugin's
  `readyForOrder()` (excludes `draft` orders) and the document's `commerce_condition` set.
- **Theme hooks**: `commerce_order_document` (template `commerce-order-document.html.twig`) +
  `commerce_order_document__entity_print`; per-document suggestion `..__{document_id}`. Twig
  auto-escaped, no `|raw`.
- **Not** the same as Commerce Invoice (which stores numbered invoices) — this is the lightweight,
  template-only alternative, closer to core's order receipt.

## Files

- `commerce_order_document.routing.yml` — 4 routes (documents page, view, email, download).
- `commerce_order_document.services.yml` — plugin manager + 2 event subscribers.
- `commerce_order_document.plugin_type.yml` — declares the order-document plugin type.
- `src/Entity/OrderDocument.php` — the `commerce_order_document` config entity (plugin collection,
  conditions, `applies()`).
- `src/OrderDocumentStorage.php` — `loadMultipleForOrder()` eligibility logic.
- `src/Plugin/Commerce/OrderDocument/{OrderDocumentBase,DefaultOrderDocument,Receipt}.php` — plugins.
- `src/Form/{OrderDocumentForm,OrderDocumentsForm,OrderDocumentSendForm}.php` — config form, per-order
  action form, send-confirm form.
- `src/EntityPrint/OrderDocumentRenderer.php` — entity_print renderer handler.
- `src/EventSubscriber/{OrderEventEmailSubscriber,FilterConditionsEventSubscriber}.php`.
- `templates/commerce-order-document.html.twig` (+ `--entity-print.html.twig` which just extends it).
