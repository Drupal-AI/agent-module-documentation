# Synonyms List Field (synonyms_list_field) — agent index

Adds a computed, read-only `synonyms` base field to every content entity, listing its synonyms.
Depends on `synonyms`. `configure` → `synonyms_list_field.settings`. No permissions.

- **Enable the field on Manage display + its one global setting** → [configure/field.md](configure/field.md)

Key facts:
- `synonyms_entity_base_field_info()` adds base field `synonyms` (string, computed, read-only,
  cardinality unlimited, `display configurable: view`) to all `ContentEntityTypeInterface`s.
- Item-list class `SynonymsFieldItemList` sources values from `synonyms.provider_service`.
- Config `synonyms_list_field.settings.include_entity_label` (bool, default FALSE) — include the
  entity's own label in the list.
- `synonyms_views_field` exposes this field to Views.
