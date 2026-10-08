<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI RAG Search Chat (ai_rag_search_chat) — agent index

**AI search (`/ai-search`) + chat (`/ai-search/chat`) answering from site content via Search API RAG retrieval and a Drupal AI provider.**

- **Version:** 1.1.x (installed 1.1.1)
- **Core:** ^10.1 || ^11 || ^12
- **Requires:** ai:ai, search_api:search_api, drupal:key
- **Flow:** `DirectRagRetriever` (Search API chunk-level results, `search_api_ai_get_chunks_result`) -> `ChatOrchestrator` (packs chunks into a token budget, injects context + system prompt) -> `AiChatClient` (`ai.provider`, separate main/fast/title models). Sessions/messages in `ai_rag_search_chat_sessions` + `ai_rag_search_chat_messages` (`ChatStorageService`). SDC components rendered to HTML in JSON (`ComponentRenderer`).
- **Routes:** settings (`administer ai rag search chat`); `/ai-search`, `/ai-search/chat` and `/api/chat/*` (+ `/api/search/sources/render`) gated by `access ai rag search chat`. POST endpoints carry `_csrf_request_header_token: 'TRUE'`.
- **Permissions:** `access ai rag search chat`, `administer ai rag search chat` (restrict access).
- **Rate limiting:** `RateLimiterService` (Flood), on by default (30/h auth, 10/h anon for both messages and session creation; keyed uid / anon-cookie / IP). Events registered only after a successful operation, so a failed LLM call does not spend quota.

**Security:** Session reads/writes are owner-scoped (`user_id=<uid>`, or `user_id=0 AND anonymous_owner=<cookie>`), so no IDOR by guessing sessionId. Retrieved entities are access-filtered before use: `DirectRagRetriever::filterViewableEntities()` drops any loaded entity failing `access('view')` before its label/URL/chunk reaches the prompt or the client, and `SourceEntityRenderer::renderSources()` re-checks `access('view')` before rendering a client-supplied `{entity_type_id, nid}`. Assistant Markdown is converted server-side then `Xss::filterAdmin`-filtered (`allow_unsafe_links=FALSE`); the fallback source link href is passed through `UrlHelper::stripDangerousProtocols()`. Anonymous cookie id uses `Crypt::randomBytesBase64()` (CSPRNG); SQL uses placeholders + `escapeLike`; message metadata is JSON (no `unserialize`). No API keys are stored here — provider auth is delegated to `drupal/ai` + Key. LLM provider/model are selected from the AI module's registered providers (no free-form endpoint URL).

**Changed vs 1.0.x:** core bumped to `^10.1 || ^11 || ^12`; `/api/search/sources/render` and RAG retrieval now enforce entity `view` access (the 1.0.x source-render gap is closed); added `chat.max_message_length` (default 4000) and `ui.ai_disclosure` settings (seeded by `update_10004`); OOP hooks via `AiRagSearchChatHooks` (`hook_cron` prunes old sessions); `DirectRagRetriever::retrieve()` simplified to `(string $query, int $topK = 5)` with tuning read from config; supplementary search reworked to entity-reference reverse lookup using access-checked entity queries.

See [configure/settings.md](configure/settings.md) and [api/endpoints.md](api/endpoints.md).
