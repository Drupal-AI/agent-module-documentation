# Views Term Hierarchy Weight Field — agent index

Auto-provisions two integer fields on every taxonomy term so Views can sort/filter by tree order.
No settings UI (`configure` null), no permissions, no Drush, no config schema. Depends on core
`views` + `taxonomy`.

- **The two fields, how they are created and recalculated, and how to sort a View by them** →
  [api/fields.md](api/fields.md)

Key facts:
- Fields (on `taxonomy_term`, all vocabularies): `field_tax_hierarchical_weight` (index in flattened
  tree), `field_tax_hierarchical_depth` (`count(parents) - 1`).
- Created on install and on every new vocabulary (`hook_entity_insert`) via the
  `views_term_hierarchy_weight_field.fields` service.
- Recalculated in a 25-term Batch job on term save, taxonomy overview reorder, and vocabulary create;
  multilingual-aware.
- To use: add these fields to a taxonomy-term View and sort ascending on the weight field.
