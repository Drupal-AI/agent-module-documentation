<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API: MilvusV2 client & MilvusProvider plugin

Two layers:

1. **`MilvusProvider`** (`src/Plugin/VdbProvider/MilvusProvider.php`) — the `@VdbProvider` plugin id
   `milvus`, extending `\Drupal\ai\Base\AiVdbProviderClientBase`. This is what `ai`/`ai_search` call;
   normally you do **not** instantiate it directly — you configure it (see
   [../configure/connection.md](../configure/connection.md)) and let AI Search use it.
2. **`MilvusV2`** (`src/MilvusV2.php`, service **`milvus_v2.api`**) — a thin Guzzle wrapper over the
   Milvus **v2** REST API. Use it for direct collection/vector operations.

## Getting the provider plugin

```php
/** @var \Drupal\ai\AiVdbProviderPluginManager $mgr */
$mgr = \Drupal::service('ai.vdb_provider');
$milvus = $mgr->createInstance('milvus');   // MilvusProvider
$milvus->ping();                            // bool — connectivity check
$milvus->isSetup();                         // bool — server configured
$milvus->getCollections('default');         // array of collection names
```

`MilvusProvider` also exposes the higher-level, AI-oriented methods `createCollection()`,
`dropCollection()`, `insertIntoCollection()`, `deleteFromCollection()`, `querySearch()`,
`vectorSearch()`, `getVdbIds()`, `prepareFilters(QueryInterface)`, and `viewIndexSettings()`. It reads
its connection from `ai_vdb_provider_milvus.settings` (`getConfig()`), resolving `api_key` via the Key
repository (`setAuthentication()`).

## The low-level MilvusV2 REST client

```php
/** @var \Drupal\ai_vdb_provider_milvus\MilvusV2 $c */
$c = \Drupal::service('milvus_v2.api');
$c->setBaseUrl('http://milvus');     // scheme+host, no port
$c->setPort(19530);
$c->setApiKey('user:pass');          // optional; sent as "Bearer user:pass"

$c->createCollection($name, $database, $dimension, $metricType, $options = []);
$c->listCollections($database = '');
$c->describeCollection($name, $database = '');
$c->insertIntoCollection($name, array $data, $database = '');
$c->deleteFromCollection($name, array $ids, $database = 'default');
$c->query($name, array $outputFields, $filters = 'id not in [0]', $limit = 10, $offset = 0, $database = '');
$c->search($name, array $vectorInput, array $outputFields, $filters = '', $limit = 10, $offset = 0, $database = '');
$c->isZilliz();   // bool — true when baseUrl host matches zilliz cloud
```

Notes:
- Every call is a JSON POST to `<baseUrl>:<port>/v2/vectordb/...`; responses are decoded to arrays.
- `dbName` is only sent for non-Zilliz (self-hosted) requests; Zilliz omits it.
- `metricType` is the distance metric (e.g. `COSINE`, `L2`, `IP`) passed straight to Milvus.
- `createCollection` forces `autoID` on by default.
- There is no plugin type defined by this module — `milvus` is an instance of the `ai` module's
  `VdbProvider` plugin type; consume it via the `ai.vdb_provider` manager above.
