<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API service & HTTP client

## MeilisearchApiService
Files: `src/Api/MeilisearchApiService.php`, `...ServiceInterface.php`,
`src/Api/MeilisearchApiException.php`.
Service `search_api_meilisearch.api` (**`shared: FALSE`** — a fresh instance per request), argument
`@search_api_meilisearch.client_factory`.

Holds `url` and `masterKey` (set by the backend from server config) and lazily builds the SDK
`Meilisearch\Client` in `connection()`, which also calls `->version()` once to prove the connection
and wraps any failure in `MeilisearchApiException`. Every method wraps SDK calls in try/catch and
rethrows as `MeilisearchApiException`.

Method groups (all delegate to `meilisearch/meilisearch-php`):
- **Connection/meta**: `connection()`, `ping()`, `keys()` (returns all keys — admin/debug use).
- **Indexes**: `getIndex()`, `createIndex()`, `removeIndex()` (delete + waitForTask),
  `listIndexes()`.
- **Documents**: `addDocuments($index, $docs)` (primary key `'id'`), `getDocument()`,
  `getDocuments()`, `deleteDocument()`, `deleteDocuments()`, `deleteAllDocuments()`.
- **Settings**: filterable / sortable / searchable attributes (get+update), `getSettings()`/
  `setSettings()`, ranking rules, synonyms (`get`/`update`/`reset` — update resets first),
  stop words (`update`/`reset`).
- **Search**: `search($index, $query, $options)`, `searchFacets(...)` (builds a `FacetSearchQuery`).
- **Async**: `waitForUpdate($taskUid)` → `waitForTask`.

The Meilisearch key is supplied to the SDK as the API key and is sent as the `Authorization`
header on each request. It is not logged (only exception *messages* are logged) and is never
placed in markup, drupalSettings, or JS.

## Client factory & Guzzle adapter
- `src/Client/MeilisearchClientFactory.php` — `getInstance(string $url, ?string $key)`:
  `new \Meilisearch\Client($url, $key, new HttpAdapter())`, exceptions wrapped as
  `MeilisearchApiException`.
- `src/Client/Client.php` — a PSR-18 `ClientInterface` Guzzle adapter. Constructor sets
  `$config['http_errors'] = FALSE` and instantiates `GuzzleHttp\Client($config)`. **No TLS options
  are overridden** — Guzzle's default `verify` (system CA bundle, cert verification ON) applies.
  `sendRequest()` maps Guzzle `RequestException`/`TransferException` → `NetworkException`, other
  `GuzzleException` → `ClientException` (`src/Client/Exceptions/`).

## Filter / condition parsing
- `src/Parser/StringExpressionFilterParser.php` (service `search_api_meilisearch.filter_parser`,
  a `service_collector` for tag `meilisearch_condition_parser`) recursively renders a Search API
  condition group into a Meilisearch filter string, adding parentheses only where conjunctions
  differ across nesting levels.
- Tagged parsers (priority): `BooleanValueParser` (20) → `ScalarValueParser` (10),
  `NullValueParser`, `BetweenOperatorParser`, `NotBetweenOperatorParser`, `InOperatorParser`,
  `NotInOperatorParser`. `ScalarValueParser` maps `<>` → `!=`.
- `src/Utility/MeilisearchUtils::formatConditionValue()` — non-numeric values have `\` and `"`
  escaped and are wrapped in double quotes before insertion into the filter expression; numeric
  values pass through unquoted.

## Item conversion
- `src/Converter/Item/ItemConverter.php` (service `search_api_meilisearch.item_converter`,
  `service_collector` for tag `meilisearch_field_converter`) maps Search API items → document
  arrays; single-value fields are flattened to scalars.
- `src/Converter/Field/TextDataFieldConverter.php` — the one shipped field converter.
- `src/EventSubscriber/IndexingItemsSubscriber.php` — event subscriber on indexing items.
