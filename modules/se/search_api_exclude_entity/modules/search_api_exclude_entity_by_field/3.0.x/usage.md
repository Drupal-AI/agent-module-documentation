Search API Exclude Entity By Field excludes items from a Search API index when one of the index's fields matches a value you configure — no dedicated exclude field required.

---

This submodule adds a Search API processor, `search_api_exclude_entity_by_field_processor` (`alter_items` stage, weight -50), whose settings form lists every field on the index and lets you type a target value per field. At index time `alterIndexedItems()` loops the items, and for each configured field compares the entity's field value against your configured value; on a match it `unset()`s the item so it is dropped from the index. The comparison string is sanitized so that `true`/`false` are treated as the boolean values `TRUE`/`FALSE`, while any other string compares literally. Unlike the parent module it needs no custom field on the entity — it reuses fields already indexed — but it depends on the parent `search_api_exclude_entity`. Errors while reading an item are caught and surfaced via the messenger. Only fields present on the index are available as criteria, and empty settings are filtered out on submit.

---

- Exclude nodes whose indexed `promote` (or any boolean) field equals `false`.
- Drop items where a status field equals a specific string value.
- Keep entities out of the index by an existing field without adding a new checkbox field.
- Exclude content of a given type by matching a bundle/field value already in the index.
- Filter out items whose "hidden" flag is `true` at indexing time.
- Reuse fields you already added to the Search API index as exclusion criteria.
- Configure a different match value per field on the same index.
- Exclude by a language or moderation-state field value.
- Compare boolean fields using the literal words `true` / `false` in the setting.
- Compare non-boolean fields against an exact string value.
- Avoid schema changes when you only need value-based exclusion.
- Combine with the parent processor to mix field-flag and value-based exclusion.
- Exclude items during full or partial reindex runs.
- Prevent placeholder/imported records with a sentinel field value from indexing.
- Skip entities whose category/term field equals an unwanted value.
- Layer value-based exclusion on top of other Search API processors.
- Deploy the processor's per-field settings as index configuration between environments.
- Quickly suppress a class of content from search without editing each entity.
- Exclude items where a checkbox-like field is unchecked (value `false`).
- Troubleshoot exclusion via the error message shown if an item object can't be read.
