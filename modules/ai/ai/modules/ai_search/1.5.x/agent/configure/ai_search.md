# Configure — set up a vector search server & index

AI Search has **no dedicated config route** (`configure` is null). You configure it entirely
through Search API's UI, choosing the AI Search backend when you create a server.

## Prerequisites (all separate installs)

1. `ai` (AI Core) + at least one **AI provider** that implements the `embeddings` operation
   type (e.g. OpenAI). Configure it under `/admin/config/ai/providers`.
2. A **Vector DB provider** module supplying an `AiVdbProvider` plugin (Milvus, Pinecone,
   pgvector, …). Configure it under `/admin/config/ai/vdb_providers`. The backend form
   errors out if no embeddings provider or VDB provider is set up.
3. `search_api`.

## 1. Create the server

Go to `/admin/config/search/search-api/add-server`
(route `entity.search_api_server.add_form`) and pick **AI Search** as the backend
(plugin id `search_api_ai_search`). The backend form (`SearchApiAiSearchBackend`) fields,
stored under `search_api.server.<id>:backend_config`:

| Config key | Purpose |
|---|---|
| `database` | Which `AiVdbProvider` (vector database) to use — **required**. |
| `database_settings.database_name` / `.collection` / `.metric` | VDB-specific: DB name, collection/index name, similarity metric. Fields are supplied by the chosen provider's own settings form. |
| `embeddings_engine` | The AI provider+model used to vectorize content, as `provider__model`. |
| `embeddings_engine_configuration.set_dimensions` / `.dimensions` | Optionally override the embedding vector size (cannot change after the collection is created). |
| `embedding_strategy` | Chunking strategy plugin id — `contextual_chunks` (default) or `average_pool`. |
| `embedding_strategy_configuration.chunk_size` / `.chunk_min_overlap` / `.contextual_content_max_percentage` / `.skip_moderation` | Chunk length, overlap, max % of a chunk that is contextual, and moderation skip. |
| `chat_model` | Tokenizer model used only to count tokens accurately per chunk. |
| `include_raw_embedding_vector` | If checked, the raw vector is added to each result item's extra data (`raw_vector`) for re-ranking. |

Saving the form calls `ensureCollectionExists()` on the VDB provider, creating the
collection. **Changing the embedding strategy or engine requires re-indexing everything.**

## 2. Add an index

Create a Search API index (`/admin/config/search/search-api/add-index`) pointing at the AI
Search server and a datasource (e.g. Content). Only the `embeddings` data type is supported
by the backend; ordinary keyword processors (`html_filter`, `stemmer`, `tokenizer`,
`type_boost`, `number_field_boost`) are reported as *discouraged*.

## 3. Configure field indexing options (required)

AI Search overrides the index **Fields** form
(`/admin/config/search/search-api/index/{search_api_index}/fields`, class
`AiSearchIndexFieldsForm`, installed via `hook_entity_type_alter`). For each field pick an
**indexing option** (main content / contextual content / filterable metadata — from
`EmbeddingStrategyIndexingOptions`), and optionally a per-field max length. These are stored
in simple config `ai_search.index.<index_id>` (keys: `indexing_options`,
`control_field_max_length`, `exclude_chunk_from_metadata`) — **not** in the Search API index
config. The index status page warns if indexing options have not been set. Then index as
usual (`drush search-api:index` or the UI).

## Query-time notes

- Results are filtered by entity `view` access per user unless the query sets the option
  `search_api_bypass_access = TRUE`.
- `search_api_ai_get_chunks_result = TRUE` returns one result row per chunk instead of per
  source item.
- `search_api_ai_max_pager_iterations` caps how many extra fetch passes run while satisfying
  access checks.
