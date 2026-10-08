<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON API endpoints

All under permission `access ai rag search chat`, `no_cache: TRUE`. POST endpoints carry `_csrf_request_header_token: 'TRUE'`, so Drupal validates the `X-CSRF-Token` header for authenticated (session) users; anonymous users (no session) bypass CSRF by design.

| Method | Path | Controller | Purpose |
|---|---|---|---|
| POST | `/api/chat/message` | `ChatApiController::sendMessage` | Send a chat message; runs RAG + LLM. Message trimmed, non-empty, capped at `chat.max_message_length` (default 4000 chars). Rate-limited. |
| POST | `/api/chat/session/create` | `createSession` | Create a chat session (UUID id). Rate-limited. |
| GET | `/api/chat/sessions` | `getSessions` | List the caller's own sessions (limit/offset). |
| POST | `/api/chat/session/delete` | `deleteSession` | Delete an owned session (ownership verified; 403 otherwise). |
| GET | `/api/chat/session/{sessionId}/history` | `getHistory` | Messages of an owned session (404 if not owned). |
| GET | `/api/chat/session/{sessionId}` | `getSession` | An owned session (ensures a title first). |
| GET | `/api/chat/sessions/search` | `searchSessions` | Search the caller's own sessions by title/content. |
| POST | `/api/search/sources/render` | `renderSources` | Render source entities to HTML (capped at 20/request). |

## Ownership / IDOR
Reads and mutations are owner-scoped in `ChatStorageService::applyOwnershipConditions()`: authenticated -> `user_id = <uid>`; anonymous -> `user_id = 0 AND anonymous_owner = <STYXKEY_ cookie>` (a missing cookie forces a non-matching sentinel so nothing matches). Guessing another user's `sessionId` returns 404 for reads and 403 for delete — no cross-user history disclosure. `sendMessage` and `getHistory` verify the session with `getSession()` before doing any work.

## Source rendering access control
`renderSources` reads a `sources` array from the POST body; `SourceEntityRenderer::resolveEntityReference()` takes the caller-supplied `entity_type_id` + `nid` (falling back to a node id parsed from the URL). Before rendering, `renderSources()` bulk-loads each entity and skips any that fails `$entity->access('view')`, so only entities the current user is allowed to view are rendered. Entities without a canonical route (e.g. files) fall back to a titled link whose href is passed through `UrlHelper::stripDangerousProtocols()`.

## Response shape
Success responses set `success: TRUE` and include both raw JSON data and server-rendered SDC HTML (`rendered`, `rendered_content`, `rendered_sessions`, `rendered_messages`, etc.). Assistant content is converted from Markdown to HTML server-side and `Xss::filterAdmin`-filtered before it is placed in the response. A failed message pipeline returns 503 (`Retry-After: 5`) and does not consume rate-limit budget; rate-limited callers get 429 with a `Retry-After` header.
