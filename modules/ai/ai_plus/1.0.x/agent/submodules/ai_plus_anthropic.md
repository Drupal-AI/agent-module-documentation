<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Plus Anthropic (ai_plus_anthropic) — submodule

**Claude/Anthropic-specific context injection for AI Plus.** Package `AI`, core `^10.3 || ^11`, lifecycle `experimental`. Version 1.0.2. Depends on `ai_plus`, `ai_agents`, `ai_assistant_api`. No routes, no permissions, no config, no schema — it registers two event subscribers (`ai_plus_anthropic.services.yml`, autowired).

It formats the page/selection context (resolved by the parent's `RouteEntityResolver` / `ElementSelectionResolver`) into the prompt using Anthropic conventions (`<system-reminder>` blocks + a "Selection Scope" protocol). Enable it when the assistant is backed by a Claude/Anthropic model; a different LLM family would ship an equivalent submodule with its own phrasing.

## `CurrentEntityContextSubscriber`

Subscribes to `AiAssistantPassContextToAgentEvent` (`onPassContext`) and `BuildSystemPromptEvent` (`onBuildSystemPrompt`).

- `onPassContext`: resolves the current route to an entity, captures `{entity_type, entity_id, uuid, bundle, label}` and the view mode, and (once) **prepends a `<system-reminder>\nCurrent page: …` block to the last user message** via `AgentUserMessageTrait::injectIntoLastUserMessage()`. A marker check (`alreadyInjected`) prevents double injection.
- `onBuildSystemPrompt`: unconditionally strips the ai_agents "This is the Nth time that this agent has been run." loop-count notice (`stripLoopCountNotice()`, a `preg_replace`) — it is noise for a small model here — then appends a **"## Selection Scope"** instruction block teaching the model that an ACTIVE SELECTION constrains the scope of its edits ("this"/"it" → the selection, not the whole page) plus a "## Context Tags" explainer of the `<system-reminder>` tags. Reads entity/view-mode from its own captured state or falls back to the `current_entity_context` / `current_view_mode` tokens (set by the parent's `TokenPropagationSubscriber`).

## `SelectedElementContextSubscriber`

Subscribes to `AiAssistantPassContextToAgentEvent` (`onPassContext`, priority 10). When the context carries `selected_elements`, it resolves the current entity, calls the parent's `ElementSelectionResolver::resolve()` to turn selections into `{description, guidance}` items, and **prepends a numbered `<system-reminder>\nThe user has selected the following element(s)…` ACTIVE SELECTION block** to the last user message (once, via the marker guard). This is the scope constraint the Selection Scope protocol above refers to.

All text handled here is the editor's own chat/system prompt content flowing to the LLM; nothing is rendered back into the admin UI by this submodule.
