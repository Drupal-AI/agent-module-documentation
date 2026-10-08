<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Client layer, query building & events

The `ElasticSearchBackend` delegates all real work to `BackendClient` (`src/SearchAPI/BackendClient.php`),
built by `BackendClientFactory` (service `search_api_elasticsearch_client.backend_client_factory`).
The factory wires in the param builders, the field mapper, the analyser manager, the event
dispatcher and the logger channel `search_api_elasticsearch_client`.

## Index lifecycle (`BackendClient`)

- `addIndex()` — creates the ES index (`client->indices()->create`), then `updateSettings()` +
  `updateFieldMapping()`, then dispatches `IndexCreatedEvent`.
- `updateIndex()` — if the index exists, calls `indexNeedsClearing()` (recursive mapping diff via
  `mappingsHaveDifferences()`); clears + re-pushes settings/mappings when an incompatible mapping
  change is detected, otherwise just reindexes.
- `removeIndex()` / `clearIndex()` — delete (and for clear, recreate) the ES index.
- `updateSettings()` — collects analyzers referenced by the mapping, merges each analyser plugin's
  `getSettings()`, dispatches `AlterSettingsEvent`, forces `max_ngram_diff = 20`, then
  close → putSettings → open on the index.
- `updateFieldMapping()` — `client->indices()->putMapping()` with `FieldMapper` output.
- `getIndexId()` = configured `prefix` + `$index->id()`.
- `isAvailable()` = `client->ping()` guarded against `ElasticsearchException`/`TransportException`.

## Indexing & deletion

- `indexItems()` — `IndexParamBuilder::buildIndexParams()` → `client->bulk()`; per-item errors
  (status ≥ 400) are logged and a `SearchApiException` is thrown.
- `deleteItems()` — `DeleteParamBuilder::buildDeleteParams()` (fires `DeleteParamsEvent`) → bulk.

## Query building (`src/SearchAPI/Query/`)

`BackendClient::search()` checks the index exists, then `QueryParamBuilder::buildQueryParams()`
assembles the ES `_search` body:

- `from`/`size` from query `offset`/`limit` (defaults 0 / 10).
- `sort` from `QuerySortBuilder`.
- Full text via `SearchParamBuilder` — builds a **`makinacorpus/php-lucene` `Query`** from the
  Search API parsed keys (structured `TermQuery` objects, fuzziness applied), rendered into a
  `query_string` with boosted `fields` (`field^boost`). Keys are never string-concatenated by hand.
- Filters via `FilterBuilder` — Search API conditions become structured ES `term`/`terms`/`range`/
  `exists`/`bool` clauses through a `match($operator)`; unknown fields throw
  `SearchApiException("Invalid field ... in search filter")`, unknown operators throw too. `bool`
  fields are cast; groups nest with `should` (OR) / `must` (AND).
- Optional: MLT (`MoreLikeThisParamBuilder`, `search_api_mlt` option), facets → `aggs`
  (`FacetParamBuilder`), spellcheck → `suggest` (`SpellCheckBuilder`),
  `_source.excludes` from the `elasticsearch_exclude_source_fields` option, language conditions.
- `track_total_hits = TRUE` is set before the search. A `QueryParamsEvent` lets subscribers alter
  the final params. Responses are turned back into a Search API `ResultSet` by `QueryResultParser`
  (+ `FacetResultParser`, `SpellCheckResultParser`).

## Events (`src/Event/`)

`AlterMappingEvent`, `AlterSettingsEvent`, `FieldMappingEvent`, `IndexCreatedEvent`,
`IndexParamsEvent`, `BaseParamsEvent`, `DeleteParamsEvent`, `QueryParamsEvent`,
`SupportsDataTypeEvent`. `SynonymsSubscriber` (registered `event_subscriber`) injects the backend's
configured Solr-format synonyms into index analysis settings.

## Key services

`search_api_elasticsearch_client.{backend_client_factory, field_mapper, index_param_builder,
query_param_builder, query_result_parser, delete_param_builder, ...}` plus the two plugin managers
and the `search_api_elasticsearch_client` / `_client` logger channels. Full graph in
`search_api_elasticsearch_client.services.yml`.
