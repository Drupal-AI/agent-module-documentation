# Events

Two events let integrators reshape how SKOS triples become entities. Subscribe with a normal
event subscriber tagged `event_subscriber`.

| Constant | Event name | Class | When |
|---|---|---|---|
| `SkosPredicateMappingEvent::EVENT` | `rdf_skos_field_handler.predicate_mapping` | `Event\SkosPredicateMappingEvent` | While building the predicate ⇄ field map for a SKOS entity type, in `RdfSkosFieldHandler`. |
| `SkosProcessGraphResultsEvent::ALTER` | `rdf_skos.process_graph_results_alter` | `Event\SkosProcessGraphResultsEvent` | After `SkosEntityStorage::processGraphResults()` turns raw triples into entity value arrays. |

## Predicate-mapping event
Methods: `getEntityTypeId()`, `getMapping()`, `setMapping(array)`. The mapping is
`fields[<field_name>] => {column, predicate: [IRIs], format}` plus a top-level `rdf_type`. Use it
to point an existing base field at additional or alternate predicates. (Prefer a
`predicate_mapping` ConceptSubset plugin when you also need to add the base field itself.)

    public function map(SkosPredicateMappingEvent $event): void {
      if ($event->getEntityTypeId() !== 'skos_concept') {
        return;
      }
      $mapping = $event->getMapping();
      $mapping['fields']['definition']['predicate'][] = 'http://example.com/ns#note';
      $event->setMapping($mapping);
    }

## Process-graph-results event
Methods: `getEntityTypeId()`, `getResults()`, `setResults(array)`. Results are keyed by entity IRI,
then field name, then langcode → deltas. Use it to add or adjust computed values before entities
hydrate.
