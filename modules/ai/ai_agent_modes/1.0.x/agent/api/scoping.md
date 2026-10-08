<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a selection is stored and applied at run time

## Services (`ai_agent_modes.services.yml`)

- **`ai_agent_modes.manager`** — `ModeManager` (`ModeManagerInterface`). Resolves modes and applies
  scope. Injects `entity_type.manager`, `plugin.manager.ai_agents`,
  `plugin.manager.ai.function_calls`, `config.factory`, the logger.
- **`ai_agent_modes.selection_store`** — `SelectionStore` (`SelectionStoreInterface`). Per-user
  private tempstore (`@tempstore.private`, `@current_user`), collection `ai_agent_modes`.
- **`ai_agent_modes.assistant_context`** — `ActiveAssistantContext`. Request-scoped in-memory map of
  assistant ID keyed by agent thread/runner ID (nothing persisted).
- **`ai_agent_modes.agent_scope_subscriber`** / **`.assistant_scope_subscriber`** — the two
  `event_subscriber`s. The assistant one takes `@?ai_assistant_api.runner` (NULL when absent).
- **`Drupal\ai_agent_modes\Hook\ChatFormHooks`** — hook class wired with the soft runner.

## ModeManager: the core methods

- `listSubAgents(parentId)` — reads the parent agent's enabled `tools`, keeps only sub-agent tools
  (function-call group `agent_tools`, or the ID prefix `ai_agents::ai_agent::`), and returns them
  keyed by child agent ID. Dynamic, so it always reflects current config.
- `listModes(parentId?, surface?, assistantId?)` — enabled modes matching the agent (generic modes
  always included), surface and assistant, sorted by weight then label.
- `resolve(parentId, selectedSubAgents[], modeId?)` → `ScopePayload|null`. A saved `modeId` wins;
  its `sub_agents` are intersected with the agent's live sub-agents (`intersectAvailable`). Returns
  NULL for a free-form/empty selection. An ad-hoc pick (no saved mode) is always `guide` — only a
  saved mode an admin wrote can be `restrict`. A generic (agentless) `restrict` mode is downgraded
  to `guide` with a warning.
- `buildScopeDirective(payload)` / `applyScopeToPrompt(payload, prompt)` / `applyScope(payload,
  ChatInput)` — build the directive (opened by `DIRECTIVE_MARKER = 'MODE (AI Agent Modes):'`) and
  prepend it to the system prompt.
- `restrictedTools(payload, entityTools)` — returns a complete replacement `tools` map disabling the
  sub-agent tools the mode does not name, **or `[]`** when: not a `restrict` scope; the
  `tool_scope_enforcement` switch is off (logged); no available sub-agent; nothing to withhold; or
  withholding would disable every tool. Never re-enables an already-disabled tool and never touches
  the orchestrator's own (non-sub-agent) tools.
- `dropdownEnabled()` (unset = true), `hasAnyMode()` (cheap existence gate; `accessCheck(FALSE)`
  count only).

`ScopePayload` (`src/ScopePayload.php`) is an immutable value object: `parentAgent`, `subAgents[]`,
`systemPromptAddition`, `label`, `scopeStrength`; `isRestrictive()` = has a sub-agent or a directive.

## Event flow — `AgentScopeSubscriber` (priority 100)

On the `ai_agents` pipeline, in fire order:

1. **`AgentStartedExecutionEvent` → `onAgentStarted()`** — the only point where the agent's tool set
   can still change. Skips nested runs (`getCallerId() !== NULL`), returns early when `hasAnyMode()`
   is false or the agent is not an `AiAgentEntityWrapper`. Always calls `resetFunctions()` first (to
   undo a prior turn's override), then for a resolved `restrict` payload calls `restrictedTools()`
   and applies it via `overrideFunctions(['tools' => $tools])` — so withheld tools are never
   instantiated. Only the `tools` key is overridden; limits/settings still fall back to the agent.
2. **`BuildSystemPromptEvent` → `onBuildSystemPrompt()`** — the designed seam; prepends the directive
   (guarded by the `DIRECTIVE_MARKER` so it is never added twice).
3. **`AgentRequestEvent` → `onAgentRequest()`** — a fallback for a dispatcher that skips the prompt
   event; same marker guard.

`resolveFor()` reads the selection, and when the run's assistant is known and the stored mode is not
offered for that assistant, refuses it (logged) — otherwise applies.

## `AssistantScopeSubscriber` (soft, priority 100)

Does nothing when AI Assistant API is absent, and references it only by literal event name (so the
container compiles without it). `ai_assistant.pass_context_to_agent` → `note()`s the assistant for
the run's runner ID. `ai_assistant.change_assistant_message` → for an assistant with **no** agent,
re-validates the stored `assistant:<id>` selection against `listModes('', SURFACE_ASSISTANT, id)`
and prepends the directive to the assistant's own system prompt.

## Controller routes

`SelectionController` (`src/Controller/SelectionController.php`):

- **`ai_agent_modes.set_selection`** — `POST /ai-agent-modes/selection`, `_user_is_logged_in: TRUE`
  + `_csrf_request_header_token: TRUE`. Body `{"agent","value","conversation?"}`; `value` is `''`
  (clear), `mode:<id>`, or `agent:<sub_agent_id>`. Stores via `SelectionStore` (per user).
- **`ai_agent_modes.options`** — `GET /ai-agent-modes/options/{agent}`, `_user_is_logged_in: TRUE`.
  Returns the mode options (label + `mode:<id>`), the current value and the Canvas placement, for
  client-rendered dropdowns (e.g. the Canvas AI shadow-DOM panel). Raw sub-agents are deliberately
  not offered here.

## Render element and block

- **`ai_agent_mode_select`** (`src/Element/AiAgentModeSelect.php`, extends core `Select`). Props
  `#parent_agent` (required), `#surface`, `#assistant`. Value: `''` | `mode:<id>` | `agent:<id>`.
  `processAgentModeOptions()` fills the options from live sub-agents and matching modes.
- **`ai_agent_mode_selector`** block (`AiAgentModeSelectorBlock`, category *AI*). Config
  `ai_assistant` (agent read from it, wins), `parent_agent`, `surface`. Renders
  `AiAgentModeSelectorForm` (`getFormId` `ai_agent_modes_selector`), whose `submitForm()` writes the
  selection through the store. The block returns empty when `dropdownEnabled()` is false.

## Hooks (`src/Hook/*`, OOP `#[Hook]`)

`help`; `form_ai_assistant_form_alter` (per-assistant overrides); `form_ai_foundation_chat_alter`
(adds the selector to the foundation chat form); `library_info_alter` +
`block_view_ai_deepchat_block_alter` (Canvas & Chatbot dropdown injection);
`page_attachments` / `js_settings_alter` / `library_info_alter` + `block_view_...` (speech).
The module also invokes `hook_ai_agent_modes_speech_alter()` so other modules can adjust speech
options (e.g. add an Azure key). No `.module` file; no Drush commands.

## Security note (operational)

Tool withholding removes sub-agent tools from what the model is *offered* for a run; it is a
context-shrinking / steering feature, not an authorization boundary. The underlying `ai_agents`
tools continue to enforce their own access when actually invoked, and admin CRUD is gated by the
restricted `administer ai agent modes` permission while the selection endpoints require a logged-in
user (POST additionally requires a CSRF header token).
