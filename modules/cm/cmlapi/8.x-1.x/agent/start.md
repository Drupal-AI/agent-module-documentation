<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CML API (cmlapi) — agent index

CommerceML (CML / 1C) **API/parser layer** for the "1C:Enterprise" e-commerce data-exchange
protocol. It does **two** things: (1) defines a `cml` content entity that records each exchange
(the uploaded XML/ZIP/log files, its state, login/IP, catalog-vs-sale type); (2) provides a suite
of parser services that read an already-stored CommerceML XML file and turn it into normalized
catalog / product / offer / price / stock arrays. Package `cml`. Core `^9 || ^10 || ^11`,
PHP 7.4+. License GPL-2.0-or-later. Installed **8.x-1.30** (version dir `8.x-1.x`).

Important scope note: **cmlapi does NOT expose the inbound 1C exchange HTTP endpoint.** It has no
public/anonymous route. Receiving the uploaded files from 1C is the job of the companion module
`cmlexchange`; importing the parsed data into commerce entities is `cmlmigrations`. cmlapi sits
between them as the storage entity + read/parse toolkit. All routes it defines are admin viewer
pages guarded by the `view published cml entity entities` permission.

## Dependencies

- Drupal modules: **none required** (`.info.yml` lists no `dependencies:`). Optional companions:
  `cmlexchange` (file receipt), `cmlmigrations` (import). Soft integrations, detected at runtime:
  `syncloud` + `syncloud.mqtt` (dashboard counter), `devel` (debug `dsm()`).
- PHP libraries: none (bundles jsTree JS under `assets/js/jstree/` for the catalog-tree viewer).

## What it provides (from source)

- **Content entity `cml`** (`Entity/CmlEntity.php`) — base_table `cml`, admin permission
  `administer cml entity entities`. Base fields: `name`, `type` (catalog|sale), `state`
  (zip|new|progress|success|busy|failure), `login` (1C login), `ip`, `status`, `full`,
  `user_id`, timestamps. A configured file field **`field_file`** (`config/install/…`) stores the
  exchange payload: extensions `xml zip log`, max 95 MB, `uri_scheme: public`, cardinality
  unlimited. Access handler = per-op permission checks; HTML route provider adds collection +
  settings routes.
- **Admin viewer routes** (`.routing.yml`, all `_permission: view published cml entity entities`):
  `/admin/structure/cml/{cml}/catalog` (jsTree group tree), `/product`, `/product-variaton`
  (offers), `/scheme`. Plus entity CRUD routes at `/admin/structure/cml` and a settings form at
  `cml.settings`. Menu links put a CommerceML item under Structure and a CML list under Content.
- **Parser services** (`.services.yml`) — `cmlapi.xml_parser` (`XmlParser`, the low-level
  CommerceML→array engine), and `ParserCatalog` / `ParserProduct` / `ParserOffers` / `ParserPrices`
  / `ParserRests` (each extends `ParserBase`, combines `cmlapi.cml` + `cmlapi.xml_parser`), plus
  `cmlapi.scheme`. Field-name→1C-tag mapping lives in editable config `cmlapi.mapsettings`.
- **Support services** — `cmlapi.cml` (`CmlService`: queries the actual/next/last exchange, resolves
  stored file URIs by prefix import/offers/prices/rests), `cmlapi.cleaner` (`CmlCleaner`: deletes
  empty + expired exchanges and their files), `cmlapi.counter` (`CmlCounter`: publishes a queue
  count over MQTT when `syncloud` is present).
- **Hooks** (`cmlapi.module` → `src/Hook/`): `hook_cron` runs the cleaner when
  `cleaner-cron` is set; `hook_cml_insert` fires the MQTT counter on new exchange rows.
- **Permissions** (`.permissions.yml`): add / administer / delete / edit / view published /
  view unpublished cml entities, and access the overview.
- **Config**: `cmlapi.mapsettings` (parser maps + cleaner settings, default install values),
  entity form/view displays, `field_file` storage+instance, optional `views.view.cml`.
  No `.install` file, no update hooks, no Drush commands.

## Solution docs

- **XML parser engine, the five parser services, `cmlapi.mapsettings` field mapping, exchange-source
  (1C vs MoySklad) detection** → [services/parsers.md](services/parsers.md)
- **The `cml` entity, its fields/permissions, admin viewer pages/controllers, settings form,
  cleaner + cron + MQTT counter** → [entity/cml-entity.md](entity/cml-entity.md)
