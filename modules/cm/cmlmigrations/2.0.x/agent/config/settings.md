<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

Route `cmlmigrations.settings` → `/admin/structure/migrate/cmlmigrations`
(`Form/Settings` extends `ConfigFormBase`), permission **`administer site configuration`**.
Linked from the cmlapi admin structure menu (`cmlapi.admin.structure.settings` parent) and from
the module's task/menu links (`cmlmigrations.links.menu.yml`, `.links.task.yml`).

## `cmlmigrations.settings` config keys

Defaults ship in `config/install/cmlmigrations.settings.yml`:

| key | default | meaning |
|-----|---------|---------|
| `vocabulary` | `catalog` | taxonomy vocabulary the catalog imports into |
| `product` | `product` | `commerce_product` bundle destination |
| `variation` | `variation` | `commerce_product_variation` bundle destination |
| `field_image` | `field_image` | image field name (convention required by the migrations) |
| `timeout` | `30` | max migration run time, **minutes**, before Pipeline marks it failed |
| `timeout-quick-run` | – | seconds; guards against "migration busy" false failures |
| `drush` | `/var/www/html/vendor/bin/drush` | **path to the drush binary run via `shell_exec`** |
| `exchange_source` | `auto` | `auto` / `moysklad` / `1c` — auto-detected during exchange, updates config on mismatch |
| `stores` | – | bool: import per-warehouse stock into `field_stocks` paragraphs |
| `prices` | – | bool: import multiple price types into `field_prices` paragraphs |
| `plugin-product-fetch` / `plugin-variation-fetch` | – | fetch rows in the source-plugin constructor |
| `plugin-product-debug` / `plugin-variation-debug` | – | log mapping+rows via `devel` on the migration-list UI |

`Settings::getEditableConfigNames()` also lists `migrate_plus.migration.cml_taxonomy_catalog`,
`.cml_product` and `.cml_product_variation`: the form directly rewrites their `source.plugin` and
`process`. The `process` pipelines are edited as **YAML** in `data-yaml-editor` textareas; on submit
they are `Yaml::decode()`d straight back into config.

## Mapping section

`buildForm()` populates selects from live bundle info:
- **Catalog Vocabulary** — every `taxonomy_vocabulary` id (`getTaxonomyBundles()`).
- **Product Destination** / **Product Variation Destination** — bundles of `commerce_product` /
  `commerce_product_variation`.
- **Source plugin** selects for catalog/product/variation list every registered migrate source
  plugin (`plugin.manager.migrate.source`), labelled `id (provider)` (`getMigrationPlugins()`).

## Stores / Prices / Attributes toggles

The form inspects the latest `offers.xml` exchange by calling `cmlapi.parser_offers->parseArray()`
(via private `checkStores()` / `checkPrices()` / `checkAttributes()`), and only shows the toggle when
the source data actually contains warehouses, price types or attribute "svoistvo" definitions.

- **Create the required settings** (stores) → AJAX `ajaxCheckStoresReady()`: creates a `stores`
  taxonomy vocabulary if missing and installs the optional config bundled under
  `assets/config/stores/` (paragraph types, fields, the `cml_taxonomy_stores` migration) via
  `FileStorage` + `config.installer->installOptionalConfig()`, then force-writes each YAML with
  `config.factory` and flushes caches.
- **Prices** → on submit, if `prices` is checked, `checkPricesReady()` does the same for a `prices`
  vocabulary from `assets/config/prices/`.
- Attribute checkboxes are transliterated 1C property names (`razmer→size`, `cvet→color`, else a
  normalized machine name ≤22 chars from `Utility/Service::getNormalizeName()`).

`submitForm()` rebuilds the variation `process` pipeline from the checked attribute/stores/prices
boxes (`formVariationProcess()`), saves all config, then invokes `cache_flush` and deletes every
cache bin. `validateForm()` is a no-op.

## Dev buttons

Under a collapsed **Dev** details: **Fill / Clear 1000 product_uuid field** →
`Settings::ajaxProdUuidFill` / `ajaxProdUuidClear` → `Utility/Service::uuid1cFill()` /
`uuid1cClear()`, which set/clear the `product_uuid` base field on up to 1000 variations (derived from
the SKU prefix before `#`). The README instructs running **Clear** before uninstalling the module so
the base field can be removed cleanly. The install hook `cmlmigrations_update_8001()` back-fills the
`product` / `variation` config keys when they are empty.

## Migration edit form alter

`hook_form_migration_edit_form_alter` (`Hook/FormMigrationEditFormAlter`) adds a **Migration Edit**
fieldset (source-plugin select + a YAML `process` editor) to core's per-migration edit form, and
prepends `submitConfig()` as a `#validate` handler that writes `source`/`process` back to the
`migrate_plus.migration.{id}` config.
