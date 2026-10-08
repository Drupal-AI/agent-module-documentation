# Configuration

Commerce Reporting has no settings form to fill in. Instead you work with report
pages, a one-off "generate" tool for backfilling, and a couple of Views — all
under the store's admin area. Reports are created automatically as orders are
placed; the pages below are where you read and rebuild them.

## Permissions

Two permissions control access (grant them under **People → Permissions**):

- **Access commerce reports** — view the report pages under **Commerce →
  Reports**.
- **Generate commerce order reports** — use the Generate reports form to rebuild
  report data.

Give reporting access to store managers and finance staff; keep the regenerate
permission to administrators, since regenerating deletes and rebuilds the data.

## View the reports

Go to **Commerce → Reports** (`/admin/commerce/reports`). The landing page lists
the available report types. Open one to see its table, which is grouped by
**month** by default; you can also group by **day** or **year**. The built-in
report types are:

- **Order report** — order count, customer count and revenue per period (broken
  down by currency where relevant, with average order value alongside total
  revenue).
- **Purchased-items report** — which products and items were bought and in what
  quantities.
- **Promotion report** — promotion and coupon usage and the discounts generated.
- **Tax report** — tax collected across orders, for accounting.

## Backfill / rebuild with the Generate reports form

New reports are recorded automatically whenever an order is placed, so after
installation you mainly need this tool **once** — to create reports for orders
that existed before the module was installed.

Go to **Commerce → Configuration → Reports → Generate reports**
(`/admin/commerce/config/reports/generate-reports`). The form **deletes the
existing order reports and rebuilds them** — for all report types or for a single
one you choose — batching over your historical orders. Use it after installing
the module, or after adding or changing a report type. (There is also a
programmatic equivalent via the report generator service, covered in the
[`agent/`](../agent/start.md) docs.)

## The shipped Views

Two of the reports are also provided as Views over the report data, which you can
clone, filter, expose or export for custom dashboards:

- **`sales_report`** — sales over the order-report data (the "Sales" menu item
  points here).
- **`purchased_items_report`** — purchased items/products, useful for
  merchandising analysis.

Because they are ordinary Views, you can feed them into a charting module or
build a store-owner dashboard by combining them.

## Extending

Developers can add a new report type (for example shipping or refunds) by writing
a `@CommerceReportType` plugin — see the [`agent/`](../agent/start.md) docs.
