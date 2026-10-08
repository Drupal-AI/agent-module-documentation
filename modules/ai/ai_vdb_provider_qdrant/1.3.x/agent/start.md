<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Qdrant VDB Provider (ai_vdb_provider_qdrant) — agent index

Adds **Qdrant** as a vector-database provider for the Drupal **AI** module so **AI Search** can store and
query embeddings in a Qdrant server over its HTTP REST API. Package *AI Vector Database Providers
(Experimental)*, `lifecycle: experimental`. Depends on `ai`, `ai_search`, `key` (and `search_api` via
composer). Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.3.3. No permissions of its own, no
Drush, no entities.

- **Connection config (host / port / API key), the settings form and route** →
  [config/settings.md](config/settings.md)
- **The `qdrant` VdbProvider plugin, the `QdrantClient` HTTP service, and Search-API→Qdrant filter
  translation** → [plugins/vdb_provider.md](plugins/vdb_provider.md)

## What it actually is

- One plugin: `QdrantProvider` (id **`qdrant`**, label *"Qdrant vector DB"*) in
  `src/Plugin/VdbProvider/QdrantProvider.php`, extending `ai`'s `AiVdbProviderClientBase` and declared
  with the `#[AiVdbProvider]` attribute. AI Search's server backend picks it as the vector store.
- One service: **`ai_vdb_provider_qdrant.client`** = `QdrantClient` (`src/QdrantClient.php`), constructed
  with `@http_client_factory`. It wraps the Qdrant REST endpoints (collections, points, scroll, search).
- One config object: **`ai_vdb_provider_qdrant.settings`** (`host`, `port`, `api_key`), schema in
  `config/schema/`, install defaults in `config/install/` (`host: ""`, `port: null`).
- One route: **`ai_vdb_provider_qdrant.settings_form`** → `/admin/config/ai/vdb_providers/qdrant`
  (`QdrantConfigForm`), permission **`administer ai providers`**; menu link under the AI VDB providers
  group (`ai.admin_vdb_providers`).
- One hook in `.module`: `hook_search_api_index_update()` calls `QdrantClient::updateFields()` — a no-op,
  since Qdrant is schemaless. Helper `ai_vdb_provider_qdrant_is_field_multiple()` reports field cardinality.
- Custom exception classes under `src/Exception/` (one per Qdrant operation).

## Mechanism (from source)

- **Connection**: `QdrantProvider::getConnectionData()` reads `host`/`port` from config (or per-instance
  `configuration` override), resolves `api_key` from a **Key entity** via `keyRepository->getKey(...)`,
  and defaults port to `6333`. `QdrantClient::getConnection()` prepends `http://` if the host has no
  scheme, then `base_url = rtrim(host,'/') . ':' . port`. `Api-Key` header is sent only when a key is set.
- **Indexing**: `indexItems()` calls `ensureCollectionExists()` (creates the collection with the embedding
  `dimensions`, default 1536), deletes any prior points for the items, then upserts one point per embedding
  chunk. Point id = `md5(drupal_long_id)`; native fields (`drupal_entity_id`, `drupal_long_id`, `content`,
  `vector`, `server_id`, `index_id`) plus any extra indexed fields go into the Qdrant `payload`.
- **Search**: `vectorSearch()` posts to `/points/search` with the query vector; `querySearch()` posts to
  `/points/scroll` with paging + optional filter. `getVdbIds()` scrolls by `drupal_entity_id match.any` to
  map Drupal ids back to point ids for deletion.
- **Filters**: `prepareFilters()` → `convertConditionGroupToQdrant()` walks the Search API condition group
  recursively and builds Qdrant `must` / `should` / `must_not` clauses; `validateQdrantFilter()` rejects
  malformed structures. Values are placed as typed JSON (`match.value`, `match.any`, `range.*`) — never
  string-concatenated into a query.

## Notes / caveats

- `createCollection` / `dropCollection` / `deleteFromCollection` failures are **caught and logged as
  warnings**, not thrown — indexing continues (clearing an index may try to drop a not-yet-created
  collection, which is expected).
- Collection distance is hard-coded to `Cosine` in `QdrantClient::createCollection()`, while
  `vectorSearch()` reads the configured `metric` from the AI Search server backend config for scoring.
- `updateFields()` is intentionally a no-op (Qdrant is schemaless); fields are created implicitly on
  insert.
