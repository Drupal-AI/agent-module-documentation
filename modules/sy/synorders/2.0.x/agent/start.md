<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synorders — agent start

Vendor-specific (SynapseF / Synapse suite) Commerce order-reporting module. Release **2.0.6**
(version dir `2.0.x`). Core `^11 || ^12`. Requires `phpoffice/phpspreadsheet ^5.9`. No settings
form, no permissions file, no Drush, no plugin types.

What it actually does: ships a Views config `cml_orders` whose **page** display is at `/orders` and
lists Commerce orders joined to each customer (order number, the custom user fields
`field_user_name` / `field_user_surname` / `field_user_phone`, email, created, total price) with
exposed filters. A `views_pre_view` hook injects a **"Download Excel"** header link pointing at
`/orders-xls`; that route's controller re-runs the view with the same exposed input and streams an
`orders.xlsx` export built with PhpSpreadsheet.

- The `cml_orders` view, its `/orders` page, fields, filters and access → [views/cml-orders.md](views/cml-orders.md)
- The `/orders-xls` export route, `SynordersController` and the `views_pre_view` link hook → [routes/export.md](routes/export.md)

Gotchas:
- **Undeclared hard deps.** `synorders.info.yml` lists **no** `dependencies`, but the `cml_orders`
  view depends on `commerce`, `commerce_order`, `commerce_price`, `state_machine`, `user` and three
  custom user fields (`field_user_name/surname/phone`). Those must exist first or the view/export
  fail. (This is why this version was documented from source, not test-enabled.)
- **Install side effect.** `synorders_install()` grants `administer commerce_order` to the `editor`
  role; `synorders_uninstall()` revokes it.
- Both `/orders` and `/orders-xls` are gated by `administer commerce_order`.
- Export is capped at the first 1000 result rows; the `operations` column is excluded; cell values
  are `strip_tags()`-ed.
- `synorders.links.menu.yml` adds an **Orders** link (menu `editor`) to `internal:/orders`.
- README is stale (claims "Drupal 8-10 / PHP 7.4", "no extra settings, nothing about Excel");
  trust the source and `composer.json` ("Export the CML orders view to an Excel workbook.").
