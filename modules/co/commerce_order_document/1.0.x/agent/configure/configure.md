<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — config entity, routes, permissions, admin flow

## Config entity `commerce_order_document`

`src/Entity/OrderDocument.php` — a `@ConfigEntityType`, config prefix
`commerce_order_document.commerce_order_document.*`, `admin_permission = "administer commerce_order_document"`.

Exported config (`config_export`):

```yaml
# commerce_order_document.commerce_order_document.<id>
id: my_invoice
label: 'Invoice'            # admin label
weight: 0
orderType: default         # a commerce_order_type id — used to select which orders it applies to
status: true
plugin: default            # order-document plugin id: 'default' or 'receipt'
configuration:             # plugin-specific config (schema keyed by plugin id)
  display_label: 'Invoice' # customer-facing label + download filename
  can_download: true       # (default plugin) show Download button
  can_email: true          # (default plugin) show Email button
  email_subject: ''        # (default plugin) token-aware; blank = built-in default
conditions: []             # commerce_condition plugins (order-scoped)
conditionOperator: AND     # AND | OR
```

Config schema lives in `config/schema/commerce_order_document.schema.yml`, with a per-plugin mapping
`commerce_order_document.commerce_order_document.plugin.<plugin_id>` (see
[plugins/plugins.md](../plugins/plugins.md) for the `default` vs `receipt` config keys).

`OrderDocument` holds the plugin in a `CommerceSinglePluginCollection`, evaluates `commerce_condition`
plugins via `applies(OrderInterface $order)` (returns TRUE when no conditions), and exposes
`getPlugin()`, `getOrderType()`, `getConditions()`, `getConditionOperator()`.

## Admin routes (config UI)

Provided by `entity`'s `DefaultHtmlRouteProvider` from the entity `links`:

- collection: `/admin/commerce/config/order-documents` (menu link under Commerce → Configuration,
  route `entity.commerce_order_document.collection`)
- add: `/admin/commerce/config/order-documents/add`
- edit: `/admin/commerce/config/order-documents/manage/{commerce_order_document}`
- duplicate: `.../manage/{commerce_order_document}/duplicate`
- delete: `.../manage/{commerce_order_document}/delete`

The collection is a `DraggableListBuilder` (`OrderDocumentListBuilder`) showing label / id /
display_label / plugin / order type / status, with weight dragging when >1 document exists.
The add/edit form (`OrderDocumentForm`) picks the plugin via radios (AJAX-refreshed), embeds the
plugin's config form through the `plugin_configuration` commerce inline form, and adds a
`commerce_conditions` element (the `order_type` condition is stripped by
`FilterConditionsEventSubscriber` since `orderType` already filters).

## Per-order routes (staff actions)

`commerce_order_document.routing.yml` — all require `_permission: 'administer commerce_order'`:

| Route | Path | Controller/form |
|---|---|---|
| `order_documents_page` | `/admin/commerce/orders/{commerce_order}/documents` | `OrderDocumentsForm` (a `Documents` local task + `hook_entity_operation` op) |
| `order_document_view` | `/order-document/{commerce_order}/view/{order_document}` | `OrderDocumentController::view` (renders the document HTML) |
| `order_document_download` | `/order-document/{commerce_order}/download/{order_document}` | `OrderDocumentController::download` (streams a PDF) |
| `order_document_email` | `/admin/commerce/orders/{commerce_order}/documents/{order_document}/send-document` | `commerce_order.send-document` entity form (`OrderDocumentSendForm`) |

`OrderDocumentsForm` lists the eligible documents for the order (via
`OrderDocumentStorage::loadMultipleForOrder()`) as radios and dispatches to view / download / email
based on the clicked button. View opens in a new tab; Download/Email buttons are disabled when the
plugin's `canDownloadDocument()`/`canEmailDocument()` returns FALSE.

Access is intentionally staff-only: `administer commerce_order` is a Commerce admin permission that
already grants view of every order, so document access matches order access. Customers do not fetch
documents by URL — they receive them by email (see plugins doc). Downloads are streamed, not stored.

## Permissions

`commerce_order_document.permissions.yml`:

- `administer commerce_order_document` (restrict access: true) — manage the document config entities
  (add/edit/delete). This is the entity `admin_permission`.

The per-order view/download/email actions use the Commerce core `administer commerce_order` permission
(declared in the routing, not by this module).

## Eligibility for an order

`OrderDocumentStorage::loadMultipleForOrder(OrderInterface $order)`:

1. Load enabled documents (`status = TRUE`) whose `orderType` == `$order->bundle()`.
2. Dispatch `FilterOrderDocumentsEvent` (`commerce_order_document.filter_order_documents`) so code can
   add/remove documents.
3. Drop any whose plugin `!readyForOrder($order)` (base impl: excludes `draft` orders) or whose
   `applies($order)` conditions fail.
4. Sort by config-entity weight.
