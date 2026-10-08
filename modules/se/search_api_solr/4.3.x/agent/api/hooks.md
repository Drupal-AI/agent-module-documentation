# Alter hooks (`search_api_solr.api.php`)

Implement in `mymodule.module`. Signatures abbreviated — see the source api.php for full docblocks.

- `hook_search_api_solr_query_alter(SolariumQueryInterface $solarium_query, QueryInterface $query)`
  — alter the Solarium query before it is sent (add params, filters, boosts).
- `hook_search_api_solr_converted_query_alter(SolariumQueryInterface $solarium_query, QueryInterface $query)`
  — alter after Search API → Solr conversion (preferred over `_query_alter` in most cases).
- `hook_search_api_solr_field_mapping_alter(IndexInterface $index, array &$fields, string $language_id)`
  — change how index fields map to Solr dynamic field names per language.
- `hook_search_api_solr_documents_alter(array &$documents, IndexInterface $index, array $items)`
  — modify Solr documents right before indexing.
- `hook_search_api_solr_search_results_alter(ResultSetInterface $result_set, QueryInterface $query, Result $result)`
  — post-process the parsed result set.
- `hook_search_api_solr_finalize_index(IndexInterface $index)`
  — run custom work when an index is finalized (commit/optimize hooks).
- `hook_search_api_solr_config_files_alter(array &$files, string $lucene_match_version, string $server_id = '')`
  and `hook_search_api_solr_config_zip_alter(ZipStream $zip, string $lucene_match_version, string $server_id = '')`
  — inject or edit generated Solr config-set files / the downloadable zip.

Autocomplete-specific query alters (with the autocomplete submodule):
`hook_search_api_solr_terms_autocomplete_query_alter()`,
`hook_search_api_solr_spellcheck_autocomplete_query_alter()`,
`hook_search_api_solr_suggester_autocomplete_query_alter()`.

The autocomplete submodule also dispatches events
(`PreSpellcheckQueryEvent`, `PreSuggesterQueryEvent`) as a modern alternative.
