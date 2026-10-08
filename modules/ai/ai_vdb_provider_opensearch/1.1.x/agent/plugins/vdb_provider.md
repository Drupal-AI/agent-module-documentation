<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin: OpenSearchVdbProvider (`opensearch`)

`src/Plugin/VdbProvider/OpenSearchVdbProvider.php`. Attribute
`#[AiVdbProvider(id: 'opensearch', label: 'OpenSearch Vector DB')]`. Extends
`Drupal\ai\Base\AiVdbProviderClientBase`; implements `DependentPluginInterface`. Uses
`StringTranslationTrait` and Search API OpenSearch's `ConnectorFormTrait`. The AI Search backend
resolves and calls this plugin — you rarely instantiate it directly.

## Construction / services

Constructor adds two services beyond the base:
`plugin.manager.search_api_opensearch.connector` (`ConnectorPluginManager $connectorPluginManager`)
and `search_api_opensearch.query_filter_builder` (`FilterBuilder $filterBuilder`). Base services:
config.factory, key.repository, event_dispatcher, entity_field.manager, messenger.

- `getConfig(): ImmutableConfig` → `ai_vdb_provider_opensearch.settings`.
- `getClient(): \OpenSearch\Client` — lazy; builds via
  `getConnector($config['connector'], $config['connector_config'])->getClient()`. All endpoint/TLS/
  auth come from that Search API OpenSearch connector, not this module.
- `calculateDependencies()` → config dependency on `ai_vdb_provider_opensearch.settings`.

## Settings-form glue

`buildSettingsForm()` calls the parent then `buildConnectorConfigForm()`.
`validateSettingsForm()` stashes `database_settings` into `$this->clientConfig`, sets
`connector`/`connector_config` form values (connector default `'standard'`), and runs
`validateConnectorConfigForm()`. `submitSettingsForm()` calls parent then
`submitConnectorConfigForm()`. `buildAjaxConnectorConfigForm()` returns `[]` (the base UI supplies
`database_settings`).

## Collections = OpenSearch indices

`formatIndexName(string $database, string $collection)`: `strtolower($database.'_'.$collection)`,
`preg_replace('/[^a-z0-9_]/', '_', …)`, then prefix `idx` if it starts with `_`.

- `getCollections($database='default')` → `client->list()->indices()`, mapped to index names.
- `createCollection($name, int $dimension, VdbSimilarityMetrics $metric, $database='default')`:
  `indices()->create()` with `settings.index.knn = true` and mapping `properties.vector` =
  `type: knn_vector`, `dimension: $dimension`, `method` = `{ name: hnsw, space_type: <metric>,
  engine: <vdb_config.engine>, parameters: { ef_construction: 128, m: 16 } }`. A
  `BadRequestHttpException` (typically "index already exists") is caught and logged as an error to
  channel `ai_vdb_provider_opensearch` — creation is idempotent-ish, not fatal.
- `dropCollection($name, $database='default')` → `indices()->delete()`.

`mapMetricType()`: `EuclideanDistance→l2`, `CosineSimilarity→cosinesimil`,
`InnerProduct→innerproduct`.

## Documents (embeddings)

- `insertIntoCollection($name, array $data, $database='default')`: id = `$data['id'] ?? uniqid()`;
  strips `id` from the body; if `data['vector']` is an array it is `array_map('floatval', …)`;
  `client->index(['index'=>…, 'id'=>…, 'body'=>$doc_data])` (upsert by id).
- `deleteFromCollection($name, array $ids, $database='default')`: `client->bulk()` with a
  `{delete:{_id:$id}}` action per id.
- `deleteItems(array $configuration, array $item_ids)`: resolves index from
  `configuration['database_settings']['database_name'|'collection']` (default `default`) and runs
  `deleteByQuery` on `terms.drupal_entity_id = array_values($item_ids)` — used to purge a Drupal
  entity's vectors on delete/reindex.

## Search

- `vectorSearch($name, array $vector_input, array $output_fields, QueryInterface $query,
  $filters='', int $limit=10, int $offset=0, $database='default')`: `client->search()` with body
  `size=$limit`, `from=$offset`, `query.knn.vector = { vector: $vector_input, k: $limit,
  filter: $filters }`, `_source = $output_fields`. Returns `formatSearchResults()['data']`.
- `formatSearchResults(array $results)`: maps `hits.hits[]._source` to docs, copies `_id`→`id`, and
  `_score`→both `score` and `distance` (the AI Search backend reads `distance` as the relevancy
  score). Returns `['code'=>0, 'data'=>[…]]`.
- `prepareFilters(QueryInterface $query)`: `filterBuilder->buildFilters($query->getConditionGroup(),
  $query->getIndex()->getFields())`, then forces `$filters['term']['index_id'] =
  $query->getIndex()->id()` so results are scoped to the current Search API index.
- `querySearch(...)` and `getVdbIds(...)` → **`throw new \BadMethodCallException('Not implemented')`**.
  Metadata-only query and Drupal-id→VDB-id lookup are unsupported; only k-NN vector search works.
- `ping()` / `isSetup()`: try `getClient()->ping()` / `getClient()`, return bool (swallow
  exceptions).

## Filter building

`FilterBuilder` (in Search API OpenSearch) emits structured OpenSearch DSL —
`term`/`terms`/`range`/`bool.must_not`/`exists` — with each value placed as a typed JSON node, and it
validates each `field_id` against the index's fields (throws `SearchApiException` on an unknown
field). This mirrors the Elasticsearch-family approach.
