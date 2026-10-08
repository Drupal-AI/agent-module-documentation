<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Elasticsearch VDB provider plugin & client

Two classes: `ElasticsearchVdbProvider` (the AI VDB plugin) and `ElasticsearchClient` (a thin wrapper over
the official `Elastic\Elasticsearch\Client`).

## Plugin — `ElasticsearchVdbProvider`

`src/Plugin/VdbProvider/ElasticsearchVdbProvider.php`, attribute
`#[AiVdbProvider(id: 'elasticsearch', label: 'Elasticsearch (Native kNN)')]`, extends
`AiVdbProviderClientBase`. `create()` grabs the `ai_vdb_provider_elasticsearch.client` service and calls
`initializeClient()`.

- `initializeClient()` — reads `host` (default `http://localhost:9200`), resolves `api_key_id` /
  `password_key_id` via `keyRepository`, and builds the client through
  `ElasticsearchClient::getConnection($host, $api_key, $username, $password)`.
- `getIndexName($collection)` = `index_prefix` (default `drupal_`) + `strtolower(preg_replace('/[^a-z0-9_]/i',
  '_', $collection))` — the collection name is sanitized to an ES-safe token.
- `mapSimilarityMetric()` — `EuclideanDistance`→`l2_norm`, `InnerProduct`→`dot_product`, default `cosine`.
- `getRawEmbeddingFieldName()` returns `'vector'`.

### Index & write methods

| Method | Behaviour |
|---|---|
| `getCollections()` | `_cat/indices` → list of index names. |
| `createCollection()` | creates the index with a `dense_vector` mapping if absent. |
| `dropCollection()` | deletes the index. |
| `insertIntoCollection()` | splits the flat `$data` into known fields + `extra_fields`, one `index` call. |
| `indexItems()` | **override**: builds embeddings via the AI Search `EmbeddingStrategyInterface`, deletes prior chunks, then one **Bulk API** request (`bulkInsert()`). `AiUnsafePromptException` → skip item with a warning. |
| `deleteItems()` / `deleteFromCollection()` | resolve VDB doc ids via `getVdbIds()`, then Bulk `delete`. |
| `getVdbIds()` | `bool.must.terms` on `drupal_entity_id`, `_source:false`, size capped at 10,000. |

### Search methods

- `querySearch()` — JSON-decodes `$filters` to an array and runs a standard query (or `match_all`).
- `vectorSearch()` — JSON-decodes `$filters`; normalizes the embedding payload; if `hybrid_search` config is
  on, calls `hybridSearch()` with `$query->getOriginalKeys()` and `rrf_rank_constant`, otherwise
  `vectorSearch()`. The decoded filter is passed straight through as the kNN pre-filter (access control).
- `prepareFilters()` — builds `['bool' => ['must' => …]]` from Search API conditions: `=`→
  `['term' => [$field => $value]]`, `IN`→`['terms' => [$field => $value]]`, then `json_encode`s it. Field
  values are array data, not string-spliced.

## Client — `ElasticsearchClient` (`src/ElasticsearchClient.php`)

- `getConnection($host, $api_key, $username, $password)` — `ClientBuilder::create()->setHosts([$host])`,
  then `setApiKey()` (preferred) or `setBasicAuthentication()`, else unauthenticated; `build()`. Uses the
  Elastic SDK's default HTTP transport.
- `createCollection()` — maps `vector` (`dense_vector`, `dims`, `index:true`, `similarity`) + keyword fields
  (`drupal_entity_id`, `drupal_long_id`, `entity_type`, `bundle`, `langcode`, `server_id`, `index_id`) + a
  `text` `content` field; `dynamic:true` accepts the rest.
- `vectorSearch()` — `knn` block (`field:'vector'`, `query_vector`, `k`, `num_candidates = max(50, k*10)`),
  optional `filter`.
- `hybridSearch()` — `query: {match: {content: $query_text}}` + `knn` + `rank: {rrf: {rank_constant}}` in one
  request. `$query_text` is placed as the `match` value.
- `bulkInsert()` / `deleteFromCollection()` — Bulk API; per-item errors are logged to the
  `ai_vdb_provider_elasticsearch` channel.
- `formatResults()` — flattens `hits.hits[]._source` and adds `id`/`score`/`distance` (= `_score`).

## Operate it

- The ES host/credentials are all admin-set (see [../config/settings.md](../config/settings.md)); the plugin
  only talks to the one configured cluster.
- Vectors are `floatval`-cast before indexing/searching. All query bodies (filters, match text, vectors) are
  handed to the Elastic SDK as structured PHP arrays / JSON, so they travel as request parameters.
- Access-control pre-filtering relies on the filter that AI Search passes into `vectorSearch()`; the module
  applies it verbatim as the kNN `filter`.
