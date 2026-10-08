<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RDF SKOS exposes **SKOS** concept schemes and concepts — the W3C standard for published thesauri and controlled vocabularies — as read-only Drupal entities backed by a SPARQL triple store rather than Drupal's own database.

---

SKOS is how libraries, governments and EU institutions publish controlled vocabularies: EuroVoc, subject headings, standardised classification schemes, each with concepts, broader/narrower relationships and multilingual labels. Consuming one by copying it into Drupal taxonomy means it goes stale and loses its identifiers; RDF SKOS instead reads it live, defining the `skos_concept_scheme` and `skos_concept` content entity types stored through **`sparql_entity_storage`**, whose id is the concept's own RDF IRI. It ships a `skos_concept_entity_reference` field type (with autocomplete and select-list widgets, a label formatter and the `default:skos_concept` selection handler) so content can reference concepts like taxonomy terms, a matching `skos_concept_reference_id` Views filter, and a `ConceptSubset` plugin type plus two events (`rdf_skos_field_handler.predicate_mapping`, `rdf_skos.process_graph_results_alter`) for narrowing selectable concepts and mapping extra predicates. Which graphs the entities read comes from the `rdf_skos.graphs` config entity, edited per entity type at `/admin/structure/skos_concept_scheme/settings` and `/admin/structure/skos_concept/settings`. The endpoint itself is a `sparql_default` database connection declared in `settings.php` (Virtuoso or another triple store); the site needs that connection before the module is enabled. The `rdf_skos_language_mapping` submodule aligns Drupal language codes with the ones used in the SKOS data. It comes from the OpenEuropa ecosystem and requires `sparql_entity_storage ^2.0.0-beta1`.

---

- Use EuroVoc as a controlled vocabulary.
- Reference published SKOS concepts from content.
- Keep a thesaurus live rather than copied.
- Preserve concept URIs as identifiers.
- Consume a government classification scheme.
- Use multilingual concept labels.
- Model broader and narrower relationships.
- Align SKOS language tags with Drupal's.
- Reference a library subject heading.
- Add a SKOS concept reference field to a node type.
- Restrict a reference field to specific concept schemes.
- Offer a select list of concepts instead of autocomplete.
- Filter a view by referenced SKOS concept.
- Narrow selectable concepts with a custom subset plugin.
- Map an extra RDF predicate onto a concept base field.
- Query concepts from a triple store.
- Avoid duplicating an external vocabulary.
- Support an EU institutional metadata requirement.
- Keep classification in step with its publisher.
- Build linked-data-aware content.
- Reference concepts across several sites.
- Map site taxonomy to a public scheme.
- Support semantic interoperability.
- Register vocabulary graphs from an install hook.
