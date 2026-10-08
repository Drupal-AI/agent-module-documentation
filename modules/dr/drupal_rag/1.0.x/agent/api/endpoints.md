<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP endpoints — RagQueryController

`Controller\RagQueryController` (`ControllerBase`) exposes four routes (`drupal_rag.routing.yml`).
The three API routes require **`_permission: 'access rag query'`**, `methods: [POST]`, and
`_format: json`; each reads the JSON request body with `json_decode($request->getContent(), TRUE)`
and returns a `JsonResponse`. The status route is admin-only.

DI (`create()`): `drupal_rag.query_service` (`RagQueryService`), `drupal_rag.augment_service`
(`AugmentService`), `drupal_rag.vector_storage` (`VectorStorage`).

## POST /api/rag/query → `query()`

Raw retrieval. Body: `{"query": "...", "limit"?: int, "min_score"?: float}`. Missing/empty `query`
→ `400 {"error": "Missing \"query\" field."}`. Calls `RagQueryService::query($query, $options)`;
returns `{"results": [...]}` (empty array when nothing matches). Each result row:
`entity_type`, `entity_id`, `entity_label`, `bundle`, `chunk_index` (int), `chunk_text`,
`langcode`, `similarity` (float), `metadata`.

## POST /api/rag/prompt → `prompt()`

Body: same `query`/`limit`/`min_score`. Calls `AugmentService::buildPrompt()` and returns
`{"prompt": "<assembled template>", "sources": [{entity_type, entity_id, bundle, chunk_index,
similarity}, ...]}`. No LLM call — the prompt is meant to be sent to any external model.

## POST /api/rag/augment → `augment()`

Body: `query`/`limit`/`min_score` plus optional `model` (Ollama model name override). Calls
`AugmentService::generate()`, which builds the prompt then calls `OllamaClient::chat()`
(`POST {base_url}/api/chat`, `stream: false`). Returns `{"response": "...", "sources": [...],
"prompt": "..."}`, plus an `"error"` key if Ollama failed. Model resolution:
request `model` → `ollama_chat_model` → `ollama_model` → `nomic-embed-text`.

## /admin/reports/drupal-rag → `status()`

Admin route (`administer site configuration`), renders `#markup` with
`VectorStorage::getTotalChunks()` — the total row count in `drupal_rag_embeddings`.

## Options / defaults

`limit` and `min_score` are cast to `(int)`/`(float)` in the controller; when omitted,
`RagQueryService::query()` defaults `limit = 10`, `min_score = 0.0`. The query text is sanitized and
prefixed `search_query:` before embedding (see [services/pipeline.md](../services/pipeline.md)).

## Example

```bash
curl -X POST https://example.com/api/rag/query \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  --data '{"query":"What is the refund policy?","limit":5,"min_score":0.5}'
```

Callers must hold `access rag query` (send session/cookie or an authenticated request per your API
auth setup). All three endpoints are POST + `_format: json`.
