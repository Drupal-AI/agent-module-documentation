# Chat processor — run a workflow as a chatbot backend

`src/Plugin/ChatProcessor/FlowDropWorkflowProcessor.php` is a `#[ChatProcessor(id: 'flowdrop_workflow')]`
plugin (extends `Drupal\ai\Base\ChatProcessorBase`). It plugs into the `drupal/ai` chatbot so that a
chat conversation is answered by **executing a whole FlowDrop workflow** instead of a single model call.

## Configuration

Two config keys (schema type `ai_chat_processor.configuration.flowdrop_workflow` in
`config/schema/flowdrop_ai_provider.schema.yml`), edited via `buildConfigurationForm()`:

- `workflow_id` (required) — the `flowdrop_workflow` config entity to run.
- `remember_conversation` (bool, default `TRUE`) — reuse one FlowDrop **session** per chat thread so the
  workflow's Session History / Chat Input node sees prior turns; disable for stateless one-shot runs.

## Execution flow (`doExecute(): ChatOutput`)

1. Resolves a **thread id** (`getThreadId()`): a client-sent id wins; in memory mode it is persisted per
   user+workflow in `PrivateTempStore` (collection `flowdrop_chat_sessions`); one-shot mode generates an
   ephemeral UUID per request.
2. Maps the thread to a `flowdrop_session` (stored key `thread_<id>` in the same temp store). If none
   exists (or memory is off) it creates a session via `flowdrop_session.service`.
3. **Interrupt resume:** if the session is `AWAITING_INPUT`, the user's message resolves the pending
   human-in-the-loop interrupt (`flowdrop_interrupt.manager::resolveInterrupt`), interpreting
   affirmative/negative words for `confirmation` interrupts; otherwise it runs a normal turn.
4. Runs the turn inline with `flowdrop_session.turn_service::executeTurn($sessionId, $userText,
   new TurnOptions(wait: TRUE))`; `ConcurrentTurnException` returns a "still processing" message.
5. Builds the `ChatOutput` from the assistant messages the turn wrote (falls back to the last assistant
   message on the session); if the workflow hit another interrupt it returns the interrupt question and
   keeps the thread→session mapping so the next message resumes it.

`getMessageHistory()` renders up to the newest 50 `user`/`assistant` messages of the mapped session for
the chatbot UI on reload (the model-facing window is the workflow's own Session History node's job).
`resetThread()` drops the mapping and issues a fresh thread id.

## Reasoning backend — `flowdrop.chat_reasoner` override

`flowdrop_ai_provider.services.yml` overrides the `flowdrop.chat_reasoner` service with
`Service\Reasoning\ChatReasoner`, replacing FlowDrop's null reasoner so a **Reason** node gains a real
`drupal/ai`-backed, function-calling implementation once this module is installed. `ChatReasoner::reason()`
translates FlowDrop's neutral `ReasonRequest` (messages + tool bindings) into `drupal/ai` `ChatInput` /
`ChatMessage` / `ToolsInput`, calls `$provider->chat()`, and maps the response (text + tool calls) back to
a `ReasonResult`. It replays only `user`/`assistant`/`tool` roles (system prompt is owned by config), and
folds JSON-Schema `required` into property descriptions rather than emitting a per-property `required`
boolean (which Anthropic rejects). This is the only place `Drupal\ai\*` types appear in the reason path.
