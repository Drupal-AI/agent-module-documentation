<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search (ai_search) — agent index

A **Search API backend** (`search_api_ai_search`) that indexes content as **vector embeddings** in a
vector database (Milvus, Pinecone, Qdrant, MySQL-vector, … — supplied as VDB providers by the `ai`
module) and answers Search API queries by semantic nearest-neighbour lookup rather than keyword
match. Content is split into **chunks** by a pluggable **embedding strategy**, each chunk embedded via
an `ai` embeddings provider, and stored with metadata. On query the search terms are embedded the same
way and compared by distance. It is the retrieval half of **RAG**: it also ships a function-call tool
(`ai_search:rag_search`), an AI-assistant action (`rag_action`), and an AI API Explorer form
(`vector_db_generator`) so assistants/chatbots can pull relevant passages. Standalone project
`drupal/ai_search` — historically a submodule of `ai`, now split out.

Entry points are all **inside Search API's own admin UI** — there is no ai_search settings page and no
routes/controllers of its own. You configure a Search API **server** (pick the "AI Search" backend +
VDB + embeddings engine + embedding strategy), an **index** (with the "AI Search Chunked Tracker"),
and the index **Fields** tab (which ai_search overrides to add per-field *indexing options*). Two
**boost processors** let a traditional Database/Solr index prepend semantically-relevant results
("hybrid search"). **Access control is enforced by default**: the backend does a post-query
`entity->access('view', currentUser)` check per matched entity (`checkEntityAccess()`), iterating the
VDB for more candidates to backfill the requested limit; it is only skipped when a caller explicitly
sets `search_api_bypass_access`.

- Depends on: `ai:ai`, `search_api:search_api (>=8.x-1.40)`. Composer: `drupal/ai` (2.x),
  `league/html-to-markdown ^5.1`. Suggests `league/commonmark` (chunk preview / chatbot formatting).
- Core: `^10.4 || ^11`. Package: `AI (Experimental)`. **`lifecycle: experimental`, release
  `2.0.0-alpha2`.**
- **No** dedicated settings page / `configure` route, **no** routes, **no** permissions, **no** drush
  commands. Provides config schema. Defines **one plugin type: `EmbeddingStrategy`** (manager
  `ai_search.embedding_strategy`).
- Extends the `search_api_item` DB table with two columns (`total_chunks`, `processed_chunks`) at
  install; removed on uninstall.

## What you'd do → where

- **Set up the server: choose VDB, embeddings engine, embedding strategy, chunk size / dimensions** →
  [configure/backend.md](configure/backend.md)
- **Configure which fields are indexed and how (Main/Contextual/Attributes), the tracker, score
  threshold, hybrid boost** → [configure/index-fields.md](configure/index-fields.md)
- **Query the index from PHP, similarity search via `vector_input`, query options, result extra data,
  the boost mechanism, alter hooks** → [api/search.md](api/search.md)
- **Write a custom embedding strategy (the plugin type this module defines) / the two bundled
  strategies** → [plugins/embedding-strategy.md](plugins/embedding-strategy.md)
- **Wire the index into RAG: the function-call tool, the assistant action, the explorer, and the
  access model** → [plugins/rag.md](plugins/rag.md)

## Key facts (real machine names)

- Search API **backend**: `search_api_ai_search`
  (`Plugin\search_api\backend\SearchApiAiSearchBackend`, base `Backend\AiSearchBackendPluginBase`).
- Search API **tracker**: `ai_search_tracker` (`Plugin\search_api\tracker\AiSearchTracker`, extends
  Basic; tracks per-item chunk progress).
- Search API **processors**: `ai_search_score_threshold` (`ScoreThreshold`, postprocess),
  `database_boost_by_ai_search` (`DatabaseBoostByAiSearch`), `solr_boost_by_ai_search`
  (`SolrBoostByAiSearch`) — the last two extend `BoostByAiSearchBase`.
- **Plugin type defined here**: `EmbeddingStrategy` — attribute
  `Drupal\ai_search\Attribute\EmbeddingStrategy`, interface `EmbeddingStrategyInterface`, bases
  `Plugin\EmbeddingStrategy\EmbeddingBase` / `Base\EmbeddingStrategyPluginBase`, dir
  `Plugin/EmbeddingStrategy`, manager service `ai_search.embedding_strategy`, alter hook
  `embedding_strategy_info`. Bundled ids: `contextual_chunks` (Enriched/recommended), `average_pool`
  (Enriched Composite).
- **AI-suite plugins** (consumed by other modules): AiFunctionCall `ai_search:rag_search`
  (function_name `ai_search_rag_search`, `Plugin\AiFunctionCall\RagTool`); AiAssistantAction
  `rag_action` (`Plugin\AiAssistantAction\RagAction`, actions `search_rag`, `reuse_rag`); AiApiExplorer
  `vector_db_generator` (`Plugin\AiApiExplorer\VectorDBGenerator`).
- **Services**: `ai_search.embedding_strategy`, `ai_search.event_subscriber.new_server`
  (ensures VDB collection exists on config save/import), `ai_search.event_subscriber.solr_boost_by_ai_search`.
  Service provider `AiSearchServiceProvider` swaps `search_api.indexing_batch_helper` for
  `Utility\AiSearchIndexingBatchHelper`.
- **Config objects**: per-index `ai_search.index.<index_id>` (indexing options, exclude flags); backend
  schema `plugin.plugin_configuration.search_api_backend.search_api_ai_search`.
- **Hooks implemented**: `hook_entity_type_alter` (sets `fields` form of `search_api_index` to
  `Form\AiSearchIndexFieldsForm`), `hook_query_search_api_db_search_alter`, `hook_search_api_index_delete`,
  `hook_preprocess_search_api_index`, `hook_schema_alter`, `hook_form_search_api_index_form_alter`,
  `hook_install`/`hook_uninstall`, updates `10001`–`10009`. **Hook provided**:
  `hook_ai_search_boost_results_alter(&$results, $keywords, $ai_search_index, $target_index)`
  (`ai_search.api.php`).
- **Library**: `ai_search/conditional_tracker` (`assets/js/conditional-tracker.js`).
- **Query options** it understands: `search_api_bypass_access`, `search_api_ai_get_chunks_result`,
  `search_api_ai_max_pager_iterations`, `vector_input`, `ai_search_score_threshold_override`. Result
  extra data: `content`, `drupal_entity_id`, `drupal_long_id`, `raw_vector`, `real_offset`,
  `reason_for_finish`, `current_vector_score`.
