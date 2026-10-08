# api — RAG tool, query options, processors, services

AI Search exposes no `*.api.php` hook file. Programmatic use is: run Search API queries
against an AI Search index, call the RAG function-call tool, or add boost processors.

## RAG function-call tool

`ai_search:rag_search` (`src/Plugin/AiFunctionCall/RagTool.php`) — a `FunctionCall` (AI Core
tool) an LLM/agent can invoke to retrieve indexed content.

- function name: `ai_search_rag_search`, group `information_tools`.
- context params: `index` (string, required), `search_string` (string, required),
  `amount` (int, default 10), `min_score` (float, default 0.5).
- Implements `StructuredExecutableFunctionCallInterface`. Instantiate it via AI Core's
  `plugin.manager.ai.function_call` manager.

`RagAction` (`Plugin/AiAssistantAction/rag_action`) is the equivalent action for the AI
Assistant API, letting a configured assistant answer from indexed content (retrieval-
augmented chat). Access control is enforced by default (see update hook `ai_search_update_10006`).

## Running a semantic query in code

Query an AI Search index like any Search API index (`$index->query()`), then set AI-Search
query **options** before `->execute()`:

| Option | Effect |
|---|---|
| `search_api_bypass_access` (bool) | Skip per-entity `view` access checks (default performs them). |
| `search_api_ai_get_chunks_result` (bool) | Return one result per chunk (`entity_id:chunk`) instead of per source item. |
| `search_api_ai_max_pager_iterations` (int) | Max extra fetch passes while satisfying access checks (default 10). |
| `limit` / `offset` | Standard paging (default limit 10). |

Result items carry extra data set by the backend: `real_offset`, `reason_for_finish`,
`current_vector_score`, and — if `include_raw_embedding_vector` is on — `raw_vector`.
Relevance is a distance `score`; sort with `search_api_relevance` (`DESC`/`ASC`).

Empty keys run `querySearch()` (metadata-only filter query); non-empty keys embed the string
via the configured engine and run `vectorSearch()` on the VDB provider.

## Search API processors (combine AI relevance with keyword search)

| Processor id | Purpose |
|---|---|
| `database_boost_by_ai_search` | Re-orders a normal **database** Search API index using relevance from a companion AI Search index. |
| `solr_boost_by_ai_search` | Same, for a **Solr** index (applies via `SolrBoostByAiSearchEventSubscriber`). |
| `ai_search_score_threshold` | Drops results below a minimum relevance/distance score. |

Config keys (boost processors): `search_api_ai_index`, `minimum_relevance_score`,
`number_to_return`, `exact_phrase_action`, `exact_phrase_action_reduce_number`.

## Services

- `ai_search.embedding_strategy` — the `EmbeddingStrategyPluginManager` (see plugins doc).
- Event subscribers (internal): `ai_search.event_subscriber.new_server` (validates the VDB
  provider on a new server) and `ai_search.event_subscriber.solr_boost_by_ai_search`.

## What it consumes from AI Core

- `ai.vdb_provider` — the `AiVdbProvider` plugin manager (vector storage). **AI Search cannot
  work without a VDB provider.**
- `ai.provider` — used for the `embeddings` operation type (`EmbeddingsInput` → vector).
- `ai.tokenizer` — token counting per chunk.
