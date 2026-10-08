<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI RAG Search Chat (ai_rag_search_chat) — agent index

**AI search (`/ai-search`) + chat (`/ai-search/chat`) answering from site content via Search API RAG retrieval and a Drupal AI provider.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Requires:** ai:ai, search_api:search_api, drupal:key
- **Flow:** `DirectRagRetriever` (Search API chunks) -> `ChatOrchestrator` (context + system prompt) -> `AiChatClient` (`ai.provider`). Sessions/messages in `ai_rag_search_chat_sessions` + `ai_rag_search_chat_messages` (`ChatStorageService`). SDC components rendered to HTML in JSON.
- **Routes:** settings (`administer ai rag search chat`); `/ai-search`, `/ai-search/chat` and `/api/chat/*` (+ `/api/search/sources/render`) gated by `access ai rag search chat`. POST endpoints are `_csrf_request_header_token`.
- **Permissions:** `access ai rag search chat`, `administer ai rag search chat` (restrict).
- **Rate limiting:** `RateLimiterService` (Flood), on by default (30/h auth, 10/h anon; keyed uid/anon-cookie/IP).

**Security:** Session reads are owner-scoped (uid, or `user_id=0 AND anonymous_owner=<cookie>`), so no IDOR by guessing sessionId; anonymous cookie uses `Crypt::randomBytesBase64()` (CSPRNG); SQL uses placeholders + `escapeLike`; metadata is JSON (no `unserialize`); no disabled TLS, no keys logged; assistant Markdown is `Xss::filterAdmin`-filtered.

See [configure/settings.md](configure/settings.md) and [api/endpoints.md](api/endpoints.md).
