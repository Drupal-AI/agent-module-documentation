# Elasticsearch Connector Autocomplete — agent index

Adds an ngram/edge-ngram analyzer to a Search API **Elasticsearch Connector** index and a
`text_ngram` Fulltext data type, so partial-word autocomplete/search works. No config route
(`configure` null), no permissions, no Drush, no config schema of its own — settings are stored
as `elasticsearch_connector` third-party settings on the `search_api_index` entity. Requires
`elasticsearch_connector` (`^8.0@alpha`) + `search_api`.

- **Enable ngram on an index, the config keys, the `text_ngram` field type, the ES analysis/mapping it injects** →
  [configure/ngram.md](configure/ngram.md)

Key facts:
- Index form alter (`elasticsearch_connector_autocomp.module`) adds *Elasticsearch specific index
  options* → `ngram_filter_enabled` (bool) + `ngram_config` (`ngram_type` `edge_ngram`|`ngram`,
  `min_gram` default 3, `max_gram` default 20). Toggling on an existing index forces a
  delete/rebuild confirmation.
- Data type plugin `text_ngram` (`TextNgramDataType`, fallback `text`) — selectable per field on
  the index Fields form only when ngram is enabled.
- `DefaultSubscriber` (event subscriber) handles `elasticsearch_connector.prepare_index` (adds
  `ngram_filter` + custom `ngram_analyzer`) and `.prepare_index_mapping` (maps `text_ngram` fields
  → `type: text`, `analyzer: ngram_analyzer`, `search_analyzer: standard`, `keyword` sub-field).
- No plugin types, hooks, or services for third parties to implement.
