<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SPARQL Entity Storage — agent index

Entity storage + entity-query backend that persists Drupal entities in a SPARQL triple-store (Virtuoso, etc.)
instead of SQL. Infrastructure only: no user-facing feature on its own — other modules define entity types that
use it (e.g. `rdf_entity`). Depends on core `options`; requires external SPARQL endpoint + libs
`sweetrdf/easyrdf`, `ml/json-ld`. No permissions; admin uses `administer site configuration`. No Drush.

- **Endpoint connection (settings.php), SPARQL graphs, field→predicate mappings** →
  [configure/graphs-mapping.md](configure/graphs-mapping.md)
- **Storage & query API: CRUD, entity query, graph selection, serialization** →
  [api/storage-query.md](api/storage-query.md)
- **`sparql_entity_id` id-generator plugin type (implement a custom IRI generator)** →
  [plugins/id-generator.md](plugins/id-generator.md)
- **Hooks the module invites** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Connection: a `sparql_default` DB connection in `settings.php` (`driver: sparql`, host/port/endpoint/https);
  driver class `src/Driver/Database/sparql/Connection.php` (classmap autoload) over EasyRDF.
- Config entities: `sparql_graph` (`graph.*`, UI at `/admin/config/sparql/graph`) and `sparql_mapping`
  (`mapping.*`, per bundle→RDF mapping). Field↔RDF via `field.storage.*.third_party.sparql_entity_storage`.
- Query values are escaped centrally in `SparqlArg` (EasyRDF N-Triples serializer) — see api doc; no raw
  concatenation of user values into SPARQL.
- Plugin type `sparql_entity_id` (dir `Plugin/sparql_entity_storage/Id`, annotation `SparqlEntityIdGenerator`,
  alter `hook_sparql_entity_id_info_alter`); default generator provided, fallback plugin id `default`.
