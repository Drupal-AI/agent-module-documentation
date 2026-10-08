<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP endpoints, controller & service (ai_agents_debugger)

All routes live in `ai_agents_debugger.routing.yml` under `/admin/config/ai/agents/debug`. The controller is
`Drupal\ai_agents_debugger\Controller\AIAgentsDebuggerController` (constructed with `ai.provider`,
`plugin.manager.ai_agents`, the current request, `entity_type.manager`, and
`ai_agents_debugger.progress_service`). Every method returns a `JsonResponse`.

## `ai_agents_debugger.form` — GET `…/debug`
Permission `debug ai agents`. Renders `AIAgentsDebuggerForm` (the workbench). See
[../config/debugger-ui.md](../config/debugger-ui.md).

## `ai_agents_debugger.start` — POST `…/debug/start` → `runAgent()`
Permission `debug ai agents`. Reads POST params: `chat_history` (JSON array of `{role, content}`), `agent`
(agent plugin id), `model` (a `provider__model` simple option), `files[]` (managed file ids), `thread_id`
(UUID), optional `tokens[...]` and `spoof_tokens` (JSON object). Validation: 400 if `chat_history`,
`agent`, `model` or `thread_id` is empty, or if `chat_history` is not a non-empty array.

Flow: loads the provider via `providerManager->loadProviderFromSimpleOption()` and the agent via
`agentsManager->createInstance($agent_name)`; derives the model name with
`getModelNameFromSimpleOption()`. Builds `ChatMessage[]` from the history, attaching any uploaded files
(loaded as `file` entities, wrapped in `ImageFile`) to the **last user message**. Configures the agent:
`setRunnerId`, `setChatHistory`, `setAiProvider`, `setModelName`, `setAiConfiguration([])`,
`setCreateDirectly(TRUE)`, `setProgressThreadId($thread_id)`. For a `ConfigAiAgentInterface` agent it merges
token contexts: entries under `tokens[...]` (loaded as entities when the key is an entity-type id, else the
raw scalar) plus every pair from `spoof_tokens`, passed to `setTokenContexts()`.

It then branches on `agent->determineSolvability()`:
- `JOB_SOLVABLE` → `solve()`
- `JOB_SHOULD_ANSWER_QUESTION` → `answerQuestion()`
- `JOB_NEEDS_ANSWERS` → `implode("\n", askQuestion())`
- `JOB_INFORMS` → `inform()`
- `JOB_NOT_SOLVABLE` → returns `{success:false, status:'not_solvable'}`

Success returns `{success:true, status:'completed', message:<response>}`; exceptions return
`{success:false, error:<message>}` with 500.

## `ai_agents_debugger.poll` — GET `…/debug/poll/{uuid}` → `pollAgent(string $uuid)`
Permission `debug ai agents`. Returns `{thread_id:<uuid>, items:[...]}` where items come from
`ProgressService::getProgress($uuid)`. The React monitor polls this while a run is in progress.

## `ai_agents_debugger.system_prompt.load` — GET `…/debug/system-prompt/{agent_id}` → `loadSystemPrompt()`
Permission `administer ai_agent`. Loads the `ai_agent` config entity; 404 if missing; else returns
`{system_prompt: <entity->get('system_prompt')>}`.

## `ai_agents_debugger.system_prompt.save` — POST `…/debug/system-prompt/save` → `saveSystemPrompt()`
Permission `administer ai_agent`. Reads a JSON body `{agent_id, system_prompt}` from
`$request->getContent()`. 400 if `agent_id` empty, 404 if the `ai_agent` entity is not found; otherwise
`$agent->set('system_prompt', $system_prompt)->save()` and returns `{success:true}`. This is a persistent
write to the agent config entity.

## `ai_agents_debugger.ask_ai` — POST `…/debug/ask-ai` → `askAi()`
Permission `debug ai agents`. Reads a JSON body `{question, agent_data, chat_history, model}`. 400 if
`question` or `model` is empty. Builds a system message that embeds the run's `agent_data` as pretty JSON,
appends `chat_history` and the `question`, then calls `provider->chat(new ChatInput($messages), $model)`
and returns `{success:true, answer:<text>}`. Exceptions → `{error:<message>}` 500. This powers the
"Ask AI about this run" chat and is unrelated to the optional `ai_agent_agent` suggestion.

## Service — `ProgressService` (`ai_agents_debugger.progress_service`)
`src/Service/ProgressService.php`, constructed with `ai_agents.agent_status_poller`
(`AiAgentStatusPollerServiceInterface`) and `ai_agents.private_temp_status_storage`
(`AiAgentStatusStorageInterface`). Methods:
- `initializeProgress($thread_id)` → `statusStorage->startStatusUpdate()`
- `getProgress($thread_id)` → `statusPoller->getLatestStatusUpdates()->toArray()`
- `clearProgress($thread_id)` → `statusPoller->deleteStatusUpdate()`

Progress items are stored by the AI Agents framework in its private temp status storage, keyed by the
`thread_id`/runner id the debugger assigns to the run.
