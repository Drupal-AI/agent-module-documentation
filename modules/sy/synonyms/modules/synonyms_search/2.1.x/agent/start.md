# Synonyms Search (synonyms_search) — agent index

Feeds referenced entities' synonyms into core Search's index and keeps them reindexed. Depends on
`synonyms` + core `search`. No config page (`configure` null), no permissions.

- **Enable the search behavior + how indexing/reindex works** → [configure/search.md](configure/search.md)

Key facts:
- Behavior service `synonyms.behavior.search` (`synonyms_behavior` tag), id `search`.
- `entityView()` runs only for the `search_index` view mode: for each referenced content entity with the
  search behavior enabled, appends its synonyms as `#markup` (with cache tags) → gets indexed.
- Reindex hooks: `hook_entity_update`/`hook_entity_delete` and `synonym_insert/update/delete` mark host
  entities via a direct `UPDATE {search_dataset} SET reindex=<time>` (type `<entity_type>_search`).
- Opt bundles in on *Structure → Synonyms configuration → Manage behaviors*.
