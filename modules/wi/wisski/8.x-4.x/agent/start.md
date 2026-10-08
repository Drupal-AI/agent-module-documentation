<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI (wisski) — agent index

Virtual research environment for scholarly data: Drupal entities backed by a **SPARQL triple
store** and mapped to an ontology (typically **CIDOC-CRM**) through a **pathbuilder**.
Version **8.x-4.3**. Core `>=10.4 <12`. Depends on `inline_entity_form` plus its own
`wisski_core`, `wisski_salz`, `wisski_pathbuilder`, `wisski_adapter_sparql11_pb`.

**Documented from source — it could not be enabled on a clean install. Say why before anything
else.**

`wisski_core.services.yml`:

```yaml
wisski.route_subscriber:
  class: Drupal\wisski_core\Routing\WisskiRouteSubscriber
  arguments: ['@module_handler', '@entity_type.manager', '@search.search_page_repository']
```

`wisski_core.info.yml` dependencies: `inline_entity_form`, `wisski_autocomplete`,
`wisski_pathbuilder`, `wisski_salz` — **`drupal:search` is not declared**.

**Verified:** enabling it produced, on every request and in Drush,
*"The service `wisski.route_subscriber` has a dependency on a non-existent service
`search.search_page_repository`"*. Drush itself could not run, so recovery required editing
`core.extension` directly in the database. Adding `search` cleared it; a partially installed
`wisski_title_n_grams` table then failed a cache rebuild.

**Always enable core `search` before `wisski`.** A one-line info-file addition would fix it
upstream.

Architecture:

- `wisski_salz` — Store Abstraction Layer Zero; adapter management and the common data interface.
- `wisski_adapter_sparql11_pb` — SPARQL 1.1 store adapter driven by a pathbuilder.
- `wisski_pathbuilder` — maps Drupal fields onto ontology paths. This is the heart of the system.
- `wisski_core` — entity type, routing, UI. Required.
- Authority adapters: GND, Getty AAT, GeoNames, SKOS, Zotero, RDF, XML, DMS.
- `wisski_api` (REST), `wisski_mirador` / `wisski_iip_image` (IIIF), `wisski_doi`,
  `wisski_duplicate` + `wisski_data_merge`, `wisski_statistics`, `wisski_permalink`.

Audience is memory institutions — museums, archives, libraries — and long-lived research
projects. Do not recommend it as a general content platform.