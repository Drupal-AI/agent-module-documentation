<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Answers — configuration, routes & permissions

## Install / enable

`drush en ai_answers`. Pulls in `ai`, `ai_agents`, `ai_search` (Composer: `drupal/ai ^1.4`,
`drupal/ai_agents ^1.3`, `drupal/ai_search ^1.3@alpha`). To operate you also need: a
vector-database-backed Search API index, an `ai_agent` with the `ai_search:rag_search` tool
configured against that index (a fixed index via tool usage limits), and AI Answers enabled for
that agent. Optional: `ai_logging` (persist answers/feedback as `ai_log`), `langfuse`
(trace correlation).

## Config object `ai_answers.agents`

The module's only config surface. Schema: `config/schema/ai_answers.schema.yml`; install default
`agents: []`. It is a `config_object` holding a `sequence` of `ai_answers.agent_settings` rows,
each keyed internally by an `ai_agent` id. Read/written by `Service/AgentSettingsRegistry`
(`ai_answers.agent_settings_registry`); config-translatable via `ai_answers.config_translation.yml`.

Per-agent row keys (`ai_answers.agent_settings`):

| Key | Type | Meaning / default |
|---|---|---|
| `id` | string | The `ai_agent` entity id (added by the registry on save). |
| `enabled` | boolean | Whether this agent answers. `AnswerService` throws `DomainException` if false. |
| `llm_provider` / `llm_model` | string | Optional provider/model override; empty = site default `chat_with_tools` provider. Applied by `AnswerService::applyProviderOverride()`. |
| `reference_view_mode` | string | View mode used to render each cited source entity. Default `teaser` (`AgentSettingsRegistry::DEFAULT_VIEW_MODE`). |
| `answer_prompt` | text | Extra generation guidance appended after the built-in citation contract. |
| `no_answer_message` | label | Returned when retrieval yields no usable sources. Default `"I couldn't find sources to answer that."` |
| `feedback_enabled` | boolean | Accept feedback for this agent (default TRUE). |
| `conversation_ttl` | integer | Conversation retention seconds. Default `3600` (`DEFAULT_TTL`); form min 60. |
| `max_history_turns` | integer | Prior turns threaded to the model on follow-ups; `0` = all. A cost control. |

`AgentSettingsRegistry` helpers: `getSettings()`, `isEnabled()`, `allSettings()`,
`getEnabledAgentIds()`, `saveSettings()`, `noAnswerMessage()`, `maxHistoryTurns()`,
`conversationTtl()`.

## RAG settings resolution

`Service/RagSettingsResolver::resolve(AiAgent $agent, string $viewMode)` reads the agent's
`ai_search:rag_search` entry under `tools` + `tool_usage_limits`, returning
`{index_id, score_threshold (min_score), max_results (amount, default 5), view_mode}`, or `NULL`
when the agent has no rag_search tool or no fixed `index`. A NULL result makes the agent invalid
for answers (`AnswerService` throws `DomainException`). The index is fixed on the agent, not taken
from the request, so a question can only ever search that one index.

## Routes (`ai_answers.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `ai_answers.question` | `/ai-answers/question` (POST) | `_permission: use ai answers` + `_csrf_request_header_token: TRUE` |
| `ai_answers.feedback` | `/ai-answers/feedback` (POST) | `_permission: use ai answers` + `_csrf_request_header_token: TRUE` |
| `ai_answers.agents` | `/admin/config/ai/ai-answers/agents` | `_permission: administer ai answers` |
| `ai_answers.agent_settings` | `/admin/config/ai/ai-answers/agents/{ai_agent}` | `_permission: administer ai answers` |

Admin menu link (`ai_answers.links.menu.yml`): "AI Answers" under Configuration → AI
(`ai.admin_config_tools`).

## Permissions (`ai_answers.permissions.yml`)

- `use ai answers` — call the question and feedback endpoints (grant to the roles that may ask).
- `administer ai answers` (`restrict access: true`) — configure which agents answer and their
  settings.
- `view ai answers traces` (`restrict access: true`) — receive `log_id` / `trace_id` in answer
  responses; omitted otherwise.

## Admin forms (`src/Form/`)

- `AiAnswersAgentsForm` (`ai_answers.agents`) — read-only overview table of every `ai_agent` and
  whether AI Answers is enabled, with a "Configure AI Answers" operation per row.
- `AiAnswersAgentForm` (`ai_answers.agent_settings`) — the per-agent settings form writing the row
  above. Uses an `ai_provider_configuration` element (`chat_with_tools` operation) for the provider
  override and unions all content-entity view modes for `reference_view_mode`.
- `Hook/AiAnswersFormHooks::formAlter()` adds an "AI Answers" details section (status + link to the
  settings page) to the `ai_agent` (`AiAgentForm`) edit form.
