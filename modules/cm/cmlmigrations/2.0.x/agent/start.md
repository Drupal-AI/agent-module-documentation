<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML Migrations (cmlmigrations) — agent index

The **import side** of a CommerceML / 1C:Enterprise (and МойСклад / MoySklad) exchange for Drupal
Commerce. Sibling module **`cmlapi`** receives the exchange files (XML) and parses them;
**cmlmigrations** consumes cmlapi's parsed arrays through the **Migrate** framework (migrate_plus +
migrate_tools) and writes them into **Commerce products, product variations and catalog taxonomy**.
It also orchestrates *when* migrations run (via a Drush command it shells out to) and reports
exchange status back through the `cml` entity's state machine. Package `cml`. Core `^11 || ^12`.
License GPL-2.0-or-later. Installed **2.0.3** (version dir `2.0.x`).

There is **no XML parsing in this module** — all XML parsing is delegated to `cmlapi`'s
`cmlapi.parser_*` services. This 2.x major requires Drupal 11/12 and refactors the source plugins
onto a typed container helper (`Utility/DrupalServices`) rather than static `\Drupal` calls.

## Dependencies (`.info.yml`)

All required: **`migrate_tools`**, **`migrate_plus`**, **`commerce:commerce_product`**,
**`cmlapi:cmlapi`**, **`yaml_editor`** (the settings form embeds YAML editors for the migration
`process` pipelines). No `composer.json` ships with the module. Related (not hard deps): `cmlexchange`
(file receipt), `cmlstarter` (the expected content-type / field structure). Paragraphs are used for
stores/prices, pulled in transitively.

## What it provides (from source)

- **Migrations** in the `cml` group — install (`config/install/`): `cml_taxonomy_catalog`,
  `cml_taxonomy_stores`, `cml_taxonomy_prices`, `cml_product_variation`,
  `cml_product_variation_attribute`, `cml_product`; optional (`config/optional/`):
  `cml_product_image`, `cml_product_variation_price`, `cml_product_variation_rest`,
  `cml_taxonomy_terms`, plus a **`cml_scheme`** group (`cml_scheme_product`, `cml_scheme_vocabulary`).
  Destinations are `entity:commerce_product[_variation]` / `entity:taxonomy_term`.
- **12 Migrate source plugins** (`Plugin/migrate/source/`, e.g. ids `cml_commerce_product`,
  `cml_commerce_product_variation`, `cml_commerce_product_image`, `cml_commerce_product_variation_rest`,
  `cml_tx_catalog`, …) that pull rows from `cmlapi.parser_*` services; all extend
  `Utility/MigrationsSourceBase`.
- **Migrate process plugins**: `multi_target` (`MultiTarget`), `multi_val` (`MultiVal`).
- **Base field** `product_uuid` added to `commerce_product_variation`
  (`Hook/EntityBaseFieldInfo`) — the join key from 1C used to attach variations to their product.
- **Entity hooks** (`Hook/`): `commerce_product_insert` / `commerce_product_variation_insert` /
  `_presave` re-link variations↔products by UUID and build store-stock / price paragraphs from
  imported JSON; `hook_cron` drives the import loop; `hook_form_migration_edit_form_alter` adds a
  source-plugin + `process` YAML editor to core's migration edit form.
- **Services** (`.services.yml`): `cmlmigrations.migrate`, `.exec`, `.clear`, `.pipeline`, `.scheme`.
- **Drush command** `cmlmigrations` (`Drush/Commands/CmlmigrationsCommands`) — a lock-guarded import loop.
- **3 admin routes** (all `_permission: administer site configuration`): `/cmlmigrations/status`,
  `/cmlmigrations/scheme`, `/admin/structure/migrate/cmlmigrations` (settings).
- **Config** `cmlmigrations.settings` (mapping of vocabulary/product/variation bundles, timeouts,
  drush path, `exchange_source`, feature toggles). **No** `.permissions.yml`, **no** config schema,
  **no** submodules.

## Execution model (important)

Migrations are **not** run in-process. The status page / cron / pipeline call
`ExecService::exec()`, which builds a `drush mim --group=cml` string and runs it with **`shell_exec`**
(optionally `nohup … &`); the drush binary path comes from `cmlmigrations.settings` `drush`
(admin-set). The `cml` entity moves `new → progress → success/failure/busy` under a Drupal lock;
`ClearService` (via cron) resets stuck migrations after 1h. See [pipeline/execution.md](pipeline/execution.md).

## Solution docs

- **Settings form, config keys, bundle mapping, exchange_source, stores/prices/attributes toggles,
  dev buttons** → [config/settings.md](config/settings.md)
- **Migration set, source & process plugins, the `product_uuid` join, entity hooks (stores/prices
  paragraphs)** → [migrations/sources.md](migrations/sources.md)
- **Pipeline / Exec (shell_exec) / Clear / Cron / Drush, status & scheme pages** →
  [pipeline/execution.md](pipeline/execution.md)
