# Search API Sort Priority: Solr Support — agent index

Thin glue submodule of `search_api_sort_priority`. One `.module`, no classes, no config/permissions/Drush.
Depends on `search_api_sort_priority` + `search_api_solr`.

- **What it does:** implements `hook_search_api_solr_field_mapping_alter()`. For indexes with a node,
  paragraph, or media datasource, it rewrites the Solr dynamic-field prefix of the weight fields
  (`contentbundle_weight`, `mediabundle_weight`, `paragraphbundle_weight`, `role_weight`) from multi-valued
  (`*m_`) to single-valued (`*s_`) via `preg_replace('@^([^m]+)m\_@i', '$1s_', $field_id)`.
- **Why:** Search API Solr defaults unknown fields to multi-valued, but Solr can only sort on single-valued
  fields. This makes the parent module's weight fields sortable on Solr.
- **Use:** just enable it on a Solr-backed index that uses the parent module's processors; no configuration.
  See the parent: [../../../../1.12.x/agent/plugins/processors.md](../../../../1.12.x/agent/plugins/processors.md).
