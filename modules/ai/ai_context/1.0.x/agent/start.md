<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Control Center (ai_context) — agent index

Manages the reusable **context** injected into Drupal AI agent prompts. Site editors author
`ai_context_item` content entities (moderated, revisioned, translatable, Markdown); **scope
plugins** decide which items apply where; and an event subscriber appends the selected items to
each agent's system prompt (push), while function-call tools let agents pull context on demand.
Also tracks which context reached which agent run. Extends the [`ai`](../../../ai/1.4.x/agent/start.md)
and [`ai_agents`](../../../ai_agents/1.3.x/agent/start.md) ecosystem.

Requires `ai`, `ai_agents`, core `content_moderation`, `options`, `taxonomy`, `text`, `views`,
`workflows`; composer also pulls `league/commonmark`. Newest release on this branch: **1.0.0-beta4**
(no stable release yet). Configure route: **`ai_context.overview`** (menu redirect at
`/admin/config/ai/context`). Defines permissions and config schema; **no drush commands**.

## What you'd do

- **Change global limits, token budget, prompt prefix, usage/subcontext toggles** → [configure/settings.md](configure/settings.md)
- **Control which context each agent gets (scope subscriptions, always/never, injection on/off)** → [configure/agents.md](configure/agents.md)
- **Enable/disable scope dimensions and define site sections** → [configure/scopes.md](configure/scopes.md)
- **Grant editorial vs. AI-consumer access** → [permissions/permissions.md](permissions/permissions.md)
- **Add a custom scope dimension** → [plugins/scope.md](plugins/scope.md)
- **Pull rendered context from your own code/module** → [api/context-api.md](api/context-api.md)
- **Give an agent the context discovery/load tools** → [api/function-calls.md](api/function-calls.md)
- **Alter selected items or rendered text; hook into prompt injection** → [events/events.md](events/events.md)
- **Alter scope definitions or their values** → [hooks/hooks.md](hooks/hooks.md)
- **Understand the two content entities and their fields** → [fields/entities.md](fields/entities.md)

## Key facts

- Content entities: `ai_context_item` (`Entity/AiContextItem.php`, `EditorialContentEntityBase`,
  translatable, revisioned, `admin_permission: administer ai context`) and `ai_context_usage`
  (`Entity/AiContextUsage.php`, usage log).
- Config objects: `ai_context.settings`, `ai_context.agents`, and per-scope
  `ai_context.scope_settings.{global,use_case,language,tag,site_section,taxonomy,entity_type,entity_item}`.
- Plugin type **`AiContextScope`**: attribute `#[AiContextScope]` (`src/Attribute/AiContextScope.php`),
  namespace `Plugin/AiContextScope`, interface `AiContextScopeInterface`, base `AiContextScopeBase`,
  manager service `plugin.manager.ai_context_scope` (`AiContextScopeManager`), alter hook
  `ai_context_scope_info`. Shipped ids: `global`, `use_case`, `language`, `tag`, `site_section`,
  `taxonomy`, `entity_type`, `entity_item`.
- Core services: `ai_context.request_factory` (`AiContextRequestFactoryInterface`, the public entry
  point), `ai_context.selector` (`AiContextSelectorInterface`), `ai_context.scope_resolver`,
  `ai_context.usage_tracker`, `ai_context.renderer`, `ai_context.subcontext_resolver`,
  `ai_context.token_estimator`.
- Function-call group **`context_tools`**: `ai_context:get_relevant_ai_context_items`,
  `ai_context:list_ai_context_items`, `ai_context:load_ai_context_item_by_id`.
- Prompt injection: `AiContextSystemPromptSubscriber` listens to `ai_agents`'
  `BuildSystemPromptEvent`. Own events: `ai_context.selection.items_selected`,
  `ai_context.selection.text_rendered` (both alterable).
- Permissions include `administer ai context`, `view ai context items`,
  `access published ai context`, `create ai context item`, `view ai context usage`
  (most are `restrict access: true`).

Beta-quality: entity schema and plugin/service signatures may still shift between releases.
