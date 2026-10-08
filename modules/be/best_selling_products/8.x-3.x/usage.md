<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Best selling products provides two Drupal Commerce blocks that rank and display a store's best-selling products, computed from completed order line items.

---

The module's `ProductsService` (`best_selling_products.products`) runs a database query that joins `commerce_order`, `commerce_order_item`, and `commerce_product_variation_field_data`, filters to orders in the `completed` state (optionally scoped to one store), groups by product, and orders by purchase count descending; results are loaded as `commerce_product` entities, filtered to published products of the chosen bundle, and annotated with a `sales_count`. Two block plugins consume it: `best_selling_products_block` renders the top products in a chosen view mode (teaser by default), and `best_selling_products_statistics_block` (category "Statistics") renders a table of product ID, title, sales count, and a link to each product. Both blocks expose a config form for number of products, store, product bundle, view mode (list block only), a cache max-age selector, and a "strict sequences" tie-breaker.

Typical setup is to place either block through Block layout or Layout Builder on your shop pages and set the count, store, bundle, and cache lifetime; the module needs Drupal Commerce and no other configuration. The sales query is built with the Drupal database API using bound conditions (no raw SQL concatenation), and product listing respects the published flag. Note that the statistics block references a `Cache` constant without importing it, so a permanent (-1) cache selection can error — prefer a finite max-age there.

---
- Show a "best sellers" block of top products on the storefront.
- Display the top 5 (or N) products by completed-order sales.
- Render bestsellers using the teaser view mode.
- Render bestsellers in a custom product view mode.
- Limit bestsellers to a single Commerce store.
- Limit bestsellers to a specific product type/bundle.
- Show a sales-statistics table with per-product sales counts.
- Link each statistics-table row to its product page.
- Cache the block for a chosen lifetime (30 min to 1 week).
- Disable caching for near-real-time bestseller data.
- Add a strict tie-breaker so equal-sales products order deterministically.
- Place the block in a sidebar via Block layout.
- Place the block in a Layout Builder section.
- Feature top products on the homepage.
- Cross-sell bestsellers on category pages.
- Show bestsellers across all stores in a multi-store setup.
- Compare sales counts of products in an admin-facing table.
- Surface only published products (drafts are excluded automatically).
- Adjust how many products appear without code changes.
- Combine a bestseller block with a manual promotions block.
