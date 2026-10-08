# Views filter: SKOS concept reference

`skos_concept_reference_id` (`Plugin/views/filter/SkosConceptReferenceId`, extends core
`ManyToOne`). Auto-applied to any `skos_concept_entity_reference` field's target-id column via
`hook_field_views_data_alter()` — you do not pick it manually.

Behaves like core's Taxonomy term-id filter (large parts copied from `TaxonomyIndexTid`):

- Extra options `limit` (default TRUE) and `concept_scheme`. When limiting, the value form becomes
  an `entity_autocomplete` scoped to the chosen scheme
  (`#selection_settings['concept_schemes'] = [$scheme]`, `#tags = TRUE`).
- When not limiting, a plain multi-value textfield of concept IDs.
- Exposed-filter input is validated into concept target ids (`validateExposed()` /
  `acceptExposedInput()`); adds the `user` cache context because results depend on entity access.
- If a bad `concept_scheme` is configured, the value form shows a static translated notice
  instead of the widget.

Config schema `views.filter.skos_concept_reference_id` — `type`, `limit`, `concept_scheme`,
`value[]`. `calculateDependencies()` records the concept scheme and any selected concepts as
config dependencies.

A view display can also inject a fixed scheme via the field's Views data `definition['concept_scheme']`,
which locks the scheme option (the radios are then hidden).
