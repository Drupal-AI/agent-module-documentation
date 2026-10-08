<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Best selling products (best_selling_products) — agent index

**Two Drupal Commerce blocks that rank products by completed-order sales counts.**

- **Version:** 8.x-3.x
- **Core:** ^9.4 || ^10 || ^11
- **Depends on:** commerce, commerce_order, commerce_product
- **Service:** `best_selling_products.products` (`ProductsService::bestSellingProducts()`) — joins `commerce_order` / `commerce_order_item` / `commerce_product_variation_field_data`, filters `state = completed`, groups + orders by purchase count.
- **Blocks:** `best_selling_products_block` (rendered products, chosen view mode) and `best_selling_products_statistics_block` (Statistics category; ID/title/sales-count table).
- **Block config:** number_of_products, store, bundle, view_mode, max_age, strict_sequences.
- **Routes/permissions:** none (block placement only).

**Security:** no routes or permissions; the sales query uses the DB API with bound conditions (no raw SQL concatenation) and lists only published products. Bug: statistics block uses an unimported `Cache::PERMANENT` — a "Permanent" cache selection can fatal.

See [configure/blocks.md](configure/blocks.md)
