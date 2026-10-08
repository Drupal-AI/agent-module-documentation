<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RAG AI Assistant (ai_rag_assistant) — agent index

Self-contained RAG chatbot over Drupal node content. Indexes published nodes into DB-stored vector embeddings (Gemini embedding API), retrieves by cosine similarity, and generates answers with Gemini/OpenAI/Anthropic. Version **1.0.1**. Core `^10.3 || ^11 || ^12`.

**Dependencies:** core `node` only. Does **not** depend on `drupal/ai` — it calls provider REST APIs directly via `@http_client`.

**Routes (`ai_rag_assistant.routing.yml`):**
- `ai_rag_assistant.settings` → `Form\SettingsForm`, `/admin/config/ai/rag-assistant` (`administer rag ai assistant`).
- `ai_rag_assistant.index_content` → `Form\IndexContentForm`, `/admin/config/ai/rag-assistant/index` (`administer rag ai assistant`).
- `ai_rag_assistant.chat_page` → `RagChatController::chatPage`, `/rag-chat` (`use rag ai assistant`).
- `ai_rag_assistant.chat_api` → `RagChatController::chatApi`, `/api/rag-chat`, POST (`use rag ai assistant`).

**Permissions (`*.permissions.yml`):** `administer rag ai assistant`, `use rag ai assistant` (neither is `restrict access: true`).

**Services (`*.services.yml`):**
- `ai_rag_assistant.embedding` → `Service\EmbeddingService` — Gemini `embedContent`/`batchEmbedContents`, plus `chunkText()`.
- `ai_rag_assistant.vector_storage` → `Service\VectorStorageService` — DB CRUD on `rag_embeddings` + `searchSimilar()` cosine ranking in PHP.
- `ai_rag_assistant.rag` → `Service\RagService` — pipeline: `indexNode()`, `query()`, `generateResponse()` → `callGeminiApi`/`callOpenAiApi`/`callAnthropicApi`.

**Block:** `Plugin\Block\RagChatBlock` (id `rag_chat_block`, category AI) — floating chat widget; `blockAccess` = `use rag ai assistant`.

**Hooks (`ai_rag_assistant.module`):** `hook_entity_insert`/`update` auto-index published nodes of configured types; `hook_entity_delete` removes embeddings; `hook_cron` prunes `rag_chat_history` > 30 days; `hook_theme` (`rag_chat_page`, `rag_chat_block`).

**Database (`ai_rag_assistant.install`):** `rag_embeddings` (chunk_text + serialized embedding blob per node chunk), `rag_chat_history` (per-session messages + serialized sources).

**Config:** `ai_rag_assistant.settings` — `gemini_api_key`, `embedding_model`, `generation_provider`, `generation_model`, `openai_api_key`/`openai_generation_model`, `anthropic_api_key`/`anthropic_generation_model`, `chunk_size` (500), `chunk_overlap` (50), `top_k` (5), `similarity_threshold` (0.3), `allow_general_knowledge` (false), `system_prompt`, `content_types` ([]). Schema in `config/schema/`.

**Front end:** libraries `chat` / `chat_block`; `js/rag-chat.js` + `js/rag-chat-block.js` POST to `/api/rag-chat` and render answers (markdown → HTML after `escapeHtml`). Templates `rag-chat-page.html.twig`, `rag-chat-block.html.twig`.

## Solution docs
- [config/settings.md](config/settings.md) — settings, indexing, permissions, providers, keys, DB tables.
- [api/rag-pipeline.md](api/rag-pipeline.md) — index/retrieve/generate flow, chat API, services, methods.
