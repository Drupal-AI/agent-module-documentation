<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & runtime API

## Services (`elasticsearch_helper.services.yml`)

| Service id | Class | Notes |
|------------|-------|-------|
| `elasticsearch_helper.elasticsearch_client` | `Elastic\Elasticsearch\Client` | The live client; built by the factory below. Inject this to talk to ES. |
| `elasticsearch_helper.elasticsearch_client_builder` | `ElasticsearchClientBuilder` | `build()` reads config and returns a configured `Client`. |
| `plugin.manager.elasticsearch_index.processor` | `ElasticsearchIndexManager` | Index plugin manager + entity indexing orchestration. |
| `plugin.manager.elasticsearch_auth` | `ElasticsearchAuthPluginManager` | Auth method plugin manager. |
| `elasticsearch_helper.data_type_repository` | `DataType\DataTypeRepository` | Valid ES field data types (alterable via `DataTypeEvents::BUILD`). |
| `elasticsearch_helper.queue_factory` | `ElasticsearchHelperQueueFactory` | Database queue factory (parent `queue.database`); a decorator (`elasticsearch_helper.queue_factory_decorator`, priority 3) routes the indexing queue through it for de-duplication. |
| `logger.channel.elasticsearch_helper` | logger channel | Channel `elasticsearch_helper`. |

## Index manager (`ElasticsearchIndexManager`)

Extends `DefaultPluginManager`. Orchestration methods:

| Method | Purpose |
|--------|---------|
| `indexEntity(EntityInterface $entity)` | Index the entity into every index plugin whose `entityType`/`bundle` matches. Called by `hook_entity_insert/update`. |
| `deleteEntity(EntityInterface $entity)` | Delete from every matching index plugin. Called by `hook_entity_delete` / `hook_entity_translation_delete`. |
| `reindex($indices = [], array $context = [])` | Call `reindex()` on all (or named) index plugins. |
| `reindexEntities($entity_type, $bundle = NULL)` | Entity-query all entities of a type (access check off via the alter hook) and queue each for indexing on cron. |
| `addToQueue($entity_type, $entity_id)` | Push `{entity_type, entity_id}` onto queue `elasticsearch_helper_indexing`. |

Indexing failures are caught and logged to the `elasticsearch_helper` channel; a failed index/delete
does not throw out of entity save.

## Per-plugin operation methods (`ElasticsearchIndexBase` / `ElasticsearchIndexInterface`)

Each index plugin instance exposes these. Document mutations first dispatch
`ElasticsearchEvents::OPERATION` and only run if the operation is still allowed (see
[events/events.md](../events/events.md)); requests then flow through an
`ElasticsearchRequestWrapper` that fires request/result events.

| Method | Wraps ES call | Notes |
|--------|---------------|-------|
| `getClient()` | — | Returns the `Elastic\Elasticsearch\Client`. |
| `setup()` | `indices()->create` | Creates the index from `getIndexDefinition()` if it does not exist yet. |
| `createIndex($name, IndexDefinition)` | `indices()->create` | Low-level create. |
| `index($source)` | `index` | Serialize + index one document. |
| `upsert($source)` | `update` (`doc_as_upsert`) | Partial update or create. |
| `get($source)` | `get` | Returns the document body array; throws on error. |
| `delete($source)` | `delete` | Delete one document. |
| `bulk($body)` | `bulk` | Bulk operation. |
| `search($params)` / `msearch($params)` | `search` / `msearch` | Index defaults to `indexNamePattern()`; returns result body array. |
| `getExistingIndices()` | `indices()->get` | Names of concrete indices matching the pattern. |
| `drop()` | `indices()->delete` | Delete all matching indices. |
| `truncate()` | `deleteByQuery match_all` | Empty matching indices, keep mappings. |
| `reindex(array $context = [])` | — | If plugin has `entityType`, queue its entities (via `reindexEntities`) for re-indexing. |

## Client builder & connection

`ElasticsearchClientBuilder::build()` composes hosts, auth and SSL from
`ElasticsearchConnectionSettings` (constructed from `elasticsearch_helper.settings`) and then
invokes `hook_elasticsearch_helper_client_builder_alter`. `ElasticsearchConnectionSettings`
(`getFormattedHosts()`, `getAuthMethodInstance()`, `getSslCertificate()`, `skipSslVerification()`,
static `createFromArray()`) is the read model for the connection. See
[configure/settings.md](../configure/settings.md).

## Helpers

- `ElasticsearchLanguageAnalyzer::get($langcode)` — static map from Drupal langcode to a built-in
  ES language analyzer (`en`→`english`, `de`→`german`, CJK for `ja`/`ko`/`zh-hans`), default
  `standard`. Use it when building language-aware mappings/analyzers.
- `ElasticsearchClientVersion` — reports the installed client major version.
- `ElasticsearchRequestResult` / `...Interface` — wraps a response; `getResultBody()->asArray()`
  yields the decoded body; `getRequestWrapper()` gives the originating request (document id/index).
