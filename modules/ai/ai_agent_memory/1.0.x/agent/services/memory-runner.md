<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Memory — the runner decorator, state machine, trimmer, stripper

## Services (`ai_agent_memory.services.yml`)

- **`ai_agent_memory.AgentMemoryRunner`** — `decorates: ai_assistant_api.agent_runner`. Args:
  `@.inner`, `@ai.provider`, `@tempstore.private`, `@event_dispatcher`, `@config.factory`,
  `@ai_agent_memory.chat_history_trimmer`, `@ai_agent_memory.chat_message_file_stripper`,
  `@?plugin.manager.ai_agents` (optional). Extends upstream `AgentRunner`; the parent constructor is
  called with the provider, tempstore, dispatcher, and agent plugin manager.
- **`ai_agent_memory.chat_history_trimmer`** — `ChatHistoryTrimmer(@config.factory)`.
- **`ai_agent_memory.chat_message_file_stripper`** — `ChatMessageFileStripper` (no args).

## Decorator entry point — `AgentMemoryRunner::runAsAgent()`

`src/Service/AgentMemoryRunner.php`. Reads `enabled_agents` from `ai_agent_memory.settings`. If the
`$assistant_id` is **not** in that list, it returns `$this->inner->runAsAgent(...)` unchanged
(stock stateless behaviour). Otherwise it calls the private `runPersistent()`.

Persistence uses the **private temp store** (`@tempstore.private`) bin
`ai_agent_memory_threads` (const `TEMP_STORE_BIN`), keyed by the `$job_id`. Private temp store is
namespaced to the owner by Drupal core, so each stored thread belongs to the user/session that
created it.

## `runPersistent()` flow

1. `$store->get($job_id)` → `$persisted` (or NULL).
2. `AgentState::detect($persisted, count($chat_history))` picks a state (see below).
3. If `Stale`: log a notice, `$store->delete($job_id)`, treat as `Fresh`.
4. `$agent = $this->aiAgentPluginManager->createInstance($assistant_id)`.
5. `match($state)` dispatches to one of the restore helpers.
6. Dispatches `AiAssistantPassContextToAgentEvent` (name `EVENT_NAME`) with the agent + context.
7. `$agent->determineSolvability()` inside try/catch. On exception: log error, persist state with
   `JOB_NOT_SOLVABLE`, return `buildErrorResponse()`.
8. `JOB_NOT_SOLVABLE` result → a warning is logged (execution continues).
9. `$this->fileStripper->stripFiles($agent)`, then `trimAndPersist(...)`, then `buildResponse(...)`.

## State machine — `src/Enum/AgentState.php`

`enum AgentState { Fresh, Stale, CrossTurn, SameTurn }`. `AgentState::detect(?array $persisted, int
$session_message_count)`:

- No `$persisted` → **Fresh** (initialize from scratch).
- `$was_finished = !empty($persisted['finished'])`; `$has_new_messages = $session_message_count >
  ($persisted['processed_message_count'] ?? 0)`.
- finished **and no** new messages → **Stale** (discard, restart).
- finished **and** new messages → **CrossTurn** (new turn after completion).
- otherwise → **SameTurn** (mid-execution; frontend polling).

Restore helpers in the runner:

- `initializeFresh()` — maps `$chat_history` (`['role','message']` arrays) into `ChatMessage`
  objects, `setChatInput(new ChatInput($messages, []))`, sets provider
  (`$this->aiProvider->createInstance($defaults['provider_id'])`), model (`$defaults['model_id']`),
  `setCreateDirectly(TRUE)`. Verbose mode → `setLooped(FALSE)`.
- `restoreForCrossTurn()` — `$agent->fromArray($persisted['agent_data'])` after zeroing `looped`
  and clearing `context_tools` / `tool_results` / `agent_results`; then appends only the **new**
  user messages (`array_slice($chat_history, $processed)`, `role === 'user'` only) onto the restored
  history.
- `restoreForSameTurn()` — `fromArray()` with `tool_results` / `agent_results` cleared, everything
  else (including `looped`, `context_tools`) preserved to continue the current cycle.

## Persistence — `trimAndPersist()`

Sets the agent's history to `$this->historyTrimmer->trim($agent->getChatHistory())`, then
`$store->set($job_id, [...])` with `agent_data => $agent->toArray()`,
`processed_message_count => $session_message_count`, and `finished => ($solvability ===
JOB_NOT_SOLVABLE || $agent->isFinished())`.

## Response — `buildResponse()` / `buildErrorResponse()`

`buildResponse()` calls `$agent->solve() ?? ''`. If the last history message's role is `user` (agent
produced nothing, e.g. provider timeout), it logs a warning and returns the error response instead
of echoing the user's own text. `buildErrorResponse()` returns a `ChatOutput` with a generic
"AI provider may be temporarily unavailable" assistant message.

## `ChatHistoryTrimmer` — `src/Service/ChatHistoryTrimmer.php`

`trim(array $chatHistory)` reads `max_history_messages` / `keep_recent_turns` from config. Returns
the history unchanged if `count <= max`. Otherwise `segmentIntoTurns()` splits the flat
`ChatMessage[]` into turns (a `user` message plus every following assistant/tool message until the
next `user`), then keeps `turns[0]` (first turn) + `array_slice($turns, -$keepRecentTurns)` and
flattens back to messages. Guards: unchanged if `turns <= 1` or `turns <= keepRecentTurns + 1`.
Because it slices whole turns, a tool call is never separated from its result.

## `ChatMessageFileStripper` — `src/Service/ChatMessageFileStripper.php`

`stripFiles(object $agent)` iterates the agent's chat history; for any `ChatMessage` with non-empty
`getFiles()`, it uses a `ReflectionProperty(ChatMessage::class, 'files')` to set the files to `[]`
(there is no public `clearFiles()`), then `setChatHistory()` if anything changed. This removes raw
binary file data that `ChatMessage::toArray()` would serialize but `fromArray()` cannot reconstruct,
so persisted state stays restorable.
