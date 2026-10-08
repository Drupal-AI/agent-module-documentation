<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON API endpoints

All under permission `access ai rag search chat`, `no_cache: TRUE`. POST endpoints require the CSRF header (`_csrf_request_header_token`) for authenticated users; anonymous users (no session) bypass CSRF by design.

| Method | Path | Controller | Purpose |
|---|---|---|---|
| POST | `/api/chat/message` | `ChatApiController::sendMessage` | Send a chat message; runs RAG + LLM. Message capped at 4000 chars. |
| POST | `/api/chat/session/create` | `createSession` | Create a chat session (UUID id). |
| GET | `/api/chat/sessions` | `getSessions` | List the caller's own sessions. |
| POST | `/api/chat/session/delete` | `deleteSession` | Delete an owned session. |
| GET | `/api/chat/session/{sessionId}/history` | `getHistory` | Messages of an owned session. |
| GET | `/api/chat/session/{sessionId}` | `getSession` | An owned session. |
| GET | `/api/chat/sessions/search` | `searchSessions` | Search the caller's own sessions. |
| POST | `/api/search/sources/render` | `renderSources` | Render source entities to HTML. |

## Ownership / IDOR
Reads are owner-scoped in `ChatStorageService::applyOwnershipConditions()`: authenticated -> `user_id = <uid>`; anonymous -> `user_id = 0 AND anonymous_owner = <STYXKEY_ cookie>`. Guessing another user's `sessionId` returns 404 — no cross-user history disclosure.
