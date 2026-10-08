Solr support submodule for Search API Sort Priority: maps its hidden weight fields to single-valued Solr fields so they can be used to sort results on a Solr backend.

---

This is a thin glue submodule (one `.module` file, no classes). It implements
`hook_search_api_solr_field_mapping_alter()`: for indexes that use a node, paragraph, or media datasource,
it finds the sort-priority weight fields (`contentbundle_weight`, `mediabundle_weight`,
`paragraphbundle_weight`, `role_weight`) and rewrites their Solr dynamic-field prefix from the multi-valued
form (`*m_`) to the single-valued form (`*s_`) with a regex. Search API Solr defaults unknown fields to
multi-valued, but Solr can only sort on single-valued fields — so without this rewrite you cannot sort on
the weight. It depends on `search_api_sort_priority` and `search_api_solr` and has no config, permissions,
routes, or Drush commands. Enable it whenever you use the parent module's processors on a Solr-backed index.

---

- Sort Solr search results on a `contentbundle_weight` priority field.
- Enable single-valued Solr mapping for `mediabundle_weight` so media sorts by bundle priority.
- Enable single-valued Solr mapping for `paragraphbundle_weight`.
- Sort Solr results by author `role_weight`.
- Make Search API Sort Priority weights usable as a Solr sort (they are unsortable multi-valued otherwise).
- Add Solr support to an existing Search API Sort Priority setup without changing processor config.
- Keep the weight field hidden while still sorting on it in Solr.
- Support node, paragraph, and media indexes on Solr backends.
- Avoid manual Solr schema/dynamic-field tweaks for the weight fields.
- Combine Solr relevance scoring with an editorial weight sort.
- Feature news/important content types at the top of a Solr-powered site search.
- Sort a Solr media search by media bundle priority.
- Sort Solr search by author role weight without custom Solr config.
- Fix "cannot sort on multi-valued field" errors for the priority weight fields on Solr.
- Deploy Search API Sort Priority to production sites that run Solr instead of the DB backend.
- Keep priority-based ordering consistent between DB and Solr backends.
- Order documents/files search results by editorial priority on Solr.
- Re-index and immediately sort on the single-valued weight field in a Solr view.
- Apply the mapping only to node, paragraph, and media indexes (others are left untouched).
