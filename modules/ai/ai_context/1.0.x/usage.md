<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Context Control Center turns the background knowledge an AI agent needs — brand voice, style guides, editorial policies, regulatory language — into managed Drupal content, then decides which of those context items reaches which agent prompt. Editors author `ai_context_item` entities (moderated, revisioned, translatable, Markdown); scope plugins categorise them by dimension (global, use case, language, tag, site section, taxonomy, entity type/item); and the module both pushes the selected items into each agent's system prompt and exposes function-call tools so agents can pull context on demand, all within configurable item and token budgets.

---

Context lives as the `ai_context_item` content entity, so it gets Drupal's full editorial workflow: drafts, content moderation, revisions and diffs, scheduling, translation, and a Markdown editor. Which items apply is governed by a plugin-based **scope** system (attribute `#[AiContextScope]`, manager `plugin.manager.ai_context_scope`, base `AiContextScopeBase`) whose shipped dimensions are global, use case, language, tag, site section, taxonomy, entity type and entity item; sites can add their own scope, and alter hooks (`hook_ai_context_scope_info_alter`, `hook_ai_context_scope_values_alter`) reshape the set. Agents opt into scope values through per-agent config in `ai_context.agents` (scope subscriptions plus always-include/never-include overrides, per-agent token and item caps, loop-aware injection, and an injection on/off switch). At runtime `AiContextSystemPromptSubscriber` listens to the `ai_agents` `BuildSystemPromptEvent`, asks `ai_context.request_factory`/`ai_context.selector` for the relevant items, renders them to a token-limited block via `AiContextRenderer`, and appends that block (prefixed by the configurable `context_prefix`) to the system prompt — only ever using published items. Alternatively, the `context_tools` function-call plugins (`list`, `load`, `get_relevant`) let an agent discover and load context itself. Two selection events (`ai_context.selection.items_selected`, `ai_context.selection.text_rendered`) are alterable, a second entity (`ai_context_usage`) records which context and tools reached each agent run for reporting through a View, and permissions cleanly separate trusted authors from low-trust AI consumers (`access published ai context`). It depends on `ai`, `ai_agents`, and core content_moderation/taxonomy/workflows/views/text/options.

---

- Give AI agents consistent background about the organisation without hard-coding it in prompts.
- Store brand voice and tone-of-voice guidance as reusable, editable context items.
- Keep regulatory language (HIPAA, FERPA, GDPR) available to content-generation agents.
- Scope context to a specific content type, entity, or Canvas page.
- Provide different context per language for multilingual agents.
- Attach context to a particular site section by path pattern (e.g. `/blog/*`).
- Tag context items and have agents subscribe to selected tags.
- Review and approve context changes through content moderation before they reach prompts.
- Schedule context to publish or unpublish at a set time via Scheduler.
- Control which agents receive which context through scope subscriptions.
- Force-include or exclude specific items per agent with always/never lists.
- Cap context per agent with item and token budgets to control cost.
- Let an agent pull context on demand with the `context_tools` function-call tools.
- Organise context into parent/child subcontext, with the LLM choosing conditional children.
- Track which context items and tools were used in each agent run.
- Report on context usage with the bundled View.
- Author context in Markdown with safe, sanitized rendering.
- Diff two revisions of a context item to see what changed.
- Add a custom scope dimension (e.g. department) via a scope plugin.
- Pull rendered context into your own module with `ai_context.request_factory`.
- Alter selected items or rendered text with the selection events.
- Turn off automatic injection for an agent while keeping pull-based tools.
- Debug why an agent produced a particular answer via debug logging and usage records.
- Keep prompt context out of module code and in editors' hands.
- Reuse one context item across many agents through the global scope.
- Audit context usage for compliance over a retained window.
