<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RAG AI Assistant — configuration, indexing & permissions

## Install / enable
`composer require drupal/ai_rag_assistant`, `drush en ai_rag_assistant -y`. Only core `node` is required (no `drupal/ai`).
`hook_schema()` creates `rag_embeddings` and `rag_chat_history`. A Gemini API key is mandatory even when generation uses
OpenAI/Anthropic, because embeddings are always Gemini (`EmbeddingService`).

## Permissions (`ai_rag_assistant.permissions.yml`)
- `administer rag ai assistant` — settings form + Index Content form. (Not `restrict access: true`.)
- `use rag ai assistant` — chat page `/rag-chat`, chat API `POST /api/rag-chat`, and the `rag_chat_block`. (Not `restrict access: true`.)

## Settings form (`Form\SettingsForm`, route `ai_rag_assistant.settings`, `/admin/config/ai/rag-assistant`)
Editable config object `ai_rag_assistant.settings`. Sections: Index statistics, Embedding (Gemini), AI Generation, RAG, Content, System Prompt.

| Key | Type | Default | Notes |
|---|---|---|---|
| `gemini_api_key` | string | '' | Required (used for embeddings + Gemini generation). Entered via a `password` field; blank on submit keeps the existing key. |
| `embedding_model` | string | `gemini-embedding-001` | Gemini embedding model. |
| `generation_provider` | string | `gemini` | `gemini` \| `openai` \| `anthropic`. |
| `generation_model` | string | `gemini-2.5-flash` | Gemini generation model (fallbacks: 2.0-flash, 2.0-flash-lite). |
| `openai_api_key` / `openai_generation_model` | string | '' / `gpt-4o` | Used when provider = openai. |
| `anthropic_api_key` / `anthropic_generation_model` | string | '' / `claude-sonnet-4-20250514` | Used when provider = anthropic. |
| `chunk_size` | integer | 500 | Words per chunk. |
| `chunk_overlap` | integer | 50 | Overlap words between chunks. |
| `top_k` | integer | 5 | Chunks retrieved per query. |
| `similarity_threshold` | float | 0.3 | Min cosine similarity to keep a chunk. |
| `allow_general_knowledge` | boolean | false | If true, LLM may answer from its own knowledge when no/weak context. |
| `system_prompt` | string | (long default) | System instruction for the assistant. |
| `content_types` | sequence | [] | Bundles to index; empty = all. |

### API keys
Keys are stored in this module's config (`ai_rag_assistant.settings`). The settings form renders a security notice
advising you to override them in `settings.php` (`$config['ai_rag_assistant.settings']['gemini_api_key'] = '…';`) so they
are excluded from config exports, or to use the Key module. `validateForm()` requires the relevant key when OpenAI or
Anthropic is selected.

## Index Content form (`Form\IndexContentForm`, route `ai_rag_assistant.index_content`, `/admin/config/ai/rag-assistant/index`)
- Shows indexed-entity/chunk/chat counts.
- **Index All Content** — `indexAllContent()` queries published nodes (`status = 1`, optional `type IN content_types`),
  batches them 5-at-a-time (`batchProcess()` with a 0.5s delay) through `RagService::indexNode()`.
- **Clear Index** — `VectorStorageService::deleteAllEmbeddings()` (truncate).
- **Chat History Maintenance** — delete chat history all/7/30/90 days (`clearChatHistory()`).

## Auto-indexing & cron (`ai_rag_assistant.module`)
- `hook_entity_insert`/`hook_entity_update` → `_ai_rag_assistant_index_entity()` indexes a node **only if published** and its
  bundle is in `content_types` (or `content_types` empty) and a Gemini key is set. Indexing is synchronous.
- `hook_entity_delete` → `VectorStorageService::deleteEntityEmbeddings('node', id)`.
- `hook_cron` deletes `rag_chat_history` rows older than 30 days.

## Chat surfaces
- Page: `/rag-chat` (`RagChatController::chatPage`) — theme `rag_chat_page`, library `ai_rag_assistant/chat`.
- Block: `rag_chat_block` (`Plugin\Block\RagChatBlock`) — floating widget, `#cache max-age 0`, library `ai_rag_assistant/chat_block`.
Both attach `drupalSettings.aiRagAssistant` = `{sessionId, chatApiUrl: '/api/rag-chat'}` and POST user messages there.
