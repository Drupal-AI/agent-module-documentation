<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend plugin — SearchApiMeilisearchBackend

File: `src/Plugin/search_api/backend/SearchApiMeilisearchBackend.php`
Plugin id: `search_api_meilisearch` (annotation `@SearchApiBackend`).
`final class`, extends `BackendPluginBase`, implements `AutocompleteBackendInterface`,
`PluginFormInterface`, `SpecialFieldsInterface`.

## Dependencies (create())
- `search_api_meilisearch.api` → `MeilisearchApiServiceInterface` (shared: FALSE)
- `logger.channel.search_api_meilisearch`
- `search_api_meilisearch.filter_parser` → `FilterParserInterface`
- `search_api_meilisearch.item_converter` → `ItemConverterInterface`
- `search_api_meilisearch_autocomplete.autocomplete` (optional — only if that submodule is enabled)

## Configuration form
`buildConfigurationForm()` exposes three textfields, stored in backend config:
- `meilisearch_host_address` (required, placeholder `http://127.0.0.1`)
- `meilisearch_host_port` (required, placeholder `7700`)
- `meilisearch_master_key` (optional, size 64)

`defaultConfiguration()`: `http://127.0.0.1` / `7700` / `''`.
`validateConfigurationForm()`: strips a trailing `/` from the host address and rejects a port
outside 1–65535. In both the constructor and `setConfiguration()`/`__wakeup()`, the service URL is
built as `host_address . ':' . port` and the master key is pushed into the API service.

## Index lifecycle
- `addIndex()` — `createIndex(id)`, waits for the async task, then `updateIndex()`.
- `updateIndex()` — diffs and pushes **ranking rules** (`sort, words, attribute, typo, proximity,
  exactness` — `sort` deliberately first), **searchable attributes** (fulltext `text` fields, ordered
  by Search API boost desc), **sortable attributes** (all fields), and **filterable attributes**
  (all indexed fields + special fields, minus `id`). Resets synonyms if the synonyms processor was
  just disabled.
- `removeIndex()` — deletes the Meilisearch index unless the Search API index is read-only.
- `indexItems()` — converts items to documents (`ItemConverter`), `addDocuments(id, docs, 'id')`,
  waits for the task, then `manageStopWords()`.
- `deleteItems()` / `deleteAllIndexItems()` — delete by formatted document id / delete all.

## Special / reserved fields
`getSpecialFields()` adds an `id` field (Meilisearch document primary key) set from
`MeilisearchUtils::formatAsDocumentId($item->getId())` (non `[A-Za-z0-9_-]` → `_`). Using a Search
API field with machine name `id` is rejected (module form validators + presave hook).

## Search (query mapping)
`search(QueryInterface $query)`:
- Builds `filter` from the condition group via `filterParser->parseExpression()`.
- `offset` from options; `limit` from options, or an initial `limit: 0` probe whose
  `getEstimatedTotalHits()` becomes the limit when no explicit limit is set.
- Sorts: `search_api_relevance` → controls asc/desc (Meilisearch returns desc relevance natively;
  asc is handled by reversing hits in PHP); `search_api_random` → `shuffle()` in PHP
  (advertised via `getSupportedFeatures(): ['search_api_random_sort']`); other fields →
  `sort[] = "field:asc|desc"`.
- Results: iterates hits, keeps rows with `search_api_id`, builds Search API items; result count
  from `getEstimatedTotalHits()`.

## Availability & errors
- `isAvailable()` → `meiliService->ping()`.
- `viewSettings()` shows Meilisearch version + list of server-side index UIDs.
- `handleExceptions()` logs the message; on HTTP 403 shows "The master key is not correct.",
  otherwise a generic "check the logs" error.
- `__sleep()`/`__wakeup()` drop and re-resolve the API service so the backend serializes cleanly.

## Stop words
`manageStopWords()` — if the core `stopwords` processor is enabled, push its stopword list to
Meilisearch; otherwise reset the server stopwords.
