<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typesense API client

Wraps `typesense/typesense-php` (`\Typesense\Client`). Files: `src/Api/`.

## Config (`Api\Config`)

Immutable value object; constructor args: `string $api_key`, `?array $nearest_node`, `array $nodes`,
`int $retry_interval_seconds`, `Psr\Http\Client\ClientInterface $http_client` (Drupal's `http_client`).
`toArray()` produces the `\Typesense\Client` config (`api_key`, `nearest_node`, `nodes`,
`retry_interval_seconds`, `client`). `valid()` = non-empty api key and ≥1 node.

## TypesenseClient (`Api\TypesenseClient implements TypesenseClientInterface`)

Constructed with a `Config`; wraps `ConfigError` into `SearchApiTypesenseException`. Every call
catches `\Typesense\Exceptions\RequestUnauthorized` and rethrows a
`SearchApiTypesenseRequestUnauthorizedException($action)` (e.g. `documents:upsert`) so the UI can show
which key scope is missing; other errors become `SearchApiTypesenseException`.

Notable methods:

- Collections: `retrieveCollections()`, `createCollection($schema)`, `dropCollection($name)`,
  `retrieveCollectionInfo($name)` (created_at + num_documents), private `retrieveCollection()`.
- Documents: `createDocument()` (upsert), `retrieveDocument()`, `deleteDocument()`,
  `deleteDocuments($name, $filter_condition)`, `searchDocuments($name, $params)`,
  `multiSearch($searches, $query_params, $union)`.
- Synonyms: `createSynonym/retrieveSynonym/retrieveSynonyms/deleteSynonym`.
- Curations (Typesense overrides): `createCuration/retrieveCuration/retrieveCurations/deleteCuration`.
- Stopwords: `createStopword/retrieveStopword/retrieveStopwords/deleteStopword`.
- API keys: `createKey/retrieveKey/retrieveKeys/deleteKey`,
  `generateScopedSearchKey($key, $parameters)`.
- Conversation models: `create/retrieve/retrieveAll/update/deleteConversationModel`,
  `hasConversationHistoryCollection()`, `ensureConversationHistoryCollection()` (creates the
  `conversation_store` collection).
- Server: `retrieveHealth()`, `retrieveDebug()`, `retrieveMetrics()`.
- Import/export: `importCollectionData($name, $data)` (upserts synonyms + overrides),
  `exportCollectionData($name, $include_schema)`.
- Field helpers used to build search params: `getFields()`, `getFieldsForQueryBy()`,
  `getFieldsForFacetType()`, `getQueryByWeight()`, `getFieldsForSortBy()`.
- Value helpers: `prepareId()` (`/`→`-`), `prepareItemValue($value, $type, $field_name)` (casts to the
  Typesense type; throws if a non-array field gets multiple values).

## Exceptions

- `SearchApiTypesenseException` — general wrapper (`src/Api/SearchApiTypesenseException.php`).
- `SearchApiTypesenseRequestUnauthorizedException` — carries the attempted action string
  (`src/Api/SearchApiTypesenseRequestUnauthorizedException.php`).

The client is obtained through `SearchApiTypesenseBackend::getTypesenseClient()`; it is not a
standalone service.
