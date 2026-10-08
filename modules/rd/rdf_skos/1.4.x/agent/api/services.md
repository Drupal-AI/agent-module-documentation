# Services, entity API & hooks

## Services (`rdf_skos.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `rdf_skos.skos_graph_configurator` | `SkosGraphConfigurator` | `addGraphs(array $name_to_uri)` — programmatically register graphs on both SKOS entity types in `rdf_skos.graphs` (de-duplicated). |
| `rdf_skos.sparql.graph_handler` | `RdfSkosGraphHandler` | Reads `rdf_skos.graphs` to resolve graph definitions/URIs per entity type; injects a placeholder graph when none configured. Extends `sparql_entity_storage`'s graph handler. |
| `rdf_skos.sparql.field_handler` | `RdfSkosFieldHandler` | Maps SKOS predicates ⇄ entity base fields (the full SKOS predicate table lives here); merges in predicate mappings from ConceptSubset plugins and fires the predicate-mapping event. |
| `rdf_skos.entity.query.sparql` | `Entity\Query\Sparql\QueryFactory` | Entity-query factory for the SKOS storage (thin subclass of the parent factory). |
| `plugin.manager.concept_subset` | `ConceptSubsetPluginManager` | Manager for the ConceptSubset plugin type — see [../plugins/concept_subset.md](../plugins/concept_subset.md). |
| `rdf_skos.active_graph_subscriber` | `EventSubscriber\SkosActiveGraphSubscriber` | On param-conversion of a SKOS entity, forces all configured graphs of that type as the active graphs. |

Storage handler is `SkosEntityStorage` (extends `SparqlEntityStorage`); its query service name is
`rdf_skos.entity.query.sparql`. Query conditions and value escaping are inherited from
`sparql_entity_storage`; rdf_skos only overrides the bundle condition to a fixed SKOS type IRI map.

## Loading entities

Standard entity API — the storage is SPARQL-backed but the surface is normal:

    $schemes = \Drupal::entityTypeManager()->getStorage('skos_concept_scheme')->loadMultiple();
    $concept = \Drupal::entityTypeManager()->getStorage('skos_concept')->load($iri);

Note (per tests/README): the SPARQL storage usually needs an explicit `getQuery()->execute()` to
get IDs before `loadMultiple($ids)`; the entity id **is** the RDF IRI.

### ConceptSchemeInterface (`skos_concept_scheme`)
`getTitle()`, `setTitle()`, `getTopConcepts()`.

### ConceptInterface (`skos_concept`)
Labels: `getPreferredLabel()`/`setPreferredLabel()`, `getAlternateLabel()`, `getHiddenLabel()`.
Notes: `getDefinition()`, `getScopeNote()`, `getHistoryNote()`, `getEditorialNote()`,
`getChangeNote()`, `getExample()`.
Relations (return referenced entities): `getConceptSchemes()` (in_scheme), `topConceptOf()`,
`getBroader()`, `getNarrower()`, `getRelated()`, `getExactMatch()`, `getCloseMatch()`,
`getBroadMatch()`, `getNarrowMatch()`, `getRelatedMatch()`.

Concept base fields (mapped to `skos:*` predicates in `RdfSkosFieldHandler`): `pref_label`,
`alt_label`, `hidden_label`, `definition`, `example`, `scope_note`, `editorial_note`,
`change_note`, `history_note`, `in_scheme`, `top_concept_of`, `broader`, `narrower`, `related`,
`exact_match`, `close_match`, `broad_match`, `narrow_match`, `related_match`. Scheme fields:
`title` (also read from `dc:title` / `skos:prefLabel` / `rdfs:label`), `has_top_concept`.

## Hooks implemented (`rdf_skos.module`)
- `hook_field_views_data_alter()` — forces the `skos_concept_reference_id` Views filter onto any
  `skos_concept_entity_reference` field.
- `hook_entity_base_field_info()` — adds the base fields declared by ConceptSubset
  predicate-mapper plugins to `skos_concept`.
