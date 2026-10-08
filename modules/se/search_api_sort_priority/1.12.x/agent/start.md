# Search API Sort Priority — agent index

Six Search API index **processors** that add a hidden integer weight field and populate it at index time, so
you can sort results by an editorial priority. Depends on `search_api`. No settings page (`configure` null),
no permissions, no Drush, no config schema of its own (config lives on the index). One submodule for Solr.

- **The six processors, the weight fields they create, config (tabledrag), how to sort on them** →
  [plugins/processors.md](plugins/processors.md)

Submodule (own docs):
- `search_api_sort_priority_solr` → [../../modules/search_api_sort_priority_solr/1.12.x/agent/start.md](../../modules/search_api_sort_priority_solr/1.12.x/agent/start.md)

Key facts:
- Processors: `contentbundle`, `mediabundle`, `paragraphbundle`, `filemime`, `role`, `statistics`.
- Each creates+hides a field: `contentbundle_weight`, `mediabundle_weight`, `paragraphbundle_weight`,
  `filemime_weight`, `role_weight`, `statistics_weight`.
- Weights configured on the index **Processors** tab (drag rows); stored in `sorttable[<id>].weight`.
- Enable a processor → save → add the generated `*_weight` field as a sort in a Search API view.
