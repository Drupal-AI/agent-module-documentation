<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrations: source & process plugins, product_uuid join, entity hooks

## Migration set (config)

`config/install/` (the `cml` group, auto-run): `cml_taxonomy_catalog`, `cml_taxonomy_stores`,
`cml_taxonomy_prices`, `cml_product_variation`, `cml_product_variation_attribute`, `cml_product`.
`config/optional/` (installed on demand / with structure): `cml_product_image`,
`cml_product_variation_price`, `cml_product_variation_rest`, `cml_taxonomy_terms`, and a separate
**`cml_scheme`** group (`cml_scheme_product`, `cml_scheme_vocabulary`). Groups:
`migrate_plus.migration_group.cml` and `.cml_scheme`.

Example — `cml_product` (`config/install/migrate_plus.migration.cml_product.yml`): source
`cml_commerce_product`, destination `entity:commerce_product`, `migration_dependencies.required` =
`cml_taxonomy_catalog`, `cml_taxonomy_stores`, `cml_product_variation`; `process` maps `type`,
`stores`, `title`, `status`, `uuid`, `body`, `field_catalog` (skip_on_empty → `migration_lookup`
into `cml_taxonomy_catalog`), `variations` (skip_on_empty → **`multi_target`**), `field_article`,
`field_image`, `field_gallery`.

## Source plugins (`src/Plugin/migrate/source/`)

All 12 extend **`Utility/MigrationsSourceBase`** (`SourcePluginBase` +
`ContainerFactoryPluginInterface`). IDs use the `cml_commerce_*` / `cml_tx_*` / `cml_scheme_*`
namespace. `MigrationsSourceBase`:
- `getIDs()` → single string id `uuid` (aliased `id`); `fields()` → `uuid` ("1C UUID Key").
- `initializeIterator()` returns `new \ArrayIterator($this->getRows())`; each subclass overrides
  `getRows()`. `count()` returns `count($this->rows)`.
- Reads its own migration's `process` map via reflection (`accessProtected($migration,
  'pluginDefinition')`) into `$this->config`.
- `$this->fetch` / `$this->debug` toggles come from `cmlmigrations.settings`
  (`plugin-*-fetch` / `-debug`); when on the UI (`entity.migration.list`) rows are capped (100 for
  products, 50 for rest) to keep the admin list responsive.
- **New in 2.x**: dependencies come from `Utility/DrupalServices` (a typed container wrapper built
  by `DrupalServices::fromContainer()`) instead of static `\Drupal::` calls — `config()`,
  `database()`, `entityTypeManager()`, `transliteration()`, `routeMatch()`, and the cmlapi parser
  accessors `parseProduct()` / `parseOffers()` / `parserPrices()` / `parserRests()` /
  `parserCatalog()`.

Key sources:
- **`CommerceProduct`** (`cml_commerce_product`): iterates `parseProduct()->parse()['data']`,
  builds product rows (uuid, type, stores, status, title, catalog group, `field_article`,
  `body` as `nl2br(...)` + `format: basic_html`), auto-detects МойСклад (`checkProductId()` →
  `changeConfig()`) and attaches variations/images (`hasVariations()`, `hasImage()`). Bulk-loads
  `FindVariation::getBy1cUuid()` / `FindImage::getBy1cImage()` when >400 rows.
- **`CommerceProductVariation`** (`cml_commerce_product_variation`): iterates
  `parseOffers()->parseArray()['offer']`, builds sku/price/`product_uuid` (SKU prefix before `#`),
  attribute target_ids (from `migrate_map_cml_product_variation_attribute`), and JSON-encodes
  per-warehouse stock (`field_json_stores`) and multi-price (`field_json_prices`) when the toggles
  are on.
- **`CommerceProductImage`** (`cml_commerce_product_image`): maps parsed image names to
  `file_managed` fids (`FindImage`), splits into `field_image` (first) and `field_gallery` (rest);
  `restoreImage()` registers a `public://<dir>/<name>` file entity for local files already received
  by cmlexchange (no remote fetch).
- **`CommerceProductVariationRest`** (`cml_commerce_product_variation_rest`): JSON-encodes current
  stock (`field_json_rest`) from `parserRests()->parse()`.
- **`CommerceProductVariationAttribute`**, **`CommerceProductVariationPrice`**, **`TaxonomyCatalog`**,
  **`TaxonomyPrices`**, **`TaxonomyStores`**, **`TaxonomyTerms`**, **`SchemeProduct`**,
  **`SchemeVolcabulary`** follow the same pattern (the last two feed the mostly-stub `cml_scheme`
  group; `Service/Scheme` methods currently return empty arrays).

## Process plugins (`src/Plugin/migrate/process/`)

- **`multi_target`** (`MultiTarget`, `handle_multiples = TRUE`): normalizes a list into
  `[{target_id: n}, …]`; uses `configuration['target']` as the key to detect already-shaped items,
  wraps numeric scalars as `['target_id' => (int) $v]`, logs bad items.
- **`multi_val`** (`MultiVal`, `handle_multiples = TRUE`): flattens `$value[0]` (a list of assoc
  arrays) into a single merged array.

## The `product_uuid` join & entity hooks (`src/Hook/`)

- **`EntityBaseFieldInfo`** adds the `product_uuid` string base field to
  `commerce_product_variation` (join key from 1C). Run `drush entity-updates` after upgrading.
- **`CommerceProductVariationInsert`**: on variation insert, loads the product by `product_uuid`
  (via `entity.repository`) and sets `product_id` — fixes 1C load-order where variations arrive
  before products.
- **`CommerceProductInsert`**: on product insert, attaches all variations matching the product UUID
  (`FindVariation::getBy1cUuid()`).
- **`CommerceProductVariationPresave`**: decodes `field_json_stores` / `field_json_prices` and
  builds/updates `stores` / `prices` **paragraphs** (`field_stocks` / `field_prices`), resolving
  the warehouse/price-type target from `migrate_map_cml_taxonomy_stores` / `_prices`.

All DB access uses the Drupal DB API (`select()`/`upsert()`/`update()` with bound conditions) and
entity queries; no string-concatenated SQL.
