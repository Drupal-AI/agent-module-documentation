<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Answers (ai_answers) — agent index

RAG answer engine that turns an existing **`ai_agent`** into a cited-answer service. A visitor's
question is answered by running the agent's own execution loop; retrieval is a real
`ai_search:rag_search` tool call against a fixed Search API index, and the answer is grounded
strictly in what it retrieves (built-in citation contract). Version **1.0.0-alpha2**, version dir
`1.0.x`. Core `^11.2`. Package `AI`. License GPL-2.0-or-later.

- **Deps** (Composer): `drupal/ai ^1.4`, `drupal/ai_agents ^1.3`, `drupal/ai_search ^1.3@alpha`.
  Enabled-module deps (info.yml): `ai_agents`, `ai_search`. Suggests: `ai_logging` (persist
  answers/feedback as `ai_log`), `langfuse` (trace correlation).
- **No** new entity types, no plugin types, no Drush. Provides two **Block** plugins, one config
  object, three permissions, two theme hooks, three event subscribers.

## Solution docs

- **Per-agent settings, config object, schema, routes & permissions, admin forms** →
  [config/settings.md](config/settings.md)
- **The `/ai-answers/question` and `/ai-answers/feedback` HTTP endpoints (SSE + JSON contract)** →
  [api/endpoints.md](api/endpoints.md)
- **The Question and Answer blocks and their JS runtime (markdown render, citations, feedback)** →
  [blocks/blocks.md](blocks/blocks.md)

## What it actually provides (from source)

- **Blocks** (`src/Plugin/Block/`): `ai_answers_question` (QuestionBlock — a question input that
  drives an Answer block) and `ai_answers_answer` (AnswerBlock — renders the streamed answer +
  references + feedback). Both are cacheable static shells; content arrives over the API via JS.
- **Controller** `AiAnswersController` (`src/Controller/`): `question()` (POST, content-negotiated
  SSE or JSON) and `feedback()` (POST, JSON). Both routes require the `use ai answers` permission
  **and** a CSRF request-header token.
- **Services** (`ai_answers.services.yml`): `AnswerService` (the pipeline: read config → force/run
  retrieval → run agent → gate → generate → finalize citations → persist), `RagSettingsResolver`
  (reads the agent's `ai_search:rag_search` tool limits: index / amount / min_score),
  `AgentSettingsRegistry` (reads/writes the `ai_answers.agents` config object), `AgentRunContext`
  (single-slot context shared with the agent event subscribers), `FeedbackLogger` (annotates the
  correlated `ai_log` + submits a Langfuse score).
- **Event subscribers** (`src/EventSubscriber/`): `AnswerSystemPromptSubscriber` (appends the
  citation contract + sources block to the agent's system prompt), `AnswerToolResultSubscriber`
  (captures the rag_search tool's structured results), `TemporaryChunkTrackingResetEventSubscriber`
  (a documented temporary stopgap for ai_search issue #3584035, reachable via `drush`/clear-index).
- **Data DTOs** (`src/Data/`): `Answer`, `ConversationTurn`, `Reference`, `Source`.
- **Config** object `ai_answers.agents` (schema `config/schema/ai_answers.schema.yml`; install
  default `agents: []`); block-settings schema for both blocks; config_translation for
  `ai_answers.agents`.
- **Routes** (`ai_answers.routing.yml`): `ai_answers.question`, `ai_answers.feedback`,
  `ai_answers.agents` (overview form, `administer ai answers`), `ai_answers.agent_settings`
  (per-agent form). Admin menu link under Configuration → AI (`ai.admin_config_tools`).
- **Permissions** (`ai_answers.permissions.yml`): `use ai answers`, `administer ai answers`
  (restricted), `view ai answers traces` (restricted — adds `log_id`/`trace_id` to responses).
- **Hooks** (`src/Hook/`): `theme` (two theme hooks + Twig in `templates/`), `form_alter` (adds an
  "AI Answers" summary/link to the `ai_agent` edit form).
