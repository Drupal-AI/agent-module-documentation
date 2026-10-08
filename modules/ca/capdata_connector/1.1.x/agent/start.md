<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CapData connector (capdata_connector) — agent index

Exports a Drupal site's published content as **RDF/XML** aligned to the **CapDataCulture ontology**
(CapData Opéra / France 2030). An admin maps ~28 ontology classes to Drupal content types /
taxonomies and their fields; the module then serialises the mapped, published, French-language
entities into an RDF graph. This module **exports/publishes** data — it does not fetch from a remote
API. Version 1.1.1. Core `^10.2 || ^11`.

## Dependencies
- Composer: `capdataopera/php-sdk:0.7.0` (the `CapDataOpera\PhpSdk\*` Graph, Model and Serializer classes).
- No Drupal module dependencies. No JS libraries (one CSS asset `capdata_connector/capdata_settingsstyles`).

## What it provides
- **Service** `capdata_connector.capdata_manager` → `CapDataConnectorManager` (all mapping + export logic).
- **Config form** `CapDataConnectorSettingsForm` at route `capdata_connector.admin_settings`
  (`/admin/config/services/capdata-mapping`), gated by core `administer site configuration`.
- **Controller** `RofExportController::capdataRdfExport` at route `capdata_connector.capdata_export`
  (`GET /rof/capdata-rdf-export`, `_access: TRUE` — anonymous by design; serves the RDF feed).
- **Drush command** `capdata_connector:rdf-export` (alias `capdata-rdf-export`) →
  writes `.well-known/capdata-export.rdf` and a `.gz` copy.
- **Config object** `capdata_connector.settings` (one flat set of `<class>_*` keys; no schema file shipped).
- **Alter hooks**: `hook_capdata_graph_beginning_alter`, `hook_capdata_graph_item_alter`,
  `hook_capdata_graph_alter`.
- No entities, no plugin types, no permissions of its own, no `.install`.

## Solution docs
- [Configuration & mapping form](config/settings.md) — the settings route, config keys, class/property mapping, custom processing.
- [RDF export API, controller & Drush](api/export.md) — `dataExport()`, the export route, the Drush command, alter hooks.
