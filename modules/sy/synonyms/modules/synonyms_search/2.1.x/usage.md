Synonyms Search integrates Synonyms with core Search, so an entity becomes findable by the synonyms of the entities it references — the synonyms are injected into the search index and kept fresh on updates.

---

The submodule adds a `search` behavior service (`synonyms.behavior.search`, tagged `synonyms_behavior`).
On `hook_entity_view()` for the special `search_index` view mode, `SearchService::entityView()` walks the
entity's entity-reference fields, and for each referenced content entity whose type/bundle has the
**search** behavior enabled, merges in that entity's synonyms (via `ProviderService::getEntitySynonyms()`)
as extra `#markup` (comma-joined) with proper cache metadata and Synonym cache tags. That text is thus
indexed by core Search alongside the entity's own content. To stay correct, `hook_entity_update()` /
`hook_entity_delete()` mark dependent host entities for reindex, and inserting/updating/deleting a
Synonym config marks affected entities for reindex too. Reindexing is done by a direct, performance-minded
`UPDATE` on the `{search_dataset}` table (setting `reindex` = request time for the matching `sid`s /
`type` = `<entity_type>_search`). There is no dedicated settings page; you opt bundles in through the
Synonyms *Manage behaviors* form. Requires core `search`.

---

- Find a node by a synonym of a taxonomy term it references.
- Index alternate country/region names so search matches "USA" and "United States".
- Make referenced-entity aliases searchable without duplicating them into the node body.
- Automatically reindex host content when a referenced entity changes.
- Reindex affected content when a synonym provider config is added/edited/deleted.
- Enable synonym indexing per entity type/bundle via the behavior form.
- Improve recall of core Search for acronym/alias-based queries.
- Keep synonym text out of the visible page but present in the search index.
- Attach correct cache tags so search output invalidates when synonyms change.
- Support user-referenced content becoming findable by a username synonym.
- Layer synonym search onto an existing core Search setup with no widget changes.
- Index synonyms only where the search behavior is enabled (opt-in per bundle).
- Broaden site search matches for content that references glossary terms.
- Avoid manual keyword stuffing by sourcing synonyms from structured fields.
- Reindex efficiently via a targeted `{search_dataset}` update.
