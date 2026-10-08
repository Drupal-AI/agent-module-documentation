<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `langdock` AI provider plugin

`src/Plugin/AiProvider/LangdockProvider.php` — `#[AiProvider(id: 'langdock', label: 'Langdock')]`,
extends `Drupal\ai\Base\OpenAiBasedProviderClientBase`, uses `ChatTrait`. It is modelled on
`ai_provider_openai`, so most OpenAI-SDK behaviour is inherited from the base class.

## Operations

`getSupportedOperationTypes()` → `['chat', 'embeddings']`.

### chat()

- Normalizes a `ChatInput` into OpenAI `messages` (system prompt + per-message role/content,
  carrying `tool_call_id` and `tool_calls` when present). Payload = `model` + `messages` +
  `$this->configuration` (max_tokens, temperature, top_p, frequency_penalty, presence_penalty).
- Tools: if the input exposes `getChatTools()`, renders them into `payload['tools']` with
  `function.strict = FALSE`.
- Structured output: if `getChatStructuredJsonSchema()` is set, adds
  `response_format = { type: json_schema, json_schema: ... }`.
- Streaming: when `$this->streamed`, or when running inside a `\Fiber`, it calls
  `chat()->createStreamed()` and wraps the response in `LangdockChatMessageIterator`; the Fiber
  path consumes the stream, capturing usage and suspending until finished. Otherwise a plain
  `chat()->create()->toArray()` is used and tool calls are decoded into `ToolsFunctionOutput`.
- Errors: messages containing "Request too large" / "Too Many Requests" → `AiRateLimitException`;
  "You exceeded your current quota" → `AiQuotaException`; anything else re-thrown.
- Token usage is recorded via `setChatTokenUsage()` for non-streamed / non-fiber calls.

### embeddings()

`embeddings()` sends `{ model, input } + $this->configuration` to `embeddings()->create()` and
returns an `EmbeddingsOutput` from `response['data'][0]['embedding']`.
`embeddingsVectorSize()` maps `text-embedding-ada-002` / `-3-small` → 1536,
`text-embedding-3-large` → 3072, else 0.

## Models

- `getConfiguredModels()` → `loadClient()` then `getModels()`.
- `getModels('chat', ...)` calls the SDK `models()->list()` and returns every model id the
  endpoint reports (cached in `cache.default` under `openai_models_{op}_{hash}`).
- `getModels('embeddings', ...)` returns a single fixed entry `text-embedding-ada-002`.

## Model settings (`getModelSettings()`)

- For `gpt-5*`, `o1*`, `o3*`: renames `max_tokens` → `max_completion_tokens` and drops
  `frequency_penalty`, `top_p`, `presence_penalty`, `temperature`.
- For reasoning models (`isReasoningModel()` → any `gpt-5*`): adds a `reasoning_effort` select
  (`minimal|low|medium|high`, default `medium`).

## Endpoint / client

`loadClient()` sets the SDK base URI to the `host` config value (if set) before delegating to
`parent::loadClient()`, re-wrapping an `AiSetupFailureException` with a clearer message.
`getEndpoint()` returns `$this->endpoint` or `configuration['host']`. The HTTP client is the
injected Drupal `http_client` (see [../config/settings.md](../config/settings.md)); the API key
comes from the Key entity resolved by the base class.

## Setup data

`getSetupData()` → `key_config_name: api_key`; default models chat `gpt-5.2`,
embeddings `text-embedding-ada-002`. `postSetup()` is a no-op.
