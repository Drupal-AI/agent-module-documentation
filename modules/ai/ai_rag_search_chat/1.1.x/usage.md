<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI RAG Search Chat adds an AI search page (`/ai-search`) and a conversational chat (`/ai-search/chat`) that answer questions from the site's own indexed content.

---

`DirectRagRetriever` runs chunk-level queries against the configured Search API indices (`search_api_ai_get_chunks_result`), packs the top-scoring chunks into a configurable token budget (`context_token_budget`, default 4000), and can add a supplementary keyword/entity-reference search; `ChatOrchestrator` injects that context into a system prompt and calls the LLM through `AiChatClient` (the Drupal `ai` provider system, with separate main / fast / title models). Sessions and messages persist in two custom tables (`ai_rag_search_chat_sessions`, `ai_rag_search_chat_messages`) via `ChatStorageService`; the UI is built from Single-Directory Components server-rendered to HTML inside JSON responses. Anonymous users are identified by a CSPRNG `STYXKEY_`-prefixed cookie (`AnonymousOwnerService`) rather than a Drupal session, and `RateLimiterService` (Drupal Flood) throttles messages and session creation.

Configuration at `/admin/config/ai/ai-rag-search-chat` (`administer ai rag search chat`) covers the Search API indices, LLM provider/model ids, system prompt/term map, retrieval tuning (`top_k`, `min_score`, `context_token_budget`), history retention, an AI disclosure line, a message-length cap, and rate limits (default on: 30/hour authenticated, 10/hour anonymous for both messages and sessions). The two permissions are `access ai rag search chat` (use the search/chat + `/api/chat/*` endpoints) and `administer ai rag search chat` (restrict access). POST endpoints are CSRF-protected for authenticated users; session reads and mutations are owner-scoped so one user cannot read or delete another's history by guessing a session id; retrieved entities are filtered by `view` access before their content is used, and source rendering re-checks `view` access; and no API keys are stored here (auth is delegated to `drupal/ai` + `key`). Grant `access ai rag search chat` to the roles that should use the feature and keep rate limiting enabled, especially if you extend access to anonymous visitors.

---
- Add an AI search page over your site content at `/ai-search`.
- Offer a conversational chat grounded in site content at `/ai-search/chat`.
- Retrieve answers from configured Search API indices (RAG).
- Tune retrieval with `top_k`, `min_score` and a context token budget.
- Pack the highest-scoring chunks into a bounded prompt regardless of document length.
- Add a supplementary keyword / entity-reference search alongside vector retrieval.
- Choose the LLM provider and model (plus fast + title models).
- Set a custom system prompt and terminology map.
- Persist chat sessions and messages in dedicated DB tables.
- Support anonymous chat via a secure cookie owner id.
- Rate-limit messages and session creation via Flood (on by default).
- Set separate authenticated/anonymous message and session limits.
- Prune old sessions (anonymous 2 days, authenticated 30 days) via cron.
- Render the UI from Single-Directory Components.
- Return deduplicated, paginated source citations with answers.
- Show a configurable AI disclosure line under the search/chat UI.
- Cap the maximum chat message length (`chat.max_message_length`).
- Restrict configuration to `administer ai rag search chat`.
- Grant end-user access via `access ai rag search chat`.
- Filter retrieval by the user's current language.
- Show a configurable empty-response fallback message.
- Search a user's own past sessions by title or message content.
- CSRF-protect the POST chat endpoints for authenticated users.
- Delegate provider credentials to drupal/ai + Key (no keys stored here).
- Pair with a VDB provider module (Milvus, Pinecone, Qdrant, etc.) for embeddings storage.
