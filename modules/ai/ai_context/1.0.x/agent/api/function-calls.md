<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Function-call tools (context_tools)

The module registers `ai` module function-call plugins (`#[FunctionCall]`) so an agent can **pull**
context on demand, as an alternative/complement to push injection. They belong to the function
group **`context_tools`** (`Plugin\AiFunctionGroup\ContextTools`). Add the group (or individual
tools) to an agent's toolset in `ai_agents` to enable them.

All three extend `Plugin\AiFunctionCall\AiContextFunctionCallBase`, which gates execution on
`hasContextPermission()` (`access published ai context` OR `view ai context items` OR
`administer ai context`) and only ever returns **published** items.

## Tools

| Plugin id / `function_name` | Purpose | Key arguments |
|---|---|---|
| `ai_context:list_ai_context_items` / `ai_context_list_ai_context_items` | Lightweight discovery — returns id, label, purpose (no content). | `scope_subscriptions`, `agent_id`, `entity_type`, `entity_id` |
| `ai_context:load_ai_context_item_by_id` / `ai_context_load_ai_context_item_by_id` | Loads + renders full content for chosen ids. | `context_item_ids` (required), `task`, `max_tokens`, `include_subcontext` |
| `ai_context:get_relevant_ai_context_items` / `ai_context_get_relevant_ai_context_items` | One-shot: selects + renders relevant context for a task. | `task` (required), `scope_subscriptions`, `always_include`, `never_include`, `agent_id`, `selection_mode` (`minimal`/`match_all`, default `minimal`), `entity_type`, `entity_id`, `max_tokens` |

Typical agent flow: `list` → decide → `load`; or a single `get_relevant`. `list`/`load` route
through `Service\AiContextScopeResolver`/`AiContextRenderer`; `get_relevant` builds a request via
`AiContextRequestFactory::fromParameters()` and runs the selector.

Notes:
- `scope_subscriptions` is a map like `{"language":["en"],"tag":["5","7"]}`.
- When `agent_id` is given, the agent's saved subscriptions/overrides are merged; explicit
  same-named scope keys from the call override the agent's values.
- `get_relevant`'s `selection_mode` defaults to `minimal` (safe: global + context-auto + overrides
  only); `match_all` considers the whole catalogue and is intended for preview/tooling.
- `entity_id` must be numeric; non-numeric input is rejected before selection.

These tools are the pull path and work even when the agent's `allow_context_injection` is off —
see [../configure/agents.md](../configure/agents.md).
