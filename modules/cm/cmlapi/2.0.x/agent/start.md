<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML API (cmlapi) — agent index

CommerceML/1C exchange **API/data layer**. Defines the `cml` content entity that logs each
exchange and a set of **XML parser services** that read stored CommerceML files into
catalog/product/offer arrays. Package `cml`. Core `^11 || ^12`. PHP 7.4+. License
GPL-2.0-or-later. Version 2.0.x (installed 2.0.2). **No composer or module dependencies** in
`.info.yml`; in practice paired with `drupal/cmlexchange` (the HTTP endpoint 1C posts to) and
`drupal/cmlmigrations` (the importers). This module ships **no exchange endpoint itself** — only
the entity, the parsers and admin diagnostic pages.

## What it provides

- **Entity** `cml` (`src/Entity/CmlEntity.php`), base table `cml`, bundle-less content entity.
  Fields: `name`, `type` (catalog/sale), `state` (zip/new/progress/success/busy/failure), `full`
  (bool), `login`, `ip`, `status`, `user_id`, `created`, `changed`, plus a configured
  `field_file` file field (config/install). Permission-based access handler. →
  [entity/cml-entity.md](entity/cml-entity.md)
- **Parser services** — `XmlParser` (raw CommerceML → array + source detection), `ParserBase`
  (YAML field map + cache), `ParserCatalog`, `ParserProduct`, `ParserOffers`, `ParserPrices`,
  `ParserRests`, `Scheme`. Plus `CmlService` (exchange queue selection + file-URI resolution) and
  `CmlCleaner` (prune old/empty exchanges). → [services/parsers.md](services/parsers.md)
- **Config + settings form** `cmlapi.mapsettings` at route `cml.settings`
  (`/admin/structure/cml/settings`): the YAML node→field map and the cleaner options. →
  [config/settings.md](config/settings.md)
- **7 permissions** (`cmlapi.permissions.yml`): add / administer / delete / edit / access
  overview / view published / view unpublished `cml entity entities`.
- **4 diagnostic routes** (`cmlapi.routing.yml`), all requiring `view published cml entity
  entities`: `cmlapi.catalog`, `cmlapi.product`, `cmlapi.product-variation`, `cmlapi.scheme`
  under `/admin/structure/cml/{cml}/…`.
- **Hooks** (`cmlapi.module`): `hook_cron` → `Cron::hook()` (runs cleaner when
  `cleaner-cron`); `hook_cml_insert` → `CmlInsert::hook()` (pushes a queue counter to Syncloud
  MQTT when that module is present).
- **Library** `cmlapi/cmlapi.jstree` (bundled jsTree + `assets/js/script.js`, depends on
  `core/jquery`) used by the catalog page.

## Services (cmlapi.services.yml)

`cmlapi.cml`, `cmlapi.cleaner`, `cmlapi.counter`, `cmlapi.xml_parser`, `cmlapi.parser_catalog`,
`cmlapi.parser_product`, `cmlapi.parser_offers`, `cmlapi.parser_prices`, `cmlapi.parser_rests`,
`cmlapi.scheme`.

## Notes for 2.x

- `XmlParser` gained exchange-source detection: `getExchangeSource()` returns `1c` (UUID Ид) vs
  `moysklad`, `syncExchangeSource()` writes `cmlmigrations.settings.exchange_source`, and
  `getNestedGroups()` flattens MoySklad's shared root group.
- Parsers read only the **managed file's own URI** (from the `field_file` reference), never a
  request-supplied path.
