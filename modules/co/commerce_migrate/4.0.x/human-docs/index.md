# Commerce Migrate — manual setup guide

**Commerce Migrate** (`commerce_migrate`) is a migration framework, built on
Drupal's core **Migrate** API, for bringing an existing store — products,
variations, orders, customers, taxonomies, prices, currencies, and tax data — into
**Drupal Commerce 2**. It provides the Commerce-specific glue (field handlers for
price and reference fields, destination plugins for Commerce product types,
stores, and profiles) plus ready-made migrations for several source platforms.

The base module by itself doesn't migrate anything visible; the real work lives in
its **submodules**, one per source platform. The most mature paths are **Drupal
Commerce 1 → 2** (`commerce_migrate_commerce`) and **Ubercart 6/7 → Commerce 2**
(`commerce_migrate_ubercart`), which read directly from the old Drupal database.
Experimental, CSV-based starting points exist for **Magento 2**
(`commerce_migrate_magento`), **Shopify** (`commerce_migrate_shopify`), and
**WooCommerce** (`commerce_migrate_woocommerce`), plus a
`commerce_migrate_csv_example` template to learn from.

Running a migration is an **operator / command-line task**, not something you
click through in the UI and not a request-facing feature — there are no routes,
permissions, or public endpoints. You point the tooling at a legacy source
database or CSV exports and drive it with Drush (via **Migrate Tools**). Because
the source data comes from files and databases you supply, it is trusted input
rather than web input. Note this is a **Drupal 10** release (there is no Drupal 11
release), it is **minimally maintained**, and importing from the SaaS platforms
(Magento/Shopify/WooCommerce) requires exporting your data to CSV first.

This guide is written for a **human** running the migration. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodule for your source platform.

There is **no configuration page** for this module — you configure a migration
through a source database connection (in `settings.php`) or CSV source paths, and
run it from the command line, as described below.

## Where it lives

Commerce Migrate has no admin menu presence of its own. For database-backed
sources (Ubercart / Commerce 1) you may be able to use core's **Migrate Drupal
UI**, but most migrations are run with Drush.

## How to use it

1. Enable the submodule for your source, for example
   `drush en commerce_migrate_ubercart -y` or `commerce_migrate_shopify`.
2. Point it at the source data:
   - **Ubercart / Commerce 1** — add a legacy `migrate` source database
     connection in `settings.php` (a `$databases['migrate']['default']` entry)
     that points at the old Drupal database. For Drupal 8.9+, also set
     `migrate_node_migrate_type_classic` to `TRUE` in `settings.php`, because
     Commerce Migrate needs the classic node migrations rather than the default
     complete node migrations.
   - **Magento / Shopify / WooCommerce** — export your data to CSV and set the
     file paths in the migration source configuration (a migrate_plus CSV source,
     often via a migration group).
3. List the available migrations: `drush migrate:status`
   (or `--group=commerce_migrate_ubercart`).
4. Run the import: `drush migrate:import <migration_id>`, or import a whole group
   with `--group=… --all`, which resolves the dependency order (customers →
   product attributes → variations → products → orders) for you.
5. If something goes wrong, roll back with
   `drush migrate:rollback <migration_id>` and re-run.

Read each submodule's README for the exact source-setup details before importing.
