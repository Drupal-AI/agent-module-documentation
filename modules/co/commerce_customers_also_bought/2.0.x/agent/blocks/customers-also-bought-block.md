<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customers Also Bought block

`src/Plugin/Block/CustomersAlsoBoughtBlock.php` — `@Block(id =
"commerce_customers_also_bought_block", admin_label = "Customers also bought")`. Extends `BlockBase`,
implements `ContainerFactoryPluginInterface`. Injected services: `entity_display.repository`,
`entity_type.manager`, `current_route_match`, `database`. This block is the module's entire feature
surface; place it via **Structure → Block layout** (`/admin/structure/block`).

## Configuration

`defaultConfiguration()` sets only `max_age => 172800`. `blockForm()` adds:

- `view_mode` — `select` built from `entityDisplayRepository->getViewModes('commerce_product')`.
- `number_of_products` — `number`, `#required = TRUE`. Number of products to display.
- `max_age` — `select`: `0` (No caching), `1800`, `3600`, `21600`, `43200`, `86400`, `172800`
  (default), `432000`, `604800`, `-1` (Permanent). Seconds of block cache max-age.

`blockSubmit()` writes `number_of_products`, `view_mode`, `max_age` into block config. Schema:
`block.settings.commerce_customers_also_bought_block` (`view_mode`/`number_of_products`/`max_age`).

## build() logic

1. `route_name = current_route_match->getRouteName()`; `product = getParameter('commerce_product')`.
2. `number_of_items = number_of_products * 10` (candidate pool multiplier).
3. Query (DB API query builder — parameterized, no raw SQL):

   ```
   SELECT co.order_id
   FROM commerce_order co
   LEFT JOIN commerce_order_item coi ON co.order_id = coi.order_id
   LEFT JOIN commerce_product_variation_field_data pvfd ON coi.purchased_entity = pvfd.variation_id
   WHERE co.state = 'completed'
     [ AND pvfd.product_id = :current_product_id ]   -- only when a product is in the route
   GROUP BY co.order_id
   ORDER BY co.created DESC
   LIMIT number_of_items
   ```

   The `product_id` condition is added only if the route carried a `commerce_product`. Off a product
   page there is no filter → candidates from all completed orders.
4. For each returned `order_id`: load the `commerce_order`, iterate `getItems()`, resolve each
   `getPurchasedEntity()` (variation) → `getProduct()`. Collect the product id **only when
   `$variation_product->isPublished()`**. On `entity.commerce_product.canonical`, skip the product
   currently viewed.
5. If any ids: `getRenderedProducts()` → `getRandomProducts()` de-duplicates ids and picks
   `number_of_products` at random (`mt_rand` + `array_splice`), loads each product, and renders it with
   the `commerce_product` view builder in the configured `view_mode`. Result themed as
   `#theme => 'customers_also_bought'` with `#products` (array of render arrays).
6. No candidates → `build()` returns `[]`.

## Caching

- `getCacheContexts()` → parent + `url` (varies per URL/product page).
- `getCacheTags()` → parent + `commerce_product_list` (invalidated when product list changes).
- `getCacheMaxAge()` → parent merged with configured `max_age`.

Because the pick is random but the render is cached per URL, the displayed set is effectively frozen
for the `max_age` window on each product page.

## Theming

`hook_theme()` (`.module`) registers `customers_also_bought` with a `products` variable. Template
`templates/customers-also-bought.html.twig` outputs
`<div class="commerce-customers-also-bought-block">` and loops `{{ product }}` over the rendered
products. Override the template or target the wrapper class for styling.
