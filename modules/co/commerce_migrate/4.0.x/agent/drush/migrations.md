<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_migrate — running migrations

There are no routes or drush commands *of its own*; you drive it with **Migrate Tools** (`drush/migrate_tools`) plus a configured source.

Typical flow:
1. Enable the base module and the submodule for your source, e.g. `drush en commerce_migrate_ubercart` or `commerce_migrate_shopify`.
2. Configure the source:
   - **Ubercart / Commerce 1**: add a legacy `migrate` source database connection in `settings.php` (a `$databases['migrate']['default']` key) pointing at the old Drupal DB.
   - **Magento / Shopify / WooCommerce**: export CSVs and set their file paths in the migration source config (migrate_plus CSV source), often via a migration group / config entity.
3. List migrations: `drush migrate:status` (or `--group=...`).
4. Import: `drush migrate:import <migration_id>` (or `--group=commerce_migrate_ubercart --all`).
5. Roll back: `drush migrate:rollback <migration_id>`.

Order matters: dependencies (customers, product attributes, product variations, products, then orders) are declared via `migration_dependencies`; running `--all` for a group resolves them. The `MigrateProduct`/`MigrateOrder` post-row-save subscribers attach variations/order-items after each product/order row is saved.

Because sources are legacy DBs/CSVs supplied by the operator, treat unserialized legacy field data as trusted-but-verify: it is CLI-driven, not request input.
