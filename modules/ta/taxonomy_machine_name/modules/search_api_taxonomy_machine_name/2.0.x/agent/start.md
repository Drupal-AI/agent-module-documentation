# Search API Taxonomy Machine Name — agent index

Submodule of **taxonomy_machine_name**. Adds Search API support for taxonomy term
`machine_name` fields: index them, optionally with all ancestor machine names, and filter
Views on them. No configure route; configuration lives on the Search API index / Views.
Depends on `taxonomy_machine_name` + `search_api`.

- **The `taxonomy_machine_name_hierarchy` processor (what it indexes, its config shape, how
  to add it to an index)** → [plugins/hierarchy-processor.md](plugins/hierarchy-processor.md)
- **The `search_api_taxonomy_machine_name` Views filter and its depth options; the Solr
  field-mapping alter** → [configure/views-filter.md](configure/views-filter.md)

Key facts:
- Processor id: `taxonomy_machine_name_hierarchy`; stage `preprocess_index` (weight -45);
  config `fields[<field_id>][status] = true` per enabled field.
- Views filter id: `search_api_taxonomy_machine_name`; extends the base module's
  `taxonomy_index_machine_name`, adds `hierarchy_parent` (Start at level) and
  `hierarchy_max_depth` (Max depth).
- Processor `supportsIndex()` is TRUE only when the index has a field depending on module
  `taxonomy_machine_name` (a term machine_name field).
