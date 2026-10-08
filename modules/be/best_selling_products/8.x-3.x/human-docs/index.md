# Best selling products — manual setup guide

**Best selling products** (`best_selling_products`) provides two
[Drupal Commerce](https://www.drupal.org/project/commerce) blocks that rank and
display a store's best-selling products, worked out from actual completed orders.

The module counts sales by looking at completed Commerce orders — it joins the
order, order-item and product-variation data, keeps only orders in the
**completed** state, groups by product, and orders by how many times each was
purchased. Pending or draft carts do not count, so the numbers reflect real
sales. Results are loaded as products, limited to **published** ones of the type
you choose, and tagged with a sales count.

The two blocks are:

- **Best selling products block** — renders the top products on your storefront in
  a view mode you pick (teaser by default). Good for a "bestsellers" area on the
  homepage or a category page.
- **Best Selling Products Statistics** — an admin-facing table of product ID,
  title, sales count, and a link to each product, useful for comparing how
  products sell.

Both blocks are placed and configured like any other block, so you control how
many products to show, which store and product type to count, the view mode, and
how long the result is cached.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact ranking
query — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Drupal Commerce required).
2. [Configuration](configuration/index.md) — place the blocks and set their
   options.

## Where it lives in the admin menu

Best selling products has no central settings page — everything is configured on
the blocks themselves. Place them through **Structure → Block layout**
(`/admin/structure/block`) or in a **Layout Builder** section, and set each
block's options in its placement form. See [Configuration](configuration/index.md).
