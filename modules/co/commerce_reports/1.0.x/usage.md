<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Reporting generates and displays sales, product, tax, and promotion reports for Drupal Commerce. When an order is placed it records report entities, and it renders aggregated report tables and Views under the store's Reports section.

---

The module adds a `commerce_order_report` content entity whose **bundles are plugins** of a report-type plugin type (`commerce_report_type`). It ships four report types out of the box — `order_report` (orders, revenue, customers), `order_items_report` (purchased items/products), `promotion_report` (promotion usage), and `tax_report` (tax collected) — each a plugin that defines its own bundle fields, an aggregate query (`buildQuery`), and a report-table renderer. Report data is captured automatically: an event subscriber listens for the `commerce_order.place.post_transition` (order placed) event, and on request destruction the `OrderReportGenerator` service creates a `commerce_order_report` of each report type for those orders. Admins view the results at `/admin/commerce/reports` (permission `access commerce reports`), where each report type renders a month/day/year-grouped table (`ReportTable` controller), and via two shipped Views, `sales_report` and `purchased_items_report`, over the report entity. A "Generate reports" admin form (`/admin/commerce/config/reports/generate-reports`, permission `generate commerce order reports`) deletes existing reports and rebuilds them for one or all report types from historical orders. Developers extend it by adding a new `@CommerceReportType` plugin. Requires Commerce (`commerce`, `commerce_price`, `commerce_order`) and Views.

---

- Show monthly sales totals (order count, customers, revenue) for a Commerce store.
- Break revenue down by currency in the order report table.
- Report on which products/items were purchased and in what quantities.
- Track promotion/coupon usage and the discount amounts they generated.
- Report tax collected across orders for accounting.
- Automatically record a report entry whenever an order is placed (no manual step).
- Rebuild all historical reports after installing the module via the "Generate reports" form.
- Regenerate reports for a single report type only.
- View reports grouped by month, day, or year via the report route's {type} argument.
- Expose sales data as a Drupal View (sales_report) for custom dashboards or exports.
- List purchased items as a View (purchased_items_report) for merchandising analysis.
- Restrict who can see store reports with the "access commerce reports" permission.
- Restrict who can regenerate reports with the "generate commerce order reports" permission.
- Add a custom report type (e.g. shipping or refunds) by writing a CommerceReportType plugin.
- Store per-order snapshot data (total, email, billing address) at time of placement for reporting.
- Aggregate average order value alongside total revenue per period.
- Build a store owner dashboard combining the sales and purchased-items Views.
- Analyze customer counts per period from the order report.
- Feed report Views into charts via a charting module.
- Provide finance teams a tax report per month for filing.
- Compare revenue across order types using the stored order_type_id.
- Refresh a specific order's reports after data changes via the generator's refreshReports().
- Keep reporting data separate from live orders in a dedicated commerce_order_report entity.
- Extend reporting with new aggregate columns by overriding a report type's buildQuery().
