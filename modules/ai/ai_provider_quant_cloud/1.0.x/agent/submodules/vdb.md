<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Quant Cloud VectorDB Provider (ai_provider_quant_cloud_vdb)

Bundled submodule at `modules/ai_provider_quant_cloud_vdb/`. Adds an **AI Search / Search API vector-database backend** on top of the parent's `QuantCloudVectorDbClient`. Documented here as a subpage (no separate stub doc tree exists).

- **Machine name:** `ai_provider_quant_cloud_vdb` · **Package:** AI · same project/version (1.0.0, `1.0.x`).
- **Dependencies:** `ai_provider_quant_cloud:ai_provider_quant_cloud`, `ai:ai_search`, `search_api:search_api`.
- **Enable:** `composer require drupal/search_api` then `drush en -y search_api ai_search ai_provider_quant_cloud_vdb`.
- No routes, no permissions, no `.module`, no services of its own — it registers one plugin and reuses the parent's `ai_provider_quant_cloud.settings` config and `ai_provider_quant_cloud.vectordb_client` service.

## Plugin: `quant_cloud_vdb`

`Plugin\VdbProvider\QuantCloudVdbProvider` (extends `Drupal\ai\Base\AiVdbProviderClientBase`), declared `#[AiVdbProvider(id: 'quant_cloud_vdb', label: 'Quant Cloud VectorDB')]`. Selected as the "Vector Database provider" on an AI Search backend (`Configuration > Search and metadata > Search API`, backend "AI Search").

`create()` injects `config.factory`, `key.repository`, `event_dispatcher`, `entity_field.manager`, `messenger`, and the parent `ai_provider_quant_cloud.vectordb_client`. `getConfig()` returns `ai_provider_quant_cloud.settings`; `isSetup()` requires `auth.access_token_key` + `auth.organization_id`; `ping()` = a successful `listCollections()`.

### Config schema

`config/schema/ai_provider_quant_cloud_vdb.schema.yml` defines `ai_vdb_provider.plugin.quant_cloud_vdb` → `database_settings.{database_name, collection, metric}`. The settings form (`buildSettingsForm()`) hides `database_name` (forced to `quant_cloud`) and the metric selector (forced to cosine), and adds a **"Server-side embeddings"** checkbox (`server_side_embeddings`, default TRUE) — when on, embeddings are generated on Quant's servers instead of sequentially in Drupal.

### Collection / indexing operations (all via the parent VDB client)

- `getCollections()` → `listCollections()` names. `createCollection($name,$dim,$metric)` posts a collection with model `amazon.titan-embed-text-v2:0` (dimension derived server-side). `dropCollection()` → `deleteCollection()`.
- `resolveCollectionId($name)` — returns the name if it already matches a UUID regex, else looks it up by exact name match in `listCollections()` (throws `RuntimeException` if not found).
- `indexItems()` — deletes prior docs for the items, then either (server-side mode) extracts+chunks content via the embedding strategy's `groupFieldData()`/`prepareChunkText()` and uploads text with no vector, or (standard mode) generates embeddings in Drupal and uploads `content`+`metadata`+`vector`. All docs are batch-uploaded in one `uploadDocuments()` call. Metadata carries `server_id`, `index_id`, `drupal_long_id`, `drupal_entity_id`.
- `insertIntoCollection()` — single-doc upload; records a `drupal_long_id → document_id` map in Drupal state (`ai_provider_quant_cloud.vdb_mapping.<collection>`).
- Deletion: `deleteItems()` deletes by `drupal_entity_id` metadata; `deleteFromCollection()` by `drupal_long_id`; `deleteAllIndexItems()` uses `purgeAll` and clears the state map.

### Search

- `vectorSearch($collection,$vector_input,…)` — takes the first input vector, calls `queryByVector($id,$vector,$limit,0.0,TRUE)`, and maps each result to `{id: drupal_long_id, drupal_entity_id, distance: score, content}` for `SearchApiAiSearchBackend`.
- `querySearch()` (no-vector) returns `[]` (unsupported). `prepareFilters()` returns `''` (metadata filtering not yet supported). `getRawEmbeddingFieldName()` = `embedding`. `getVdbIds()` reads the state id-map.

Search terms/vectors are passed as JSON body fields to the VectorDB API; collection identifiers are UUID-validated or resolved by exact name. HTTP uses the shared Guzzle client with Bearer auth.
