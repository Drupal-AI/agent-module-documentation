<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `commerce` Devel Generate plugin

Class `Drupal\devel_generate_commerce\Plugin\DevelGenerate\CommerceDevelGenerate`
(`src/Plugin/DevelGenerate/CommerceDevelGenerate.php`), extending `DevelGenerateBase` and
implementing `ContainerFactoryPluginInterface`. This is the whole module.

## Install / enable / access

- `ddev drush en devel_generate_commerce -y`. Pulls in Commerce (order, product, checkout, store,
  price), Devel and Devel Generate.
- Admin form: **`admin/config/development/generate/commerce`** (route + access provided by
  devel_generate, gated by the plugin's `permission = "administer devel_generate_commerce"`).
- CLI: `drush devel-generate:commerce` (alias `gencom`). Dev-only tool.

## Plugin annotation & default settings

`@DevelGenerate(id = "commerce", label = "commerce", url = "commerce",
permission = "administer devel_generate_commerce", settings = { … })`. Defaults:

- `kill` = FALSE — delete all existing commerce entities before generating.
- `products_num` = 50, `product_types_num` = 1, `product_variations_num` = 1.
- `product_price_from` = 1, `product_price_max` = 100.
- `orders_num` = 50.
- `time_range` = 604800 (one week, in seconds).

## Dependencies wired in `create()`

`create()` calls `parent::create()` then injects `date.formatter`, `datetime.time` and
`plugin.manager.workflow`. It also resolves a **default store**: `commerce_store` storage
`loadDefault()`; if none exists it **creates and saves** an `online` store (uid 1, name "Default
store", `default_store@example.com`, USD, timezone Australia/Sydney, a random US address, `is_default`
TRUE). So running on a store-less site silently provisions a store.

## Settings form (`settingsForm()`)

Number fields for products (`#min` 0 `#max` 100), product types (0–100), variations per product
(0–10), price-from / price-max (`#min` 1), orders (0–100). A fieldset **Order workflow** lists every
workflow from `workflowManager->getDefinitions()`: a `select` `order_workflow` plus per-workflow
`order_statuses_<id>` checkboxes of that workflow's states (empty selection ⇒ all states used).
`kill` checkbox. `time_range` select with options Now / 1 hour / 1 day / 1 week / 1 month / 1 year
ago (built with `dateFormatter->formatInterval()`).

## Drush command & options

`CommerceDevelGenerateCommand::commerce()` (`src/Commands/…`) extends `DevelGenerateCommands` and
just calls `$this->generate()`; `@pluginId commerce` binds it to this plugin. Options mirror the
settings: `kill` (bool — pass the flag with no value), `products_num` (50), `product_types_num` (1),
`product_variations_num` (1), `product_price_from` (1), `product_price_max` (100), `orders_num` (50),
`time_range` (604800), `order_statuses` (default `'completed'`; a **comma-separated** state list).
Example: `drush devel-generate:commerce --products_num=10 --kill`.

`validateDrushParams()` maps the CLI options into the `$values` array (casting `kill` to bool and
passing `order_statuses` through) that `generateElements()` consumes.

## Generation flow (`generateElements()`)

1. Reads the submitted/CLI values. Order statuses: if `order_statuses` is set (Drush path) it
   `explode(',')`s it; otherwise (UI path) it reads the `order_statuses_<selected workflow>`
   checkboxes, keeping the ticked ones, or **all** of that workflow's states if none ticked.
2. If `kill` → `geleteAllEntities()` [sic].
3. If `product_types_num > 0` → `generateProductTypes()`.
4. If `products_num > 0` → `generateProducts()`.
5. If `orders_num > 0` → `generateOrders()`.

### `geleteAllEntities()` (the `kill` path)

Loads (`loadMultiple()`) and **deletes every** entity of `commerce_product`,
`commerce_product_type`, `commerce_product_variation`, `commerce_product_variation_type` and
`commerce_order`, printing a deleted-count message per type. This wipes ALL such content, not just
previously-generated items.

### `generateProductTypes($n)`

Each: a random word id/label (`getRandom()->word(mt_rand(6,20))`), creates a `commerce_product_type`
(`variationType` = same id, `multipleVariations` TRUE, `injectVariationFields` TRUE), populates
fields via `populateFields()`, saves; then creates the matching `commerce_product_variation_type`
(`orderItemType` `default`, `generateTitle` TRUE, trait `purchasable_entity_shippable`).

### `generateProducts($n, $variations_num, $time_range, $price_from, $price_max)`

Requires ≥1 product type (else a message and return). For each product: random word title, random
existing product type, builds `$variations_num` variations via `generateProductVariations()`, creates
a published `commerce_product` (uid 1, attached to the default store, `created` = request time minus
`mt_rand(0, time_range)`), `populateFields()`, save.

### `generateProductVariations($type, $count, $price_from, $price_max)`

Each variation: `Price(mt_rand($price_from,$price_max), <store default currency>)`, random word
title, `sku` = the product type id (so variations share a SKU), `status` TRUE,
`commerce_stock_always_in_stock` TRUE, `populateFields()`, save; returns the list.

### `generateOrders($n, $time_range, $statuses)`

Loads all `commerce_product_variation`s (message + return if none). For each order: picks a random
variation, `createFromPurchasableEntity()` an order item and saves it; picks a random state from
`$statuses`; creates a `commerce_order` (type `default`, mail = store email, the default store,
that order item, `placed` = request time minus `mt_rand(0,time_range)`); adds a dummy **tax**
`Adjustment` of `Price(mt_rand(0,100), currency)` (`included` TRUE); `recalculateTotalPrice()`; save.

## Operational notes

- Everything is created as **uid 1** / the default store; titles/SKUs are random words, so generated
  data is not meant to look production-realistic.
- `kill` is destructive across ALL commerce products/types/variations/orders — never run on a store
  with real data.
- No config object or schema is written; the annotation `settings` are the defaults Devel Generate
  persists for the plugin.
