<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch VDB Provider (ai_vdb_provider_elasticsearch) — agent index

Registers **Elasticsearch** as a vector-database provider for the AI module's **AI Search** submodule, using
the native `dense_vector` field + HNSW kNN, with an optional **hybrid kNN + BM25 (RRF)** mode. Package
*AI Vector Database Providers (Experimental)*, `lifecycle: experimental`. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 1.0.0-rc1 (version-dir `1.0.x`).

Dependencies (info.yml): `ai:ai`, `ai:ai_search`, `key:key`, `search_api:search_api`. Composer `require`
also pulls `elasticsearch/elasticsearch ^8.0` and `smalot/pdfparser ^2.12` (vendor libraries).

- **Install, connection settings, config object/schema, routes & permission** →
  [config/settings.md](config/settings.md)
- **The VDB provider plugin, the ES client, query/filter/hybrid mechanics** →
  [plugins/vdb-provider.md](plugins/vdb-provider.md)
- **The optional PDF extractor + the MIME-type event subscriber** →
  [plugins/attachments-and-mime.md](plugins/attachments-and-mime.md)

## What it actually is

- VDB provider plugin `ElasticsearchVdbProvider` (id **`elasticsearch`**, label *"Elasticsearch (Native
  kNN)"*), `src/Plugin/VdbProvider/ElasticsearchVdbProvider.php`, extends
  `Drupal\ai\Base\AiVdbProviderClientBase`, `#[AiVdbProvider]` attribute.
- Client wrapper service **`ai_vdb_provider_elasticsearch.client`** = `ElasticsearchClient`
  (`src/ElasticsearchClient.php`), args `@logger.factory`. Builds the official
  `Elastic\Elasticsearch\Client` via `ClientBuilder` and does all index/search calls.
- Event subscriber service **`…text_document_mime_registrar`** = `TextDocumentMimeTypeRegistrar`
  (subscribes to `MimeTypeMapLoadedEvent`) — adds md/yaml/adoc/rst/org/toml/… → text MIME mappings.
- Search API Attachments extractor plugin `PhpPdfParserExtractor` (id **`php_pdfparser_extractor`**),
  active only when `search_api_attachments` is also enabled.
- Settings form `ElasticsearchConfigForm` at route **`…settings_form`** →
  `/admin/config/ai/vdb_providers/elasticsearch`, permission **`administer ai providers`**; menu under
  `ai.admin_vdb_providers`.
- Config object **`ai_vdb_provider_elasticsearch.settings`** (schema in `config/schema/`).
  `hook_requirements()` in `.install` warns if the ES client / pdfparser vendor libs are missing.
  **No permissions.yml, no Drush, no submodules.**

## Mechanism (from source)

- `initializeClient()` reads `host` (default `http://localhost:9200`), resolves an API-key Key entity
  (`api_key_id`) or a Basic-Auth password Key entity (`password_key_id`) via `key.repository`, and calls
  `ElasticsearchClient::getConnection($host, $api_key, $username, $password)`. API key takes precedence; if
  neither credential is set an **unauthenticated** client is built (for local dev clusters). The client is
  the official Elastic SDK `ClientBuilder` (default TLS transport).
- Index name = `getIndexName()` = `index_prefix` + a lowercased, `[^a-z0-9_]`-sanitized collection name.
- `createCollection()` maps a `dense_vector` field (dims + `similarity`) plus keyword fields
  (`drupal_entity_id`, `entity_type`, `bundle`, `langcode`, …) and a `text` `content` field; `dynamic:true`.
- `indexItems()` overrides the base to build one **Bulk API** request (`bulkInsert()`) instead of per-chunk
  HTTP calls; embeddings come from the AI Search `EmbeddingStrategyInterface`.
- Search: `vectorSearch()` JSON-decodes the prepared filter and dispatches to
  `ElasticsearchClient::vectorSearch()` (pure kNN) or `hybridSearch()` (kNN + BM25 + `rrf`) based on the
  `hybrid_search` config. The filter is applied as the kNN `filter` (pre-filter → access control).
- `prepareFilters()` builds an ES **bool** query from Search API `=`/`IN` conditions as structured
  `{term|terms: {field: value}}` clauses, then `json_encode`s it; values are placed as array data.

## Notes

- Experimental / rc. RRF hybrid mode needs ES 8.8+ and a compatible (non-free-tier) license; pure kNN works
  on the basic license.
- Similarity metric and vector dimensions are baked into the mapping at index-creation time — changing them
  means dropping and re-indexing.
