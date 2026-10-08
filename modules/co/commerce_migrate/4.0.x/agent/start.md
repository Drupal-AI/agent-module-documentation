<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Migrate (commerce_migrate) — agent index

**Migrate API handlers + per-platform migrations to import stores/products/orders/customers into Drupal Commerce 2.**

- **Version:** 4.0.x (info.yml `4.0.1`)
- **Core:** >=9.3 || 10 (Drupal 10 contrib; no D11 release)
- **Dependencies:** `migrate` (core), `telephone` (core), `migrate_plus`.
- **Submodules:** `commerce_migrate_commerce`, `_ubercart`, `_magento`, `_shopify`, `_woocommerce`, `_csv_example`.
- **Services:** event subscribers `commerce_migrate.migrate_product` (`MigrateProduct`), `commerce_migrate.migrate_order` (`MigrateOrder`); helper `Utility::classInArray()`.
- **Run via:** Migrate Tools drush (`migrate:import/status/rollback`) or migrate UI against a legacy source DB / CSV files.

**Security:** operator/CLI tooling — no routes, permissions, or public endpoints. Source data (incl. legacy serialized fields) comes from operator-supplied databases/CSVs, not web requests.

See [drush/migrations.md](drush/migrations.md).
