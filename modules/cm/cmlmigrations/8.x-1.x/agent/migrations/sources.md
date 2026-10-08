<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrations, source/process plugins & entity hooks

## The `cml` migration group

`config/install/` (always installed): `cml_product`, `cml_product_variation`,
`cml_product_variation_attribute`, `cml_taxonomy_catalog`, `cml_taxonomy_prices`,
`cml_taxonomy_stores`. `config/optional/`: `cml_product_image`, `cml_product_variation_price`,
`cml_product_variation_rest`, `cml_scheme_product`, `cml_scheme_vocabulary`, `cml_taxonomy_terms`,
plus the `cml` and `cml_scheme` migration groups. Dependency order (from
`migration_dependencies`): `cml_taxonomy_catalog` + `cml_taxonomy_stores` + `cml_product_variation`
→ `cml_product`.

`cml_product` process highlights: `field_catalog` uses `skip_on_empty` → `migration_lookup` into
`cml_taxonomy_catalog`; `variations` uses the custom **`multi_target`** plugin; `body` is written
`format: basic_html` (filtered on render); `field_image` / `field_gallery` are dropped
automatically for МойСклад (MoySklad) exchanges where images arrive in a separate file.

## Source plugins (`Plugin/migrate/source/`)

All extend `Utility/MigrationsSourceBase` (extends core `SourcePluginBase`). Rows come **only** from
`cmlapi` parser services — this module never touches XML:

| source id | class | data from |
|-----------|-------|-----------|
| `cml_commerce_product` | CommerceProduct | `cmlapi.parser_product->parse()` |
| `cml_commerce_product_image` | CommerceProductImage | `cmlapi.parser_product` |
| `cml_commerce_product_variation` | CommerceProductVariation | `cmlapi.parser_offers->parseArray()` |
| `cml_commerce_product_variation_attribute` | …Attribute | `cmlapi.parser_offers` |
| `cml_commerce_product_variation_price` | …Price | `cmlapi.parser_prices` |
| `cml_commerce_product_variation_rest` | …Rest | `cmlapi.parser_rests` |
| `cml_tx_catalog` | TaxonomyCatalog | `cmlapi.parser_catalog` |
| `cml_tx_prices` / `cml_tx_stores` / `cml_tx_terms` | Taxonomy* | `cmlapi.parser_offers` / static |
| `cml_scheme_product` / `cml_scheme_volcabulary` | Scheme* | static/stub |

`MigrationsSourceBase` uses a single ID `uuid` (the 1C GUID). It reads the migration's `process`
mapping through reflection (`accessProtected`), and on the migration-list UI it caps rows at 100 and
can `dsm()`-dump when `devel` is present and the debug toggle is on.

- **CommerceProduct::getRows()** builds product rows (title, `body` as `basic_html`, catalog group,
  `field_article`, status from `Удален`), attaches variations via `Utility/FindVariation` (join on
  `product_uuid`) and images via `Utility/FindImage`. It auto-detects a МойСклад feed
  (`checkProductId` — a non-GUID first key) and strips the image process steps. `getStore()` finds or
  marks a default `commerce_store`.
- **CommerceProductVariation::getRows()** builds variation rows: `sku`=`uuid`, `product_uuid`=SKU
  prefix, `price` (RUB, default price-type "Розничная цена"), attribute `target_id`s from the
  attribute map table, and — when `stores`/`prices` enabled — `field_json_stores` /
  `field_json_prices` as **`json_encode`d** blobs consumed later by the presave hook.

## Process plugins (`Plugin/migrate/process/`)

- **`multi_target`** (`MultiTarget`, `handle_multiples`) — normalizes a list of items to
  `['target_id' => …]` shape (numeric → cast int); logs "Bad MultiTarget value" otherwise.
  (Note: it computes `$return` but returns the original `$value`.)
- **`multi_val`** (`MultiVal`) — flattens `$value[0]` into the return array.

## `Utility/` helpers

- **FindVariation::getBy1cUuid()** — selects `commerce_product_variation_field_data`
  (variation_id/sku/product_id/**product_uuid**), grouped by the 1C UUID. Query built with the DB API
  (`->condition('product_uuid', $id1c)`), parameterized.
- **FindImage::getBy1cImage()** — selects `file_managed` for rows whose `uri` LIKEs the 1C image
  name(s) under `public://{cmlexchange file-path}/`. LIKE value is bound (no SQLi). It only maps
  **already-received** local files to fids; it does not download anything.
- **Service::getNormalizeName()** — transliterated/stripped ≤22-char machine name for attribute
  fields.

## Entity hooks (`Hook/`)

- **EntityBaseFieldInfo** — adds base field `product_uuid` (string) to
  `commerce_product_variation`. Run `drush entity-updates` after enabling/updating.
- **CommerceProductInsert / CommerceProductVariationInsert** — re-link variations to their product
  by shared UUID on insert (1C load-order fixer), then `save()`.
- **CommerceProductVariationPresave** — decodes `field_json_stores` / `field_json_prices` and creates
  or updates `stores` / `prices` **paragraphs** (`field_stocks` / `field_prices`), mapping the 1C
  store/price ids through `migrate_map_cml_taxonomy_stores` / `_prices`. Prices become
  `commerce_price\Price` objects.

## `cml_product_image` mapping upsert

`CommerceProductImage::updateMapping()` copies rows from `migrate_map_cml_product` into
`migrate_map_cml_product_image` (upsert keyed on `sourceid1`) so the image migration reuses the
product's destids; `restoreImage()` re-creates a `File` entity (uid 1, `public://…/$image`) if the
managed file row is missing.
