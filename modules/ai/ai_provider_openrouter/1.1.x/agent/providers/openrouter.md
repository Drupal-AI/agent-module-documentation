<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `openrouter` AiProvider plugin

`src/Plugin/AiProvider/OpenRouterProvider.php` —
`#[AiProvider(id: 'openrouter', label: 'OpenRouter')]`, extends AI Core's
`AiProviderClientBase`, uses `ChatTrait`, implements `ChatInterface`, `EmbeddingsInterface`,
`TextToImageInterface`, `ContainerFactoryPluginInterface`.

- **Operation types:** `getSupportedOperationTypes()` → `['chat', 'embeddings', 'text_to_image']`.
- **Capabilities:** `getSupportedCapabilities()` → `[StreamChatOutput]`.
- **Usable when:** `isUsable()` is TRUE iff `api_key` (a Key machine name) is set in config.
- **Config source:** `getConfig()` returns `ai_provider_openrouter.settings`.

## HTTP client — `OpenRouterClient` (`ai_provider_openrouter.client`)

`src/Service/OpenRouterClient.php`, public service. Constructor args: `@config.factory`,
`@key.repository`, `@logger.channel.ai_provider_openrouter`, `@http_client`.

- On construction it resolves the key: reads `api_key` (Key machine name) from config,
  `keyRepository->getKey($name)->getKeyValue()`, and builds an **`openai-php/client`** instance via
  `(new OpenAI\Factory())->withApiKey($key)->withBaseUri($base_url)->make()`. OpenRouter is
  OpenAI-wire-compatible, so chat/embeddings reuse the OpenAI SDK.
- `chatCompletion()` → `client->chat()->create()`; `chatCompletionStream()` → `createStreamed()`
  (sets `stream = TRUE`); `embeddings()` → `client->embeddings()->create()`.
- `listModels()` uses a **raw Guzzle** GET (not the SDK) to `/models` and `/embeddings/models`,
  sending `Authorization: Bearer <key>`, `Accept: application/json`,
  `HTTP-Referer: https://drupal.org`, `X-Title: Drupal AI Module`, timeout 15s. Embedding models
  are tagged `_is_embedding_model = TRUE`. Failures are logged and return `[]` (or partial).
- TLS: default Guzzle/SDK verification is used — no `verify => false` and no custom TLS options.

## Chat (`chat()`)

- Normalises `ChatInput` / array / string into OpenAI-style `messages`. Each message becomes typed
  content parts: `{type: text}`, plus `{type: image_url}` (images), `{type: video_url}` (videos),
  or `{type: file, file: {filename, file_data}}` (PDFs) when the model/message carries files
  (base64-encoded). Falls back to `getImages()` for older callers.
- System prompt (`chatSystemRole`) is added as a `system` message, but as a `user` message for
  `o1`/`o3` models (mirrors the OpenAI provider).
- Merges the provider `configuration` into the payload. Tool calling: `input->getChatTools()` →
  `payload['tools']` (with `function.strict = FALSE`); tool results are read back into
  `ToolsFunctionOutput`. Structured output: `getChatStructuredJsonSchema()` →
  `response_format: {type: json_schema, json_schema: ...}`.
- **Streaming:** enabled when the input requests it, `$this->streamed` is TRUE, or a DeepChat
  force-stream flag is set (see below). Adds `stream_options.include_usage = TRUE` and returns a
  `ChatOutput` wrapping `OpenRouterStreamedChatMessageIterator`
  (`src/OperationType/Chat/…`), which yields `StreamedChatMessage` chunks and propagates
  input/output/total/reasoning/cached token usage and the finish reason.
- **Non-stream:** returns `ChatOutput` with a `ChatMessage`, and sets a `TokenUsageDto`
  (total/input/output/reasoning/cached) from `response.usage`.
- **Error mapping:** messages containing "Request too large" / "Too Many Requests" →
  `AiRateLimitException`; "You exceeded your current quota" → `AiQuotaException`;
  "content policy violation" → `AiUnsafePromptException`; otherwise `AiResponseErrorException`.

## Embeddings (`embeddings()`)

- Accepts `EmbeddingsInput` / string / array (batch). Passes `dimensions` (int, Matryoshka
  truncation) and `encoding_format` from configuration when set. Returns an `EmbeddingsOutput`
  (single vector, or array of vectors for batch) plus usage metadata.
- `embeddingsVectorSize($model_id)` is a hard-coded `match()` map (e.g. OpenAI ada/3-small = 1536,
  3-large = 3072, Gemini 001 = 768, Qwen3-8b = 4096, BGE-m3 = 1024, MiniLM = 384; unknown → 0).
- `maxEmbeddingsInput()` returns a conservative 8192.

## Text-to-image (`textToImage()`)

- Uses the **chat-completions** endpoint with `modalities: ['image', 'text']` (optionally
  `image_config` for Gemini). Parses base64 `data:image/…` URLs from
  `choices[0].message.images` into AI Core `ImageFile` objects (png/jpg/webp). Throws
  `AiResponseErrorException` if no image is returned.

## Model discovery & filtering (`getConfiguredModels()`)

- Calls `listModels()`, filters by operation type (embedding-only vs chat/image), and — when
  `enabled_models` is non-empty — restricts to whitelisted ids; empty whitelist = all models.
- `getMaxInputTokens()` / `getMaxOutputTokens()` read `context_length` /
  `top_provider.max_completion_tokens` from the live model metadata (fallbacks 8192 / 25% of input).

## Reasoning models (`getModelSettings()` / `isReasoningModel()`)

- For `openai/gpt-5*`, `openai/o1*`, `openai/o3*`, and Grok reasoning models, adds a
  `reasoning_effort` select (none / minimal / low / medium / high / xhigh).

## DeepChat streaming hooks (`ai_provider_openrouter.module`)

- `hook_deepchat_settings`, `hook_page_attachments_alter`, `hook_preprocess_ai_deepchat` force
  `stream: true` for **legacy** (non-agent) assistants and set `stream: false` for **agent-based**
  assistants (those with a non-empty `ai_agent`), because the agent runner expects a single
  non-streamed response. Attaches the `ai_provider_openrouter/deepchat_force_stream` JS library.
- The `chat()` method reads request attributes (`ai_deepchat_stream_flag`,
  `ai_deepchat_assistant_id`) to decide whether to force streaming for a legacy assistant.
