<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Reporting — agent index

Generates sales/product/tax/promotion reports for Drupal Commerce. Records a
`commerce_order_report` entity per order when it is placed, and renders report tables + Views
under the store's Reports. No global settings form (`configure: null`).

- **View reports, the report routes, the Generate-reports form, the shipped Views** →
  [configure/viewing-and-generating.md](configure/viewing-and-generating.md)
- **The `commerce_report_type` plugin type + the 4 built-ins; add your own** →
  [plugins/types.md](plugins/types.md)
- **`commerce_order_report` entity, the generator service, the order-placed flow** →
  [api/entity-and-generator.md](api/entity-and-generator.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity `commerce_order_report` (base table same name); its **bundles are plugins** of type
  `commerce_report_type` (annotation `@CommerceReportType`, manager
  `plugin.manager.commerce_report_type`, namespace `Plugin/Commerce/ReportType`).
- Built-in report types: `order_report`, `order_items_report`, `promotion_report`, `tax_report`.
- Reports are created by `OrderReportGenerator` on the `commerce_order.place.post_transition`
  event (via `OrderPlacedEventSubscriber`, on destruct).
- UI: `/admin/commerce/reports` (perm `access commerce reports`); generate form at
  `/admin/commerce/config/reports/generate-reports` (perm `generate commerce order reports`).
- Requires `commerce`, `commerce_price`, `commerce_order`, `views`.
