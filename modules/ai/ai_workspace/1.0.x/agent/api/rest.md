<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Workspace — REST + SSE API

All endpoints live under `/api/ai-workspace` (`ai_workspace.routing.yml`) and return JSON, except
the SSE stream. Threads/messages are addressed by **UUID**. Mutating endpoints require an
`X-CSRF-Token` header (fetch from `/session/token`), validated by `ApiControllerTrait::validateCsrf()`
against `CsrfRequestHeaderAccessCheck::TOKEN_KEY`. Ownership is enforced inside `ThreadManager`
(`administer ai workspace` bypasses ownership).

## Endpoints (controller → method, HTTP)
| Route | Path | HTTP | Controller |
|---|---|---|---|
| `ai_workspace.api.threads.list` | `/threads` | GET | `ThreadApiController::list` |
| `ai_workspace.api.thread.create` | `/thread` | POST | `ThreadApiController::createThread` |
| `ai_workspace.api.thread.get` | `/thread/{thread_id}` | GET | `ThreadApiController::get` |
| `ai_workspace.api.thread.delete` | `/thread/{thread_id}` | DELETE | `ThreadApiController::delete` |
| `ai_workspace.api.thread.generate_title` | `/thread/{thread_id}/generate-title` | POST | `ThreadApiController::generateTitle` |
| `ai_workspace.api.message.send` | `/message` | POST | `MessageApiController::send` |
| `ai_workspace.api.stream` | `/stream/{thread_id}` | GET (SSE) | `StreamApiController::stream` |
| `ai_workspace.api.models` | `/models` | GET | `ModelApiController::list` |
| `ai_workspace.api.tools` | `/tools` | GET | `ToolApiController::list` |

## Chat flow
1. `POST /thread` `{label, model_key}` → creates an `ai_workspace_thread`. `model_key` is
   `provider_id__model_id`; an `assistant__<id>` key resolves via `ModelAdapter::resolveAssistantProviderModel()`
   (requires `ai_assistant_api`, else 422). Invalid/empty key falls back to the default model (503 if none).
2. `POST /message` `{thread_id, content, stream=true}` → `ChatService::saveUserMessage()` persists the
   user turn. With `stream:true` returns **202** `{message, stream_url}`; with `stream:false` calls the
   provider synchronously and returns the assistant `{message}` (502 on `ProviderException`).
3. `GET /stream/{thread_id}` (EventSource) → `StreamApiController::stream()`. Resolves the thread
   (404/403 as an SSE error event), requires a pending user message (`ThreadManager::hasPendingUserMessage()`,
   else 422), saves the session and releases the PHP session lock, then iterates the AI iterator emitting
   `data: {"type":"delta","content":...}` lines; on completion persists the assistant message and emits
   `{"type":"done","message_id","usage","needs_title"}`; errors emit `{"type":"error","message"}`. Assistant
   threads route through `ChatService::streamAssistant()` and the `ai_assistant_api.runner`.
4. `POST /thread/{id}/generate-title` → idempotent; if the label is still `ThreadManager::DEFAULT_LABEL`
   (`"New conversation"`) calls `ChatService::generateTitle()` (best-effort, <=80 chars) and saves it.

## Response shapes
- Thread: `{id(uuid), label, provider_id, model_id, model_key, assistant_id, active, created, changed}`;
  `GET /thread/{id}` adds `messages: [...]`.
- Message: `{id(uuid), role, content, metadata, created}`.
- `GET /models`: `{models:[{id,provider_id,model_id,label,default}], assistants:[...], default}` — models come
  from `ai.provider`->`getSimpleProviderModelOptions('chat')` filtered by `allowed_providers`.
- `GET /tools`: `{tools:[...]}` OpenAI-style function schemas from `ToolExecutor::getToolSchemas()` (empty — no tools ship).

## Auth model
Every `/api/ai-workspace/*` route requires only `_user_is_logged_in: 'TRUE'`. The SPA page route
`ai_workspace.page` is separately gated by `_permission: 'use ai workspace'`. Per-thread/message data
is isolated to its owner by `ThreadManager::getThread()` and the entity access handlers.
