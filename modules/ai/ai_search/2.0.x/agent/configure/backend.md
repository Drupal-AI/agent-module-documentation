# Server backend configuration (`search_api_ai_search`)

There is no ai_search settings page. You configure everything on a **Search API server** whose backend
is **AI Search**, at `/admin/config/search/search-api/add-server` (or edit an existing server). The
backend plugin is `search_api_ai_search`
(`src/Plugin/search_api/backend/SearchApiAiSearchBackend.php`, extends `AiSearchBackendPluginBase`).

## Prerequisites (both come from the `ai` module)

1. An **embeddings AI provider** — `Configuration › AI › Providers` (`/admin/config/ai/providers`).
   The backend form errors out with a link if `aiProviderManager->hasProvidersForOperationType('embeddings')`
   is empty.
2. A **Vector DB (VDB) provider** — `Configuration › AI › VDB Providers`
   (`/admin/config/ai/vdb_providers`). Milvus, Pinecone, Qdrant, MySQL-vector, etc. are separate
   modules exposing `ai.vdb_provider` plugins; ai_search lists them via
   `vdbProviderManager->getSearchApiProviders(TRUE)`.

## Backend config keys

Stored under the server's `backend_config`; schema
`plugin.plugin_configuration.search_api_backend.search_api_ai_search`
(`config/schema/search_api_ai_search.backend.schema.yml`):

| Key | Meaning |
|---|---|
| `database` | The chosen VDB provider plugin id. Required. Renders a provider-specific settings subform via `vdbProviderManager->createInstance($id)->buildSettingsForm()`. |
| `database_settings.database_name` | VDB database/namespace name. |
| `database_settings.collection` | Collection / index name inside the VDB. |
| `database_settings.metric` | Similarity metric (cosine, euclidean, …). |
| `embeddings_engine` | The embeddings provider+model, stored as `"<provider_id>__<model_id>"` (split on `__` at query time). |
| `embeddings_engine_configuration.set_dimensions` | Whether dimensions are set manually. |
| `embeddings_engine_configuration.dimensions` | Vector dimension count; validated to be > 0. Leave blank/auto-detect otherwise. |
| `embedding_strategy` | Embedding strategy plugin id — `contextual_chunks` or `average_pool` (see [../plugins/embedding-strategy.md](../plugins/embedding-strategy.md)). |
| `embedding_strategy_configuration.chunk_size` | Max tokens per chunk (blank = model max). |
| `embedding_strategy_configuration.chunk_min_overlap` | Tokens copied from the previous chunk. |
| `embedding_strategy_configuration.contextual_content_max_percentage` | Portion of a chunk reserved for repeated contextual content. |
| `embedding_strategy_configuration.skip_moderation` | Skip the moderation layer on embeddings — only for advanced setups. |
| `embedding_strategy_details` | Free-text detail string. |
| `include_raw_embedding_vector` | If TRUE the raw stored vector is fetched into each result item's extra data as `raw_vector` (used by re-ranking / similarity search; minor perf cost). Added by update `10005`. |

The engine and strategy subforms are built by the traits
`Trait\AiSearchBackendEmbeddingsEngineTrait` and `Trait\AiSearchBackendEmbeddingsStrategyTrait`; the
strategy subform HTML advice comes from `assets/html/chunk-size-advice.html`.

## Behaviour / lifecycle notes

- On submit, `submitConfigurationForm()` calls `ensureCollectionExists()` →
  `vdbProviderManager->ensureCollectionExists()`, creating the VDB collection if missing.
- `NewServerEventSubscriber` (`ai_search.event_subscriber.new_server`) also ensures the collection on
  **config import / recipe apply** (listens to `ConfigEvents::SAVE` for `search_api.server.*`).
- `isAvailable()` = VDB `isSetup()` && `ping()`.
- `getDiscouragedProcessors()` marks `content_access`, `html_filter`, `number_field_boost`, `stemmer`,
  `tokenizer`, `type_boost`, `highlight` as not applicable — notably **`content_access` is discouraged
  because access is enforced in code by the backend, not stored in the VDB** (see
  [../api/search.md](../api/search.md) and [../plugins/rag.md](../plugins/rag.md)).
- `supportsDataType('embeddings')` is the only supported data type.
- Deleting a Search API index also deletes its `ai_search.index.<id>` config
  (`hook_search_api_index_delete`).

Several install `update_*` hooks migrate older server config: `10001` nests `database_settings`,
`10003` renames strategies (`metadata_average_pool`→`average_pool`, `metadata_chunks`→`contextual_chunks`)
and `metadata_max_percentage`→`contextual_content_max_percentage`, `10005` adds
`include_raw_embedding_vector`, `10007` moves the tokenizer chat model into
`embeddings_engine_configuration.tokenizer_chat_model`.
