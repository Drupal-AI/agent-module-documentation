<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Modes (ai_agent_modes) — agent index

A **"Mode" selector** for AI chats that **scopes an AI agent to a curated subset of its
sub-agents**. A mode prepends a scoped directive to the orchestrator's system prompt so it routes
work to the named sub-agents; a "restrict" mode also withholds the unnamed sub-agent tools from the
request. Package `AI`. Core `^11`. License GPL-2.0-or-later. Version 1.0.0-alpha4 (dir `1.0.x`).

- Hard deps: **`ai`** and **`ai_agents` (>=1.3)**. Optional: `ai_assistant_api`, `ai_chatbot`
  (DeepChat), `canvas_ai` (all soft — `@?` service refs / literal event names).
- Configure link: **`entity.ai_agent_mode.collection`** (Configuration → AI → AI Agent Modes).

## Solution docs

- **The `ai_agent_mode` config entity, its fields, CRUD forms, list builder and permission** →
  [config/modes.md](config/modes.md)
- **Site settings (`ai_agent_modes.settings`): dropdown placement, tool-scope enforcement, speech,
  per-assistant overrides** → [config/settings.md](config/settings.md)
- **How a selection is stored and applied at run time: services, event subscribers, controller
  routes, the render element and the selector block** → [api/scoping.md](api/scoping.md)

## What it provides (from source)

- **Config entity type `ai_agent_mode`** (`src/Entity/AiAgentMode.php`) — a mode = parent `agent`,
  `sub_agents[]`, `system_prompt_addition`, `scope_strength` (`guide`|`restrict`), `assistants[]`,
  `surfaces[]`, `weight`, `status`. Schema `ai_agent_modes.ai_agent_mode.*`.
- **Settings config object `ai_agent_modes.settings`** (form `SettingsForm`, route
  `ai_agent_modes.settings`): `show_dropdown`, `canvas_position`, `chatbot_position`,
  `tool_scope_enforcement`, `speech_to_text{}`, `text_to_speech{}`.
- **Services**: `ai_agent_modes.manager` (`ModeManager` / `ModeManagerInterface`) resolves modes
  to a `ScopePayload` and applies scope; `ai_agent_modes.selection_store` (`SelectionStore`,
  per-user private tempstore); `ai_agent_modes.assistant_context` (`ActiveAssistantContext`,
  request-scoped).
- **Event subscribers**: `AgentScopeSubscriber` (ai_agents `started_execution` →
  withhold tools, `pre_system_prompt` / `request` → prepend directive);
  `AssistantScopeSubscriber` (ai_assistant `pass_context_to_agent` /
  `change_assistant_message`, soft integration).
- **Routes** (`ai_agent_modes.routing.yml`): the 5 entity/list/settings routes gated by
  `administer ai agent modes` (restricted); `ai_agent_modes.set_selection` (POST, login +
  `_csrf_request_header_token`); `ai_agent_modes.options/{agent}` (GET, login).
- **Permission**: `administer ai agent modes` (`restrict access: true`).
- **Render element** `ai_agent_mode_select` (`src/Element/AiAgentModeSelect.php`, extends core
  `Select`). **Block** `ai_agent_mode_selector` (`AiAgentModeSelectorBlock`, category *AI*).
- **Hook classes** (`src/Hook/*`): `help`, `form_ai_assistant_form_alter` (per-assistant
  third-party settings), `form_ai_foundation_chat_alter`, `library_info_alter` /
  `block_view_ai_deepchat_block_alter` (Canvas/Chatbot), `page_attachments` / `js_settings_alter`
  (speech). Also invokes the alter hook `hook_ai_agent_modes_speech_alter()`.
- No `.module` file (all hooks are OOP `#[Hook]` classes); no Drush.

## Mechanism in one paragraph

A user's choice (`''`, `mode:<id>`, or `agent:<sub_agent_id>`) is POSTed to
`SelectionController::set` and stored per user in the `ai_agent_modes` private-tempstore collection.
On an ai_agents run, `AgentScopeSubscriber` reads the selection, asks `ModeManager::resolve()` for a
`ScopePayload`, prepends the directive on `BuildSystemPromptEvent`, and — only for a `restrict` mode
with a parent agent and available sub-agents, and only while `tool_scope_enforcement` is on — calls
`ModeManager::restrictedTools()` on `AgentStartedExecutionEvent` to build a `functions_override`
that disables the unnamed sub-agent tools before they are instantiated. Withholding narrows what the
model is offered but is not an authorization layer: the underlying `ai_agents` tools still enforce
their own access when they run.
