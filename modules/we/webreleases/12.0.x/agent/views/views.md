<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `products` and `releases` Views

Two Views ship in `recipes/default/config/views.view.products.yml` and `views.view.releases.yml`.
Both query `node_field_data`, filter to published (`status = 1`), filter by bundle, sort by
`created` DESC, and gate access with the **`access content`** permission (standard published-node
access; no `accessCheck`-off queries). Rows render nodes through the module's view modes.

## `products` — Products
Bundle filter `type = product`. Fields: `title` (linked to entity), `body` (trimmed summary, 300
chars), `field_image` (media thumbnail, `medium` image style, lazy). Style: 2-column grid, teaser
row, full pager at 9 per page.

Displays:
- **Products page** (`products_page`, path **`/products`**) — header "Browse our products and their
  releases.", empty text "No products yet." This is the page the main-menu "Products" link targets.
- **Products Block** (`products_block`) — placeable block version.
- Default display title "Products block".

## `releases` — Releases
Bundle filter `type = release`. Contextual filter (argument) **`field_product_target_id`** (numeric)
with a `node` default argument, so the page derives the product from the URL. A `field_product`
relationship joins the parent product. Field: `title` (linked to entity). Sort `created` DESC.

Displays:
- **Releases page** (`releases_page`, path **`products/%node/releases`**) — grid, full pager 9/page,
  view mode `teaser`. The `%node` is the product node; combined with the contextual filter it lists
  only that product's releases. Reached by pretty alias via the path processor (see
  [../routing/urls.md](../routing/urls.md)).
- **Releases** block (`releases_block`) — view mode `product_release` (does not repeat the product),
  full pager 9/page; intended for the product page.
- **Latest releases** block (`latest_releases_block`) — product-scoped via the same argument +
  relationship.
- **Title releases** block (`title_releases_block`) — compact `html_list` (`ul`), `archive` view
  mode, 10 items, footer with an admin-authored "All releases" link (`full_html`, static — not
  tokenized at render).

## Operating
The Views appear once content exists and is published. Place the block displays via Block layout or
in a Display Builder layout. The releases page/block only show releases whose `field_product`
matches the product in context.
