<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the best-selling products blocks

## Placement
Place either block via **Structure → Block layout** or in a **Layout Builder** section:
- **Best selling products block** (`best_selling_products_block`) — renders product entities in a view mode.
- **Best Selling Products Statistics** (`best_selling_products_statistics_block`, category *Statistics*) — renders a table of Product ID / Title / Sales Count / link.

## Block settings
| Setting | Applies to | Notes |
|---|---|---|
| Number of products | both | statistics block clamps 1–100 |
| Select Store | both | shown only if `commerce_store` entities exist; `all` = every store |
| Select product bundle | both | `all` or a specific product type |
| Select view mode | list block only | default `teaser` |
| Cache | both | max-age selector; `-1` = Permanent |
| Strict sequences of products | both | adds `ORDER BY product_id DESC` tie-breaker |

## How ranking works
`ProductsService::bestSellingProducts($number, $bundle, $strict_sequences, $store)`:
1. Selects `commerce_product_variation_field_data.product_id`, `COUNT(product_id)`.
2. Joins `commerce_order → commerce_order_item → commerce_product_variation_field_data`.
3. `WHERE commerce_order.state = 'completed'` (+ `store_id` if a store is chosen).
4. `GROUP BY product_id ORDER BY count DESC` (+ `product_id DESC` if strict).
5. Loads each `commerce_product`, keeps **published** ones of the chosen bundle, stops at `$number`, and sets `$product->sales_count`.

Only **completed** orders count toward sales — pending/draft carts are ignored.

## Caveat
The statistics block's render array references `Cache::PERMANENT` without a `use` import; selecting **Permanent** (`-1`) can throw. Use a finite cache lifetime for that block.
