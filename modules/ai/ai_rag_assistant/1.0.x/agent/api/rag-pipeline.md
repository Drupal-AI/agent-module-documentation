<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RAG AI Assistant — pipeline, services & chat API

## Services (constructor DI, `ai_rag_assistant.services.yml`)
- `Service\EmbeddingService(@http_client, @config.factory, @logger.factory)`
- `Service\VectorStorageService(@database, @logger.factory, @datetime.time)`
- `Service\RagService(@…embedding, @…vector_storage, @http_client, @config.factory, @entity_type.manager, @logger.factory)`

## Indexing — `RagService::indexNode(NodeInterface)` (`src/Service/RagService.php:72`)
1. `extractNodeText()` (:120) — concatenates `Title:` + each non-ignored field's value; `text*`/`string*` fields
   `strip_tags`'d, `entity_reference` fields contribute the referenced entity's `label()`. (An `ignored_fields` list skips
   base/revision/path fields.)
2. `VectorStorageService::deleteEntityEmbeddings()` to clear old chunks.
3. `EmbeddingService::chunkText()` (:165) — strip tags, decode entities, collapse whitespace, split into `chunk_size`-word
   windows sliding by `chunk_size - chunk_overlap`.
4. `EmbeddingService::generateBatchEmbeddings()` — Gemini `…:batchEmbedContents?key=…`.
5. `VectorStorageService::storeEmbedding()` — `merge` into `rag_embeddings` keyed on (entity_type, entity_id, chunk_index);
   embedding stored as `serialize($vector)` in a blob.

## Retrieval + generation — `RagService::query(string $query, array $chat_history)` (:196)
1. `EmbeddingService::generateEmbedding($query)` — Gemini `…:embedContent?key=…`.
2. `VectorStorageService::searchSimilar($embedding, top_k, threshold, content_types)` (:133) — selects up to 10,000
   `rag_embeddings` rows (optionally `bundle IN content_types`), `unserialize(…, ['allowed_classes' => FALSE])` each stored
   vector, computes `cosineSimilarity()` in PHP, keeps ≥ threshold, sorts desc, returns top-k `{entity_type, entity_id,
   bundle, chunk_text, similarity}`.
3. Loads each source entity (`entityTypeManager->getStorage(type)->load(id)`), builds `$sources` (title, `toUrl()`, similarity)
   and a `$context` string of `Source: "title" (relevance …%)\n chunk_text`.
4. `generateResponse()` → `buildPrompts()` (system prompt + augmented prompt; behavior depends on `allow_general_knowledge`
   and whether a strong match ≥ 0.6 exists), then `match($generation_provider)` dispatches to:
   - `callGeminiApi()` — POST `https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent?key={key}`,
     with model fallbacks; temp 0.3, maxOutputTokens 2048.
   - `callOpenAiApi()` — POST `https://api.openai.com/v1/chat/completions`, `Authorization: Bearer {key}`.
   - `callAnthropicApi()` — POST `https://api.anthropic.com/v1/messages`, `x-api-key: {key}`, `anthropic-version: 2023-06-01`.
5. Returns `['answer' => string, 'sources' => array]`.

All three provider calls use `@http_client` (Guzzle) with a 60s timeout. Gemini authenticates with a URL
`?key=` parameter (per Google's API); OpenAI/Anthropic use an `Authorization` header.

## Chat API — `RagChatController` (`src/Controller/RagChatController.php`)
- `chatPage()` (:72) — returns render array (theme `rag_chat_page`) and `drupalSettings.aiRagAssistant`
  (`sessionId = 'rag_'.uid.'_'.time()`, `chatApiUrl = '/api/rag-chat'`).
- `chatApi(Request)` (:96) — `json_decode` body; require non-empty `message`; reject > 2000 chars; read `session_id`;
  fetch last 10 history rows for context; `storeMessage(user)`; `RagService::query()`; `storeMessage(assistant, …, sources)`;
  return `JsonResponse{answer, sources}`. Route requires `use rag ai assistant`, method POST.
- `storeMessage()` / `getChatHistory()` — insert/select on `rag_chat_history` (sources `serialize`'d).

## Front-end render (`js/rag-chat.js`, `js/rag-chat-block.js`)
`sendMessage()` POSTs `{message, session_id}` to `chatApiUrl`; `appendMessage()` runs the answer through
`formatText()` → `escapeHtml()` (via `document.createTextNode`) first, then applies markdown regexes for
`**bold**`/`*italic*`/```code```/`` `inline` ``/newlines, and sets `bubbleDiv.innerHTML`. Sources render as `<a>` with
`link.textContent = source.title` and `link.href = source.url`.
