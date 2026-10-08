<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query endpoint, RAG flow & signed context

## Routes (`ai_search_block.routing.yml`)
- `ai_search_block.api` → `POST/GET /ai-search-block/query` → `AiSearchBlockController::search`,
  `_permission: 'access content'`.
- `ai_search_block.db_results` → `POST /ai-search-block/db-results` → `::getDbResults`,
  `_permission: 'access content'`.

## Signed stateless context (`ContextSigner/SearchContextSigner`)
The form block cannot rely on a config-entity id in Layout Builder (the id is a component UUID), so
block settings are addressed by a signed, encrypted payload:
- `createSignedPayload($context)` → AES-256-GCM encrypts the JSON (prefix `enc:`), then HMAC-SHA256
  signs the ciphertext (encrypt-then-MAC). Secret = site private key (`@private_key`) + hash salt.
- The payload carries a locator (`source: layout_builder|block_entity`, storage ids / block id) plus
  `iat` + `ttl` (7-day TTL). Legacy payloads may carry the full `search_config`.
- `verify($json, $sig)` re-computes the HMAC (`hash_equals`), decrypts, then enforces the `iat`/`ttl`
  freshness window. Returns the decoded array or NULL (fail-closed).

## `AiSearchBlockController::search()`
Reads `query`/`stream` from POST form fields or a JSON body. Calls `resolveSettings()`, which
requires a valid `search_context` + `search_context_sig`; with a `source` locator it reloads the
canonical block settings server-side (from Layout Builder section storage or the `block` config
entity), so prompts/models are never trusted from the client. Missing/invalid signature → 400.
Then, if `ai_search_block_log` is enabled, opens a log row (`ai_search_block_log_start`), and runs
`AiSearchBlockHelper::searchRagAction($query)`. Streaming returns a `StreamedResponse`; otherwise a
`JsonResponse` with `response` + `log_id`.

## `AiSearchBlockHelper` (service `ai_search_block.helper`)
RAG pipeline:
1. `validInput()` — reject queries containing configured `block_words` (returns `block_response`).
2. `getRagResults()` — loads the `search_api_index`, queries with `limit` = `max_results` (or
   `rerank_candidate_count` when reranking), sets `search_api_bypass_access` TRUE and
   `search_api_ai_get_chunks_result = rendered`, applies the optional retrieval prefix, executes.
3. Optional `rerankResults()` → `biEncoderReranking()` — cosine similarity of query vs. per-passage
   `raw_vector`, re-sorts, trims to `max_results`. (`crossEncoderReranking()` exists but is unused.)
4. `renderRagResponseAsString()` — for each hit below `score_threshold` skip; resolve the entity
   (`entity:TYPE/ID[:LANG]`), and **only keep it if `$entity->access('view', $currentUser)` passes**
   and (for nodes) it is published. So the raw vector retrieval is re-filtered per user before
   anything reaches the model.
5. `fullEntityCheck()` — renders kept entities (chunks or rendered node → markdown via
   `league/html-to-markdown`), substitutes `[question]`/`[entity]`/user/date placeholders into the
   `aggregated_llm` prompt, invokes `hook_ai_search_block_prompt_alter`, optionally splits into
   system/user on `---! SPLIT !---`, and calls the chosen provider (`llm_model` or AI default chat)
   through `drupal/ai`. Streams via `streamBackResponse()` (chunk delimiter `|§|`).

All LLM/embedding calls go through the `drupal/ai` `AiProviderPluginManager` — no direct HTTP, no
API keys handled here (the provider/key are configured in the AI module).

## `getDbResults()`
Traditional keyword results: resolves settings from the same signed context, loads the configured
View (`view_id:display_id`), sets the fulltext exposed input to the query, executes with paging, and
returns rendered HTML in a `JsonResponse`. Uses core Views (query builder), not string SQL.
