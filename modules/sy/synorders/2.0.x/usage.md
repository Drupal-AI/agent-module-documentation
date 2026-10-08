<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Synorders adds a Commerce-backed orders Views page at `/orders` and a one-click export of the filtered orders to an Excel (.xlsx) workbook.

---

Synorders is a **vendor-specific (SynapseF) module** in the Synapse e-commerce suite. It ships a Views
configuration, `cml_orders`, whose **page** display lives at `/orders` and lists Commerce orders joined to
each customer's account — order number, the user's custom name/surname/phone fields, email, created date and
total price — with exposed filters (order number, name, surname, phone, email, order state). A
`views_pre_view` hook injects a **"Download Excel"** header link into that view; the link points at the
`/orders-xls` route, carrying the current exposed-filter query. That route's controller re-executes the
`cml_orders` view with the same exposed input, flattens the fields to a grid, writes an `orders.xlsx`
workbook with PhpSpreadsheet, and returns it as a file download.

Both `/orders` (view access) and `/orders-xls` (route) are gated by the `administer commerce_order`
permission. The module's install hook **grants `administer commerce_order` to the `editor` role** (and
revokes it on uninstall). The module has no settings form and no `dependencies` declared in its info file,
yet its `cml_orders` view hard-depends on Commerce (`commerce`, `commerce_order`, `commerce_price`,
`state_machine`) plus three custom user fields (`field_user_name`, `field_user_surname`,
`field_user_phone`) — so the site must provide those before the view/export will work. The export is capped
at the first 1000 result rows and the `operations` column is dropped. Requires `phpoffice/phpspreadsheet`
`^5.9`; core `^11 || ^12`.

---

- Expose a Commerce orders listing page at `/orders`.
- List orders with customer name, surname, phone, email, created date and total price.
- Filter orders by order number via the exposed form.
- Filter orders by customer first name.
- Filter orders by customer surname.
- Filter orders by customer phone number.
- Filter orders by customer email.
- Filter orders by order state (defaults to `completed`).
- Export the currently-filtered orders to an `.xlsx` workbook.
- Add a "Download Excel" link into the orders view header.
- Carry the active view filters through to the export.
- Download up to the first 1000 order rows per export.
- Build the workbook with PhpSpreadsheet (`phpoffice/phpspreadsheet ^5.9`).
- Reuse the view's column labels as the spreadsheet header row.
- Strip HTML markup from exported cell values.
- Serve the export via `administer commerce_order` permission.
- Grant `administer commerce_order` to the `editor` role on install.
- Provide a vendor (SynapseF/Synapse suite) order-reporting tool.
- Pair with the suite's other order/cart modules.
- Give shop editors a quick order-export for back-office reporting.
- REVIEW where the generated workbook is written and who can read it before relying on it.
- Verify the custom user fields and Commerce order type exist before enabling.
