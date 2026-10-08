<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Workspace (ai_workspace) — agent index

Per-user, persistent ChatGPT-style chat workspace inside Drupal. A React (assistant-ui)
SPA on one route (default `/ai_workspace`) talks to a JSON + SSE REST API under
`/api/ai-workspace`, backed by the Drupal AI module for provider/model/streaming.
Version 1.0.0-rc4. Core `^10.4 || ^11`. **Not** security-advisory covered; upstream
labels it under active development.

## Dependencies
- Core `user`, `system`; `drupal/ai` `^1.2` (provider plugin manager, ChatInput/ChatOutput, streaming iterator).
- Optional/suggested `ai_assistant_api` — enables `assistant__<id>` threads run through `ai_assistant_api.runner` (checked at runtime via `module_handler`, resolved through `\Drupal::service()`).

## What it provides
- **Content entities** (`src/Entity/`): `ai_workspace_thread` (owned, `EntityOwnerTrait`, per-user access handler) and child `ai_workspace_message` (entity_reference to thread; role/content/metadata/tool_invocation/tool_result). Entity tables are auto-managed; `hook_requirements` warns if no chat provider is configured.
- **Routes** (`ai_workspace.routing.yml`): SPA page `ai_workspace.page`, admin settings `ai_workspace.settings`, and REST endpoints — threads list/create/get/delete/generate-title, message send, SSE stream, models, tools. See `agent/api/rest.md`.
- **Services** (`ai_workspace.services.yml`): `ThreadManager` (all thread/message CRUD + ownership), `ChatService` (orchestration), `ModelAdapter` (model/assistant resolution), `CapabilityResolver`, `ToolExecutor`, `AiProviderAdapterV1` (AI-module 1.2.x bridge), `RouteSubscriber` (makes the page path configurable).
- **Config** `ai_workspace.settings` (schema provided) — default model, provider allow-list, system prompt, appearance, thread cap, tools/logging toggles. See `agent/config/settings.md`.
- **Permissions** (`ai_workspace.permissions.yml`): `use ai workspace`, `administer ai workspace` (both enforced); `manage ai workspace models`, `manage ai workspace tools` (declared but unused in code).
- **Plugin type** `ai_workspace_tool` (annotation `@AiWorkspaceTool`, manager `plugin.manager.ai_workspace_tool`) — tool-calling scaffold; **no active tools ship**. See `agent/plugins/tool.md`.

## Solution docs
- `agent/config/settings.md` — install/enable, config keys + schema, settings form, configurable path.
- `agent/api/rest.md` — REST/SSE endpoints, request/response shapes, CSRF, auth model.
- `agent/entities/thread-message.md` — the two entity types, fields, ownership/access handlers, ThreadManager.
- `agent/plugins/tool.md` — the AiWorkspaceTool plugin type and ToolExecutor.
