<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Feeds wires Drupal Commerce into the Feeds module so you can bulk-import Commerce products (and their prices, weights, and dimensions) from CSV, XML, JSON, or RSS sources through a Feeds feed type.

---

The module is a small bridge with no configuration UI of its own: it contributes Feeds plugins that appear when you build a Feeds feed type. Its `ProductProcessor` registers a Feeds processor with id `entity:commerce_product` ("Product"), letting a feed create/update `commerce_product` entities the same way core Feeds creates nodes. Alongside it are three configurable `@FeedsTarget` field mappers for Commerce's specialised field types: `commerce_feeds_price` maps an incoming number to a `commerce_price` field, adding a per-target **Currency** select whose code is stamped onto every imported value; `commerce_feeds_physical_measurement` maps a number to a `physical_measurement` field (e.g. product weight) with a **Unit** select; and `commerce_feeds_physical_dimensions` maps length/width/height to a `physical_dimensions` field with a shared unit. The measurement and dimensions targets require the `drupal/physical` module (they map its field types). You use it entirely through Feeds' own UI (`/admin/structure/feeds`): create a feed type, pick the Product processor, map source columns to product fields and to these targets, then import files or fetch remote URLs. It provides no permissions, no Drush commands, no services, and no config schema of its own — all runtime behaviour is inherited from Feeds and Commerce.

---

- Bulk-import a product catalog from a supplier CSV into `commerce_product` entities.
- Map a price column to a `commerce_price` field and stamp every row with a chosen currency (e.g. USD).
- Keep product data in sync by re-running a feed that updates existing products by SKU/GUID.
- Import product weight into a `physical_measurement` field with a fixed unit (kg, lb).
- Import package length/width/height into a `physical_dimensions` field for shipping calculations.
- Load products from a remote vendor URL on a schedule using Feeds' periodic import.
- Migrate a legacy store's product list into Commerce without writing custom migration code.
- Populate a staging site with sample products from a spreadsheet.
- Import products of a specific product type (bundle) by targeting its fields in the mapping.
- Set the product title, body, and SKU-bearing fields from feed columns.
- Combine a CSV parser with the Product processor for a one-off catalog load.
- Combine an XML/JSON parser with the Product processor to consume a PIM export.
- Re-price a whole catalog by re-importing a price column under a different currency target.
- Expire or delete products that disappear from the source feed (Feeds "update non-existent" handling).
- Schedule nightly product refreshes via Feeds import period + cron.
- Import multiple currencies by adding one price target per currency-specific column.
- Seed products for automated tests from a fixture CSV.
- Onboard a drop-shipping catalog supplied as a feed.
- Standardise measurement units across imported products via the target's Unit setting.
- Map a source column to product attributes/reference fields alongside price and physical data.
- Give non-developers a UI-driven way to load products by uploading a file.
- Back a data-warehouse-to-storefront pipeline that emits CSV/JSON product rows.
- Keep base units consistent by relying on each measurement target's default base-unit configuration.
- Convert a marketing team's product spreadsheet into live storefront products.
- Rebuild a catalog after a platform migration from exported product data.
