<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Azure AI Search VDB provider plugin & REST client

## Plugin

`AzureAiSearchProvider` (`src/Plugin/VdbProvider/AzureAiSearchProvider.php`), attribute
`#[AiVdbProvider(id: 'azure_ai_search', label: 'Azure AI Search DB')]`, extends
`Drupal\ai\Base\AiVdbProviderClientBase`. Injected: `config.factory`, `key.repository`, `event_dispatcher`,
`entity_field.manager`, `messenger`, and the `azure_ai_search.api` client. It is discovered by the AI Search
module and offered wherever a "Vector Database" is chosen.

`getClient()` reads the configured Key name (`getConfig()->get('api_key')`), fetches its value from
`key.repository`, and passes it to `AzureAiSearch::getClient($value)`. `getConfig()` /
`getEditableConfig()` target `ai_vdb_provider_azure_ai_search.settings`.

### Collection / index model

Azure has no "collections", so `createCollection()`, `dropCollection()`, `getCollections()` are no-ops and
`getCollections()` returns `[]`. The **index name** (the form's `database_name`) is the unit of storage; it
must already exist in Azure.

### Interface methods

| Method | Azure call |
|---|---|
| `insertIntoCollection()` | `AzureAiSearch::insert()` → `POST /indexes/{index}/docs/index`, action `mergeOrUpload`. |
| `deleteFromCollection()` / `deleteItems()` | resolves Azure ids then `AzureAiSearch::delete()` → same endpoint, action `delete`. |
| `fetch()` / `getVdbIds()` | `AzureAiSearch::fetch()` looks up docs by `drupal_entity_id`. |
| `querySearch()` | `AzureAiSearch::query()` metadata-only (no `vectorQueries`). |
| `vectorSearch()` | `AzureAiSearch::query()` with a `vectorQueries` kNN block (returns `[]` if the vector input is empty). |
| `ping()` / `viewIndexSettings()` | `listIndexes()` / `getIndexStats()`. |
| `deleteAllItems()` / `AzureAiSearch::deleteAll()` | `@todo` — not implemented. |

Both search methods normalize each hit to `metadata + ['distance' => @search.score]`.

### Filter building — `prepareFilters()` / `processConditionGroup()`

Walks the Search API `ConditionGroup` recursively. Nested groups become `['$and' => …]`. For each leaf
condition it inspects the index field (multi-valued via `isMultiple()`) and emits an operator map:
`=`→`$eq`, `!=`→`$ne`, `>`→`$gt`, `>=`→`$gte`, `<`→`$lt`, `<=`→`$lte`, `IN`→`$in`, `NOT IN`→`$nin`;
multi-valued `=`/`IN`→`$in`. Field **values are placed as array elements**, not spliced into a string.
Unsupported operators (and negation on multi-valued fields) only add a `messenger` warning.

## REST client — `AzureAiSearch` (`src/AzureAiSearch.php`)

- Service `azure_ai_search.api`; args `@cache.default @messenger @logger.factory @config.factory
  @entity_type.manager @http_client`.
- `request($path, $method, $options)` builds the URL with `buildUrl()`
  (`rtrim(url) . path . '?' . http_build_query(['api-version' => …] + opts)`), validates the method against
  `SUPPORTED_METHODS` (GET/POST/PUT/DELETE), adds the `api-key` header when a key is present, and calls
  `$this->httpClient->request()` (the injected shared Guzzle client, default transport settings). It returns
  a `ResponseData` (status + `Json::decode`d body); `ClientException`/`RequestException`/`ConnectException`
  are caught and logged to the `ai_search` channel (404s are swallowed by design).
- `listIndexes()` caches results in `cache.default` under
  `azure_ai_search:` . `Crypt::hashBase64($apiKey)`; `clearIndexesCache()` clears it.
- `getIndexStats()` → `GET /indexes('{index}')/search.stats` returns `documentCount` + `storageSize`.
- `query()` posts `{count, select:'*', filter?, vectorQueries?}` to `/indexes/{index}/docs/search`.
- `fetch()` looks documents up by their `drupal_entity_id` values.

## Operate it

- Index name, service URL, API version and Key are all admin-set (see
  [../config/settings.md](../config/settings.md)); the module only ever calls the one configured HTTPS
  endpoint.
- Chunking and embedding are done upstream by AI Search / the embeddings provider; this module only stores
  and retrieves vectors + metadata.
- Because index creation is manual, a mismatch between the Azure index schema and the fields AI Search sends
  surfaces as Azure API errors logged to the `ai_search` logger channel.
