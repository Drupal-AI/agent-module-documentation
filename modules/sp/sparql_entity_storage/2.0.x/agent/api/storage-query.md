<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — storage, entity query, graphs, serialization

Use it through the normal entity API once an entity type declares `SparqlEntityStorage` as its storage handler
(the `sparql_test` example entity in `tests/modules/sparql_test` shows the setup). Ids are IRIs.

## CRUD with graphs
```php
$storage = \Drupal::entityTypeManager()->getStorage('sparql_test');

// Create in a specific graph (default = topmost/lowest-weight graph).
$entity = $storage->create(['id' => 'http://example.com/1', 'type' => 'fruit', 'graph' => 'draft']);
$entity->save();

$graph_id = $entity->get('graph')->target_id;   // read current graph

$entity = $storage->load($id);                   // load from default (topmost) graph
$entity = $storage->load($id, ['draft']);        // load from a specific graph
$entity = $storage->load($id, ['draft','sync']); // first graph where it exists (fallback list)
$entities = $storage->loadMultiple($ids, ['draft','sync']);

$storage->load($id, ['draft'])->set('graph', 'default')->save(); // move between graphs
```

## Entity query
```php
$ids = $storage->getQuery()
  ->condition('type', 'fruit')
  ->graphs(['default', 'draft'])   // restrict to graphs; omit = all enabled graphs by weight
  ->execute();
```
- Query is `Entity\Query\Sparql\Query`; conditions are compiled by `SparqlCondition`. Supported operators
  include `=`, `!=`, `<`,`>`,`<=`,`>=`, `IN`, `NOT IN`, `CONTAINS`, `STARTS WITH`, `ENDS WITH`, `LIKE`,
  `NOT LIKE`, `EXISTS`, `NOT EXISTS` (mapped to SPARQL `FILTER`/`VALUES`/triple patterns).
- **Escaping:** all condition values pass through `SparqlArg`/`escapeValue()`, which serializes literals and
  URIs with EasyRDF's N-Triples serializer (`Ntriples::serialiseValue`) — values are not concatenated raw into
  the query string. Predicates resolve via field mappings; field/property names become SPARQL variables
  (dots replaced by a middle-dot separator).

## Key services
- `sparql.endpoint` — the SPARQL Connection (query/update).
- `entity.query.sparql` — entity query factory (backend_overridable).
- `sparql.graph_handler` / `sparql.field_handler` — graph resolution and field↔RDF conversion.
- `plugin.manager.sparql_entity_id` — id-generator plugin manager (see plugins doc).
- `sparql.paramconverter` — resolves SPARQL entities from route IRIs (priority 6).

## Serialization
`sparql_entity.serializer` + encoders for formats `rdfxml`, `turtle`, `ntriples`, `n3`, `jsonld`, and a
`SparqlEntityNormalizer`, so SPARQL entities can be emitted as RDF via Drupal's serialization pipeline.
