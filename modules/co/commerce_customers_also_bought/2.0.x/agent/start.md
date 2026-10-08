<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Customers Also Bought (commerce_customers_also_bought) — agent index

A "customers also bought" cross-sell **block** for Drupal Commerce. On a product page it finds other
products that appear in **completed** orders alongside the product being viewed, then renders a
configurable number of them in a chosen product view mode. Package `Commerce`. Core
`^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Installed **2.0.1** (version dir `2.0.x`).
Maintainer: Goran Nikolovski (gnikolovski).

## Dependencies

- Drupal modules (from `.info.yml`): **`block`** (core) and **`commerce`** (Drupal Commerce). Both
  required. NOTE: `composer.json` only requires `drupal/core` — it does NOT list `drupal/commerce`,
  so Commerce must already be present (Drupal will refuse to enable the module without it).
- No third-party PHP/JS libraries. No `.permissions.yml`, no routes, no services file, no
  install/update hooks.

## What it provides (from source)

- **Block plugin** `commerce_customers_also_bought_block`
  (`src/Plugin/Block/CustomersAlsoBoughtBlock.php`, admin label "Customers also bought"). This is the
  entire feature surface — place it via `/admin/structure/block`.
- **Theme hook** `customers_also_bought` (`.module`, `hook_theme()`), template
  `templates/customers-also-bought.html.twig` — a `<div class="commerce-customers-also-bought-block">`
  that loops `{{ product }}` render arrays.
- **Config schema** `block.settings.commerce_customers_also_bought_block`
  (`config/schema/...schema.yml`): `view_mode` (string), `number_of_products` (integer), `max_age`
  (string).

## How it works (build())

1. Reads the current route's `commerce_product` parameter (if any) and the block config
   `number_of_products`; computes an internal candidate pool size `number_of_items = number_of_products * 10`.
2. Query: `SELECT co.order_id FROM commerce_order co LEFT JOIN commerce_order_item coi ... LEFT JOIN
   commerce_product_variation_field_data pvfd ... WHERE co.state = 'completed'` — plus
   `pvfd.product_id = <current product id>` **only when viewing a product page** — grouped by
   `order_id`, ordered by `co.created DESC`, limited to `number_of_items` rows. Built entirely with the
   Drupal DB query builder (parameterized).
3. Loads each matched order, iterates its order items, resolves each purchased variation → product,
   and collects the product id **only if the product `isPublished()`**. On the product canonical route
   it also excludes the product currently being viewed.
4. `getRandomProducts()` de-duplicates the collected ids and picks `number_of_products` of them at
   **random** (`mt_rand`), loads those products, and `getRenderedProducts()` renders each with the
   configured view mode via the `commerce_product` view builder.
5. If there are no candidate products, `build()` returns `[]` (block renders nothing).

Off a product page (no `commerce_product` route param) there is no product filter, so candidates are
drawn from all completed orders — effectively a random published-product block.

## Configuration (block settings form)

- **view_mode** — select of `commerce_product` view modes; view mode used to render each product.
- **number_of_products** — required integer; how many products to display.
- **max_age** — cache max-age select (No caching … 1 week … Permanent `-1`); default `172800` (2 days).

Cache: `getCacheContexts()` adds `url`; `getCacheTags()` adds `commerce_product_list`;
`getCacheMaxAge()` merges the configured `max_age`. (The random pick is frozen for the cache lifetime
per URL.)

## Solution docs

- **Block plugin, query, config, caching, theming** →
  [blocks/customers-also-bought-block.md](blocks/customers-also-bought-block.md)
