<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RDF SKOS (rdf_skos) — agent index

Exposes W3C **SKOS** concept schemes and concepts from an RDF triple store as two **read-only**
Drupal content entities (`skos_concept_scheme`, `skos_concept`), so external controlled
vocabularies (EuroVoc, subject headings, government classification schemes) back Drupal content
instead of being copied into taxonomy. Entity id == the concept's RDF IRI.

- **Dependency:** `sparql_entity_storage:sparql_entity_storage` (`^2.0.0-beta1`). Data is read
  through a `sparql_default` database connection declared in `settings.php` (Virtuoso or another
  triple store); the site will not bootstrap without that connection. rdf_skos does no HTTP itself
  — all SPARQL transport lives in `sparql_entity_storage`.
- **Core:** `^10 || ^11`. **Submodule:** `rdf_skos_language_mapping` (maps Drupal langcodes to the
  ones used in the SKOS data; own permission + form at `/admin/config/sparql/language-mapping`).
- **Configure:** no single settings route. One graph-list form per entity type at
  `/admin/structure/skos_concept_scheme/settings` (route `skos_concept_scheme.settings`) and
  `/admin/structure/skos_concept/settings` (route `skos_concept.settings`); both write the
  `rdf_skos.graphs` config entity.
- Defines **permissions**, **config schema**, a **ConceptSubset plugin type**, a **field type** +
  widgets/formatter, a **Views filter**, and **2 events**. No drush commands.

Solution docs:
- **Point the entities at your triple store's graphs** → [configure/graphs.md](configure/graphs.md)
- **Grant view / administer access** → [permissions/permissions.md](permissions/permissions.md)
- **Reference SKOS concepts from a content field** → [fields/skos_concept_reference.md](fields/skos_concept_reference.md)
- **Filter a view by referenced concept** → [views/filter.md](views/filter.md)
- **Restrict or extend which concepts are selectable (custom subset)** → [plugins/concept_subset.md](plugins/concept_subset.md)
- **Alter loaded results / add predicate mappings** → [events/events.md](events/events.md)
- **Load schemes/concepts or register graphs in code** → [api/services.md](api/services.md)

Key facts:
- Entity types: `skos_concept_scheme` (label key `title`), `skos_concept` (label key `pref_label`);
  `id` == `uuid` == the RDF IRI; both translatable; create/update/delete forbidden by the access
  handlers.
- Config entity `rdf_skos.graphs` → `entity_types.<type>` is a list of `{name, uri}` graph rows.
- Services: `rdf_skos.skos_graph_configurator`, `rdf_skos.sparql.graph_handler`,
  `rdf_skos.sparql.field_handler`, `rdf_skos.entity.query.sparql`, `plugin.manager.concept_subset`.
- Field type `skos_concept_entity_reference`; widgets `skos_concept_entity_reference_autocomplete`
  / `skos_concept_entity_reference_options_select`; formatter `skos_concept_entity_reference_label`;
  selection handler `default:skos_concept`.
- Views filter `skos_concept_reference_id`. Events `rdf_skos_field_handler.predicate_mapping`,
  `rdf_skos.process_graph_results_alter`.
- Permissions: `view published skos concept scheme entities`,
  `administer skos concept scheme entities`, `view published skos concept entities`,
  `administer skos concept entities`.
- From the OpenEuropa (EU institutional Drupal) ecosystem.
