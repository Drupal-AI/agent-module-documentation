# api — running an assistant from code

Entry point: the **`ai_assistant_api.runner`** service (`AiAssistantApiRunner`). It is
**stateful** — configure it, then call `process()`.

```php
use Drupal\ai_assistant_api\Data\UserMessage;

/** @var \Drupal\ai_assistant_api\AiAssistantApiRunner $runner */
$runner = \Drupal::service('ai_assistant_api.runner');

$assistant = \Drupal::entityTypeManager()
  ->getStorage('ai_assistant')->load('my_assistant');

$runner->setAssistant($assistant);                 // takes an AiAssistant entity
$runner->setUserMessage(new UserMessage('Hello')); // Data\UserMessage wraps a string
$runner->setContext(['entity' => $node]);          // optional per-request context
// $runner->streamedOutput(TRUE);                   // optional streaming

/** @var \Drupal\ai\OperationType\Chat\ChatOutput $output */
$output = $runner->process();
$text = $output->getNormalized()->getText();
```

`process()` always returns an `ai\OperationType\Chat\ChatOutput` (AI Core's normalized
chat output). On error it logs to the `ai_assistant_api` channel and returns the
assistant's `error_message` as a `ChatOutput` — unless `setThrowException(TRUE)` was set,
in which case it rethrows.

## Key runner methods

| Method | Purpose |
|---|---|
| `setAssistant(AiAssistant $a)` | choose the assistant; also seeds the thread id |
| `setUserMessage(UserMessage $m)` | the user's message; stored to the thread if history is on |
| `setContext(array)` / `getContext()` | arbitrary per-request context array |
| `streamedOutput(bool)` | stream the reply (normalized output becomes a streamed iterator) |
| `process()` | run one turn → `ChatOutput` |
| `getProviderAndModel()` | resolves `llm_provider`/`llm_model`, expanding `__default__` via `ai.provider`'s `getDefaultProviderForOperationType('chat')` |
| `getThreadsKey()` / `setThreadsKey()` / `resetThread($id)` | thread id management |
| `getMessageHistory()` | prior messages (sliced to `history_context_length` pairs) |
| `setVerboseMode(bool)` | verbose (single-loop) mode for agent-backed runs |
| `setThrowException(bool)` | rethrow instead of returning the error message |

The runner resolves the provider through **AI Core's** `ai.provider`
(`AiProviderPluginManager`) and calls `->chat(ChatInput, $model_id, $tags)` — see the
parent module's [api doc](../../../../../1.4.x/agent/api/ai.md). Requests are tagged
`ai_assistant_api`, `ai_assistant_api_assistant_message_<id>`, `ai_assistant_thread_<tid>`.

## Two-pass action flow

When actions are enabled, `process()` first runs a **pre-prompt** pass (plan which
actions to call), executes each enabled `AiAssistantAction` (feeding its output back as
context), then runs a final pass to compose the reply. With `use_function_calling` on, the
tools are attached to the `ChatInput` instead. See
[../plugins/ai_assistant_api.md](../plugins/ai_assistant_api.md).

## Agent delegation

If the assistant's `ai_agent` field is set **and** `ai_agents` is installed, `process()`
delegates the whole turn to the **`ai_assistant_api.agent_runner`** service
(`Service\AgentRunner::runAsAgent()`), which drives an `AiAgent` plugin and persists
partial state in the `ai_assistant_threads` tempstore between turns.

## Events (alter behaviour without subclassing)

All are `Symfony` events dispatched during a run; subscribe with an event subscriber.

| Event class | `EVENT_NAME` | Lets you |
|---|---|---|
| `Event\AiAssistantSystemRoleEvent` | `ai_assistant.change_assistant_message` | rewrite the final system prompt (`get/setSystemPrompt()`) |
| `Event\PrepromptSystemRoleEvent` | `ai_assistant.change_preprompt_message` | rewrite the pre-action prompt |
| `Event\AiAssistantPassContextToAgentEvent` | `ai_assistant.pass_context_to_agent` | inject context into a delegated agent (`get/setContext()`, `getAgent()`) |

There is **no `.api.php` / hook API** — these events are the extension surface.

## Other services

- `ai_assistant_api.assistant_message_builder` (`Service\AssistantMessageBuilder`) — builds
  the system message: `buildMessage()`, `getFunctionCalls()`, `getFewShotExamples()`,
  `getUsageInstructions()`, `getPrePromptDrupalContext()`.
- `cache.ai_assistant_api` — dedicated cache bin.
