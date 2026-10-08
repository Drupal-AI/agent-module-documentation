<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AnythingLLM Provider adds an AI-module provider (`anythingllm`) that routes chat and embeddings to an AnythingLLM instance, and a Search API backend that indexes and searches content through AnythingLLM's built-in vector database.

---

AnythingLLM Provider is a provider plugin for the Drupal AI (`ai`) module targeting AnythingLLM — a self-hostable "all-in-one" AI application with its own LLMs, embedders, and vector database. It implements three operation types: `chat`, `embeddings`, and a module-defined `ai_search_api`. Chat can call AnythingLLM's native workspace chat/query endpoints (which support image and file attachments) or its OpenAI-compatibility endpoint (which supports conversation history); the endpoint is chosen per model in the AI module's advanced model settings. The module also registers a Search API backend, `AI Search with AnythingLLM` (`search_api_ai_anythingllm`), that uploads indexed entities and their file attachments into an AnythingLLM workspace, embeds them, and answers Search API queries via workspace vector search — a RAG search over your own content with entity-level `view` access checks applied to every result. Metadata filters from the Search API query are evaluated in Drupal after results return. Connection settings (API URL and a Key-module API key) live at `/admin/config/ai/providers/anythingllm` (permission: `administer ai providers`); a small database table `ai_provider_anythingllm` tracks which uploaded documents belong to each indexed item.

- Route Drupal AI chat operations to a self-hosted AnythingLLM workspace.
- Keep prompts and documents on your own infrastructure (data sovereignty / RAG).
- Choose AnythingLLM native chat, native query, or OpenAI-compatibility mode per model.
- Attach images and files to chat messages via the native endpoint.
- Generate embeddings through AnythingLLM's OpenAI-compatible embeddings endpoint.
- Add an `AI Search with AnythingLLM` Search API server and index.
- Index node/entity content into an AnythingLLM workspace as embedded documents.
- Index file/attachment fields (uploaded to AnythingLLM as documents).
- Run vector/semantic search over indexed content from Search API views.
- Apply per-entity `view` access checks to every search result.
- Filter search results by indexed metadata fields (evaluated in Drupal).
- Tune vector search with `topN` and `scoreThreshold` per workspace model.
- Use a custom search prompt with a `{search_words}` placeholder.
- Store the AnythingLLM API key as a Key entity instead of plain config.
- Point the provider at any reachable AnythingLLM host/port (admin-configured).
- Make AnythingLLM workspaces selectable as "models" anywhere the AI module runs.
- Back AI CKEditor, AI Translate, or third-party AI submodules with AnythingLLM chat.
- Convert indexed HTML to Markdown before embedding (better LLM ingestion).
- Alter indexed meta/content with `hook_search_api_anythingllm_data_alter()`.
- Use Search API without a separate vector-database module.
- Serve conversational site assistants grounded in your indexed content.
