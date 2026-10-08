<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Chat — indexing, retrieval & chat services

Three services (`ai_content_chat.services.yml`) plus a controller and block drive the RAG flow.

## `Service/ContentIndexer` (`ai_content_chat.indexer`)
Deps: entity type manager, entity field manager, config factory, database, logger, messenger, `FileTextExtractor`.

- **`getContentSources()`** — reads `content_sources` config, normalizes to `{entity_type, bundle, fields}` (back-compat: legacy `content_type` → `bundle`).
- **`indexContent(): int`** — synchronous full index. Truncates `ai_content_chat_index`, then per source `queryEntities()` → `loadMultiple()` → `extractContentFromEntity()`, `merge()`s a row per non-empty entity, saves `last_indexed`.
- **`startBatchIndex()`** — collects all entity ids across sources, truncates the table, splits into chunks of 50, and runs `batchProcess()`/`batchFinished()` (static Batch API callbacks). Used by the settings form's "Re-index" button.
- **`queryEntities($entity_type_id, $bundle): array`** — builds an entity query for the source, adding the bundle condition when the type has a bundle key and a `published = 1` condition when the type has a published-status key.
- **`extractContentFromEntity($entity, $fields): string`** — per configured field: `string`/`string_long` → raw value; `text*` → `strip_tags(html_entity_decode($value))`; `file` → `FileTextExtractor::extractText()`; `entity_reference` to a media entity → resolves the media source field's file and extracts its text. Parts joined with `\n\n`.
- **`indexSingleEntity($entity)`** — called from `hook_entity_insert/update`; indexes only if the entity's `type:bundle` is a configured source. Removes the row if the entity has a published status key and is unpublished, or if no indexable text remains.
- **`removeEntity($entity)`** — deletes the row (called from `hook_entity_delete`).
- **`getIndexedCount(): int`** — row count; used by `ChatService` and the block to detect an empty index.
- **`searchContent($query, $limit = 5): array`** — reads rows from `ai_content_chat_index`, tokenizes the question, drops stop words, and scores each row by keyword occurrence count in `title + content` (+5 bonus for a title hit); returns the top `$limit` `{id, type, title, content}` items. (Keyword scoring in PHP — no embeddings/vectors.)
- **`formatAsContext($items): string`** — joins items as `### {title}\n{content}` separated by `---`.

## `Service/FileTextExtractor` (`ai_content_chat.file_text_extractor`)
Deps: file system, logger. `extractText(FileInterface): string` — skips files over `MAX_FILE_SIZE` (10 MB) and unsupported extensions (`SUPPORTED_EXTENSIONS = txt, srt, csv, pdf, docx`), resolves the real path via `FileSystem::realpath()`, dispatches to per-type extractors. `srt` strips sequence numbers/timestamps; `pdf` uses `Smalot\PdfParser` (warns if not installed); `docx` uses `PhpOffice\PhpWord` (warns if not installed) and walks elements recursively. All failures log and return `''`.

## `Service/ChatService` (`ai_content_chat.chat_service`)
Deps: config factory, `ai.provider` (`AiProviderPluginManager`), `ContentIndexer`, logger.

`chat($message): array` (returns `{response, success}`):
1. Returns a "not configured" message if `ai_provider`/`ai_model` are empty, or a "no content indexed" message if `getIndexedCount() === 0`.
2. `searchContent($message, 5)` → `formatAsContext()`; if empty, returns `fallback_message` (success TRUE).
3. Builds the system prompt by `str_replace('{context}', $context, system_prompt)`.
4. `createInstance($provider_id, ['temperature'=>…, 'max_tokens'=>…])`, then `$provider->chat(new ChatInput([system, user messages]), $model_id, [])` — all through the Drupal AI abstraction (no direct HTTP; provider handles auth/TLS).
5. `extractResponseText()` normalizes the AI response (ChatOutput `getNormalized()->getText()`, OpenAI-style array, string, or `getText()`). Exceptions are logged and return a generic error message.

## `Controller/ChatApiController`
- **`chat(Request): JsonResponse`** — decodes JSON body, reads `message` (or `question`), trims; empty → 400. Otherwise `ChatService::chat()` → `{answer, success}`.
- **`reindex(Request): JsonResponse`** — `ContentIndexer::indexContent()` → count; catches exceptions to a 500. (Route `administer ai content chat`.)

## `Plugin/Block/ChatbotBlock`
Renders `#theme => 'ai_content_chat_widget'` with title/placeholder/welcome message and attaches `drupalSettings.aiContentChat` (`apiEndpoint '/api/ai-content-chat/ask'`, `isConfigured`, colors, texts) plus the `ai_content_chat/chatbot` library. `isConfigured` is true only when provider+model are set and the index is non-empty. Cache tag `config:ai_content_chat.settings`.

## Front-end (`js/chatbot.js`)
`Drupal.behaviors.aiContentChat` wires the widget: fetches `session/token`, POSTs `{message}` with `X-CSRF-Token` to the ask endpoint, and appends the returned `answer` to the message list. Rendered via `bubbleDiv.textContent = text` (DOM text node); the Twig template outputs its variables through standard auto-escaping.
