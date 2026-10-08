<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Migrate provides Migrate API source/process handlers and ready-made migrations to move a store — products, variations, orders, customers, taxonomies — into Drupal Commerce 2 from Ubercart, Commerce 1, Magento, Shopify and WooCommerce.

---

The base module supplies shared Commerce-specific Migrate infrastructure: two event subscribers (`MigrateProduct`, `MigrateOrder`) that run after row save to wire up product variations and order items, and a small `Utility::classInArray()` helper. It depends on core `migrate`, `telephone`, and `migrate_plus`. The real work lives in per-platform submodules under `modules/`: `commerce_migrate_commerce` (Commerce 1 → 2), `commerce_migrate_ubercart`, `commerce_migrate_magento`, `commerce_migrate_shopify`, `commerce_migrate_woocommerce`, plus a `commerce_migrate_csv_example`. Each provides migration plugins and definitions for its source format (a legacy Drupal database for Ubercart/Commerce 1, or CSV exports for the SaaS platforms via migrate_plus source plugins).

Migrations are an operator/CLI task, run with Migrate Tools drush commands (`drush migrate:import`, `migrate:status`) or the migrate UI, pointed at a configured legacy source database or CSV files. This is developer/administrator tooling, not a request-facing feature: there are no routes, permissions, or public endpoints, and the source data (including any legacy serialized fields) originates from files/databases the operator supplies, not from web requests. Read the submodule READMEs for the exact source setup (source DB key, CSV paths) before importing.

---

- Migrate a full Ubercart store into Drupal Commerce 2
- Upgrade a Drupal Commerce 1 site to Commerce 2
- Import products and variations from a Magento CSV export
- Import a Shopify catalog and orders from CSV
- Import WooCommerce products/orders from CSV
- Migrate customers and their profiles/addresses
- Migrate orders and order line items
- Migrate product attributes and variation types
- Migrate stores and store configuration
- Use migrate_plus CSV source plugins for SaaS platforms
- Run imports with drush migrate:import
- Check migration progress with migrate:status
- Roll back an import with migrate:rollback
- Map legacy taxonomies to Commerce product categories
- Start from the CSV example submodule as a template
- Migrate prices, currencies and tax data
- Stub and re-run partial migrations during development
- Wire product variations automatically via the MigrateProduct subscriber
