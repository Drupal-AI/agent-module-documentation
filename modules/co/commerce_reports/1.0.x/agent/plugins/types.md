<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `commerce_report_type` plugin type & report types

Report types are a real plugin type and double as the **bundles** of the
`commerce_order_report` entity (`bundle_plugin_type = "commerce_report_type"`, using
`entity`'s BundlePlugin system).

- Annotation: `@CommerceReportType` (`Annotation\CommerceReportType`) — `id`, `label`,
  `create_label`.
- Manager: `plugin.manager.commerce_report_type` (`ReportTypeManager`), discovery namespace
  `Plugin/Commerce/ReportType`, interface `ReportTypeInterface` (extends
  `entity`'s `BundlePluginInterface`). `id` and `label` are required.
- Declared in `commerce_reports.plugin_type.yml`. Alter hook: `commerce_report_type_info`.

## Built-in report types

| id | Class | Reports |
|---|---|---|
| `order_report` | `Plugin/Commerce/ReportType/OrderReport` | Orders, revenue (sum & avg), customer count, by currency. Fields: order_type_id, amount (commerce_price), mail, billing_address. |
| `order_items_report` | `OrderItemsReport` | Purchased items / products and quantities. |
| `promotion_report` | `PromotionReport` | Promotion usage and discount amounts. |
| `tax_report` | `TaxReport` | Tax collected per period. |

List them live: `\Drupal::service('plugin.manager.commerce_report_type')->getDefinitions()`.

## `ReportTypeInterface` (implement in a new plugin)

`ReportTypeBase` is the base class. Methods to implement/override:

- `buildFieldDefinitions()` — the bundle fields stored per report row (return
  `BundleFieldDefinition`s).
- `generateReports(OrderInterface $order)` — build the values and call
  `createFromOrder($order, $values)` to persist a `commerce_order_report`.
- `buildQuery(QueryAggregateInterface $query)` — add aggregates / `groupBy` for the report
  table (e.g. `$query->aggregate('amount.number', 'SUM')`).
- `buildReportTable(array $results)` (base) via `doBuildReportTableHeaders()` /
  `doBuildReportTableRow()` — render the admin table.
- `getLabel()`, `getDescription()`.

## Add a custom report type

```php
// src/Plugin/Commerce/ReportType/ShippingReport.php
/**
 * @CommerceReportType(
 *   id = "shipping_report",
 *   label = @Translation("Shipping Report"),
 *   description = @Translation("Shipping totals per period")
 * )
 */
class ShippingReport extends ReportTypeBase { /* buildFieldDefinitions, generateReports, buildQuery, doBuild* */ }
```

Clear caches; the new id becomes a `commerce_order_report` bundle and gets its own report page
under `/admin/commerce/reports/shipping_report`.
