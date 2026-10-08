<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `qdrant` VdbProvider plugin, client & filter translation

## Plugin

`src/Plugin/VdbProvider/QdrantProvider.php` — `#[AiVdbProvider(id: 'qdrant', label: 'Qdrant vector DB')]`,
extends `Drupal\ai\Base\AiVdbProviderClientBase`, implements `ContainerFactoryPluginInterface`. Logger
channel `ai_vdb_provider_qdrant`. AI Search's server backend selects it as the vector store; there is no
standalone route or UI beyond the settings form.

Native payload fields (`AI_SEARCH_NATIVE_FIELDS`): `drupal_entity_id`, `drupal_long_id`, `content`,
`vector`, `server_id`, `index_id`. Any other indexed field is stored as an extra Qdrant payload key.

Key methods:

- `getConfig()` → `ai_vdb_provider_qdrant.settings`. `getConnectionData()` resolves host/port/API-key
  (Key entity via `keyRepository`), throws `DatabaseNotConfiguredException` if host missing, defaults port
  `6333`. `getConnection()` delegates to `QdrantClient::getConnection()`. `isSetup()`/`ping()` check
  reachability.
- `getClient()` → `\Drupal::service('ai_vdb_provider_qdrant.client')`.
- `createCollection()` / `dropCollection()` / `deleteFromCollection()` — wrap the client and **swallow**
  their exceptions as logger warnings (expected during index clear/re-save).
- `indexItems()` — ensures the collection exists (`ensureCollectionExists()`, dimension from
  `embedding_strategy_configuration['dimensions']`, default 1536), deletes prior points for the items,
  then for each embedding chunk builds `$data` (native fields + extras with an `is_multiple` flag) and
  calls `insertIntoCollection()`.
- `insertIntoCollection()` splits native vs extra fields and forwards to the client.
- `deleteItems()` maps Drupal item ids → Qdrant point ids via `getVdbIds()` then deletes.
- `getVdbIds()` scrolls the collection filtering `drupal_entity_id` `match.any` (limit 1000) to recover
  point ids; returns `[]` (logged) on any error so indexing continues.
- `querySearch()` / `vectorSearch()` convert filters (`convertFiltersToArray()`) and delegate to the
  client. `vectorSearch()` reads the similarity `metric` from the AI Search server backend config
  (`VdbSimilarityMetrics::from(...)`).
- `getRawEmbeddingFieldName()` → `'vector'`.

## Client (`src/QdrantClient.php`, service `ai_vdb_provider_qdrant.client`)

Constructed with `ClientFactory` (`@http_client_factory`); builds one Guzzle client with a JSON
`Content-Type` header. `getConnection($host,$port,$api_key,$database)` normalizes the base URL (prepends
`http://` when no scheme, appends `:$port`). REST operations, all via private `makeHttpRequest($method,
$endpoint,$data)`:

| Method | HTTP call |
| --- | --- |
| `getCollections()` | `GET /collections` → column of names |
| `createCollection()` | `PUT /collections/{name}` with `vectors.size` + `distance: Cosine` |
| `dropCollection()` | `DELETE /collections/{name}` |
| `insertIntoCollection()` | `PUT /collections/{name}/points` — point id `md5(drupal_long_id)`, vector + payload |
| `deleteFromCollection()` | `POST /collections/{name}/points/delete` — ids `md5($id)`-mapped |
| `querySearch()` | `POST /collections/{name}/points/scroll` — `limit`,`offset`,`with_payload`, optional `filter` |
| `vectorSearch()` | `POST /collections/{name}/points/search` — `vector`,`limit`,`offset`, optional `filter` |
| `updateFields()` | no-op (Qdrant schemaless) |

`makeHttpRequest()` sets the `Api-Key` header only when a key is present, sends `json` body, and throws a
plain `\Exception` on HTTP >= 400 or a Guzzle `RequestException`; each caller wraps that in its typed
`src/Exception/*` class. Responses are shaped by `formatPointsResponse()` / `formatSearchResponse()`
(search rows include `distance` = Qdrant `score`).

## Search API → Qdrant filter translation

`prepareFilters(QueryInterface)` → `convertConditionGroupToQdrant()` recurses the condition group;
`convertConditionToQdrant()` resolves field type (via `index->getField()`), converts the value by type
(`convertValueByType()` — dates → ISO-8601, bool/int/float casts), and warns+skips unindexed non-native
fields. `createQdrantCondition()` maps operators:

- `=` → `match.value`; `<>`/`!=` → negated `match.value`
- `<`,`<=`,`>`,`>=` → `range.lt/lte/gt/gte`
- `IN` → `match.any`; `NOT IN` → negated `match.any`
- `BETWEEN` / `NOT BETWEEN` → `range.gte`+`lte` (negated for the latter)
- unsupported operator → warning + empty condition

Multi-value fields (`handleMultiValueField()`, cardinality via `ai_vdb_provider_qdrant_is_field_multiple()`
in `.module`) prefer `match.any`. `mapConjunctionToQdrant()` turns AND→`must`(+`must_not`) and
OR→`should`(+ negated group). `validateQdrantFilter()` / `validateQdrantCondition()` enforce that only
`must`/`should`/`must_not` appear and that each leaf has a `key` plus a valid `match`/`range` — throwing
`\InvalidArgumentException` otherwise (caught in `prepareFilters()`, which then returns `[]`). Filter
values are emitted as structured JSON in the Qdrant filter object. Unit coverage:
`tests/src/Unit/QdrantFilterTest.php`.
