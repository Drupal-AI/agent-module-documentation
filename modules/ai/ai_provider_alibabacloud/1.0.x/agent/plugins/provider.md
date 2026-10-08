<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `alibabacloud` AI provider plugin

`src/Plugin/AiProvider/AlibabaCloudProvider.php` — `#[AiProvider(id: 'alibabacloud', label:
'Alibaba Cloud Model Studio')]`, extends `Drupal\ai\Base\AiProviderClientBase`, implements
`ChatInterface` and `EmbeddingsInterface`, uses `ChatTrait`. Reached through the AI module, e.g.
`\Drupal::service('ai.provider')->createInstance('alibabacloud')`.

## Capabilities & models

- `getSupportedOperationTypes()` → `['chat', 'embeddings']`.
- `getSupportedCapabilities()` → `[AiProviderCapability::StreamChatOutput]`.
- `getConfiguredModels($operation_type)` returns a hard-coded map: chat = `qwen-max`, `qwen-plus`,
  `qwen-turbo`, `qwen-flash`, `qwen-coder`; embeddings = `text-embedding-v1`…`v4`. (Alibaba exposes
  no model-list endpoint — `AlibabaCloudHelper::getAvailableModels()` also hard-codes the list.)
- `isUsable()` returns FALSE unless `key_id` is set, then checks the operation type is supported.
- `getApiDefinition()` parses `definitions/api_defaults.yml` (chat + embeddings parameter schema:
  max_tokens, temperature, top_p, presence/frequency/repetition penalties, enable_thinking,
  thinking_budget, stream, incremental_output; embeddings `dimension`).
- `getModelSettings()` adjusts `max_tokens` per model (turbo/flash → max 8000; plus/max/coder → max
  32768) and injects native-mode defaults when `api_mode === 'native'`.
- `embeddingsVectorSize()`: v1/v2 → 1536, v3/v4 → 1024. `maxEmbeddingsInput()` → 2048.

## Authentication & config loading

`loadApiConfiguration()` (called at the start of `chat()`/`embeddings()`) reads
`ai_provider_alibabacloud.settings`, and if `$this->apiKey` is empty loads the Key entity named by
`key_id` from `keyRepository` and calls `getKeyValue()`. `setAuthentication($value)` lets the AI
framework inject a key directly. `apiMode` and `region` come from config (defaults `compatible` /
`intl`).

The key travels as an HTTP header only:

```php
$this->httpClient->request('POST', $url, [
  'headers' => [
    'Authorization' => 'Bearer ' . $this->apiKey,
    'Content-Type' => 'application/json',
  ],
  'json' => $payload,
  'timeout' => $this->getConfig()->get('timeout') ?: 60,
]);
```

`$this->httpClient` is the core Guzzle `http_client`; no request option disables TLS verification, so
verification is at the Guzzle default (on). `$url` is always a fixed `getBaseUrl()` value plus a
fixed path — no request-supplied host.

## chat()

1. `normalizeChatInput()` turns a string / array / `ChatInput` into a messages array, prepending the
   `chatSystemRole` when set, converting each `ChatMessage` to `{role, content:[{type:text,…}]}`,
   attaching base64 images (`image_url`) and tool-call ids/results.
2. Compatible mode → `buildCompatiblePayload()` (`model`, `messages`, + temperature/top_p/penalties/
   max_tokens) posting to `…/chat/completions`. Native mode → `buildNativePayload()`
   (`model`, `input.messages`, `parameters{…, repetition_penalty, enable_thinking, thinking_budget}`)
   posting to `…/services/aigc/text-generation/generation`.
3. Tools (`addToolsToPayload()`) and JSON-schema output (`addStructuredResponseToPayload()`, sets
   `response_format = {type: json_schema, json_schema: …}`) are added under the mode-appropriate key.
4. If `$this->streamed` → `streamChat()`, else `regularChat()`.

### regularChat()

POSTs and decodes JSON. Compatible: reads `choices[0].message` → content/role and builds
`ToolsFunctionOutput` objects from `tool_calls`. Native: reads `output.text`. Wraps a `ChatMessage`
in a `ChatOutput`. Missing expected keys → `AiResponseErrorException`.

### streamChat()

Sets `stream => TRUE` (compatible: `payload['stream']=true`, optional `stream_options.include_usage`;
native: `parameters.incremental_output=true` + header `X-DashScope-SSE: enable`), requests with the
Guzzle `stream` option, wraps the body with `GuzzleHttp\Psr7\StreamWrapper::getResource()` and
returns a `ChatOutput` holding an `AlibabaCloudStreamIterator($stream, $apiMode)`.

- `AlibabaCloudStreamIterator` (extends `ai`'s `StreamIteratorBase`) reads SSE lines, strips the
  `data: ` prefix, stops on `[DONE]`, JSON-decodes each event and yields a `ChatMessage` for each
  delta (compatible: `choices[0].delta.content`; native: `output.text`/`output.choices`).
- `AlibabaCloudChatMessageIterator` yields per-chunk `ChatMessage`s from the decoded stream.

## embeddings()

Always uses the compatible-mode base URL + `/embeddings`, payload `{model, input}`. Decodes
`data[0].embedding` into an `EmbeddingsOutput` (missing → `AiResponseErrorException`).

## Error handling

`handleApiException(RequestException $e)` inspects the response body: HTTP 429 or `rate_limit` →
`AiRateLimitException`; `quota`/`insufficient_balance` → `AiQuotaException`; otherwise logs to the
`ai_provider_alibabacloud` channel and re-throws. The connection-test path
(`AlibabaCloudHelper::testConnection()`) maps 401/403 to user-facing messenger errors.
