<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Viewing & (re)generating reports

There is **no settings form** (`configure: null`). You interact through report pages, a
generate form, and two Views.

## Routes / UI

| Route | Path | Permission | What |
|---|---|---|---|
| `commerce_reports.overview` | `/admin/commerce/reports` | `access commerce reports` | Landing page listing the report types (a menu block). |
| `commerce_reports.report` | `/admin/commerce/reports/{report_type_id}/{type}` | `access commerce reports` | The report table for one report type; `{type}` = grouping, default `month` (also `day` / `year`). Rendered by `ReportTable::viewReport()`. |
| `commerce_reports.configuration` | `/admin/commerce/config/reports` | `access commerce administration pages` | Config landing (menu block). |
| `commerce_reports.generate_form` | `/admin/commerce/config/reports/generate-reports` | `generate commerce order reports` | **Generate reports** form. |

Menu link `commerce_reports:sales_report` points the "Sales" item at the `sales_report` View.

## Generate / rebuild reports

`OrderReportGenerateForm` at `/admin/commerce/config/reports/generate-reports` **deletes
existing order reports and recreates them** for one report type or all, batching over
historical orders. Use it after installing the module (so past orders get reports) or after
adding/altering a report type. Programmatic equivalent:
`\Drupal::service('commerce_reports.order_report_generator')->refreshReports($order_ids, $plugin_id)`.

Note: new reports are otherwise created automatically when an order is *placed* (see
`api/entity-and-generator.md`), so the generate form is mainly for backfilling/rebuilding.

## Shipped Views (`config/install`)

- `sales_report` (`view.sales_report.monthly`) — sales over the `commerce_order_report` table.
- `purchased_items_report` — purchased items/products.

Both can be cloned/exposed for custom dashboards or data export. Views field/sort plugins:
`commerce_reports_report_date_field`, `PriceNumericField`, and the `ReportDate` sort.
