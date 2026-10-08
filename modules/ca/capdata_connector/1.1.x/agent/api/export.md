<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RDF export: manager, controller, Drush & hooks

## The manager service
`capdata_connector.capdata_manager` → `\Drupal\capdata_connector\CapDataConnectorManager`
(`capdata_connector.services.yml`; args: `entity_field.manager`, `entity_type.manager`, `config.factory`,
`request_stack`, `file_url_generator`, `module_handler`). It is a plain service (not a plugin manager
despite the name). The class is ~8,400 lines: mostly per-class/per-property `set*CapdataProperty()`
builders that copy mapped Drupal field values onto `capdataopera/php-sdk` model objects.

## `dataExport(): string`  (src/CapDataConnectorManager.php:755)
Builds and returns the RDF/XML string:
1. Creates `CapDataOpera\PhpSdk\Graph\Graph` and a `Serializer`.
2. Reads `capdata_connector_host`, `system.site` name and `capdata_opera_url` from config; adds the site's
   own `Collectivite` (IRI = `capdata_opera_url`, `siteWeb` = host).
3. `getExportCapdataClassesStockedInfo()` (:700) collects, from `capdata_connector.settings`, the classes
   flagged `_include_in_export` and splits them into `taxo_mapped_classes` / `content_mapped_classes`.
4. Iterates taxonomy-mapped classes: `taxonomy_term` `loadTree()` + `loadMultiple()`, keeps only terms in
   (or translated to) `fr`, builds each ontology object, maps fields via the `set*` helpers.
5. Iterates content-mapped classes: one `nodeStorage->getQuery()` per class with
   `accessCheck(FALSE)` **but** `condition('status', 1)` and `condition('langcode', 'fr')` — so only
   **published French** nodes are exported (28 such queries, all with the status filter).
6. Serialises the graph to RDF/XML and returns it.

Value transforms run through `customFieldProcessing()` (:8369) and `cleanUrl()` (:8343). Resource IRIs are
`{host}/node/{nid}` and `{host}/taxonomy/term/{tid}`.

## Export route & controller
Route `capdata_connector.capdata_export` → `GET /rof/capdata-rdf-export`, `_access: 'TRUE'`
(anonymous, by design — this is the public open-data feed). Controller
`\Drupal\capdata_connector\Controller\RofExportController::capdataRdfExport()`:
- If `getcwd() . '/.well-known/capdata-export.rdf'` exists, serves its contents.
- Otherwise calls `$manager->dataExport()` to generate on the fly.
- Returns a `Response` with `Content-Type: application/rdf+xml` and a `capdata-export.rdf`
  attachment `Content-Disposition`.

Intended operation: pre-generate the static file with the Drush command (from cron), so the controller
serves the cached file rather than regenerating per request.

## Drush command
`\Drupal\capdata_connector\Commands\CapdataConnectorCommands::rdfExport()`
(`drush.services.yml`, tag `drush.command`):
- `@command capdata_connector:rdf-export`, `@aliases capdata-rdf-export`.
- Calls `dataExport()`, writes `.well-known/capdata-export.rdf`, then writes a `gzopen('w9')` gzip copy
  `capdata-export.rdf.gz`. Run with `--uri` so absolute URLs resolve, e.g.
  `drush capdata-rdf-export --uri=https://opera-example.com`.

## Alter hooks (extension points)
- `hook_capdata_graph_beginning_alter(&$graph, $capdataExportData)` — at export start (:772).
- `hook_capdata_graph_item_alter(&$item, $entity, &$graph)` — after each term/node is converted
  (invoked at :2798, :3497, :3544, :4060, :4468, :4892, :5279).
- `hook_capdata_graph_alter(&$graph, $capdataExportData)` — at export end (:5291).
Use these from a custom module to inject or adjust graph nodes the mapping UI cannot express.
