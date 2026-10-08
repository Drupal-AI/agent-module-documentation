# Synonyms Views Field (synonyms_views_field) — agent index

Thin glue: exposes the computed `synonyms` base field (from `synonyms_list_field`) to Views as a field.
Depends on `synonyms`, `synonyms_list_field`, core `views`. No config, no permissions, no services.

Key facts:
- `hook_views_data()` (`synonyms_views_data()`) declares a `synonyms` Views **field** on every entity
  type's data/base table (+ revision table if present), handler `field`, `field_name: synonyms`.
- In the Views UI: *Add field → "Synonyms list"*. Rendering comes from the computed
  `SynonymsFieldItemList` — no stored data.
- Nothing to configure; enabling the module is the whole setup.
