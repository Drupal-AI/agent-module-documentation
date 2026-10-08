<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `baidu` AI provider plugin & Qianfan client

## Provider plugin

`src/Plugin/AiProvider/BaiduProvider.php` — `#[AiProvider(id: 'baidu', label: 'Baidu')]`, extends
`Drupal\ai\Base\AiProviderClientBase`, implements **`ChatInterface`** only. Reached via
`\Drupal::service('ai.provider')->createInstance('baidu')`.

- `getSupportedOperationTypes()` → `['chat']`. No `getSupportedCapabilities()` override (no streaming,
  no embeddings). `getModelSettings()` returns the general config unchanged.
- `getConfig()` → `ai_provider_baidu.settings`. `isUsable()` is FALSE unless `api_key` is set.
- `getConfiguredModels('chat')` returns a fixed, code-defined list mapped to itself via
  `array_combine`: ERNIE 4.5 turbo variants (`ernie-4.5-turbo-128k`, `-32k`, `-vl*`, `-8k-preview`),
  ERNIE speed/lite/tiny (`ernie-speed-128k`, `ernie-speed-8k`, `ernie-speed-pro-128k`,
  `ernie-lite-8k`, `ernie-lite-pro-128k`, `ernie-tiny-8k`), plus `DeepSeek-V3.1-250821` and
  `Kimi-K2-Instruct`. Any other operation type → `[]`.
- `setAuthentication($key)` stores the raw key string. `loadApiKey()` reads the Key value through
  `keyRepository`. `loadClient()` lazily fetches the `ai_provider_baidu.client` service and calls
  `setApiToken($this->apiKey)`. `getClient($api_key)` allows hot-swapping the key.
- A `protected bool $moderation = TRUE;` property exists but is unused (no moderation call is made).

### chat()

```php
$response = $this->client->textGeneration('/v2/chat/completions', $model_id, $input);
$data = Json::decode($response);
$message = new ChatMessage($data['choices'][0]['message']['role'] ?? '',
                           $data['choices'][0]['message']['content'] ?? '');
return new ChatOutput($message, $response, []);
```

Only the **first** message of the input is sent (see client below). The decoded OpenAI-style
`choices[0].message` becomes the `ChatMessage`. No exception mapping (rate limit/quota) is done.

## Qianfan client (`BaiduClient`)

Service `ai_provider_baidu.client`, constructed with the core Guzzle `@http_client`.

- `$serverless = 'https://qianfan.baidubce.com'`. `finalEndpoint($endpoint)` returns `$endpoint`
  verbatim if it begins with `http://`/`https://`, otherwise prefixes the serverless base. In
  practice `chat()` always passes the relative `/v2/chat/completions`, so the fixed Baidu host is used
  (no request-supplied host reaches the client).
- `textGeneration($endpoint, $model_id, $prompt)` takes `$prompt->getMessages()[0]->toArray()` — the
  **first** message only — and posts `{model, messages: [{role, content}]}`.
- `makeRequest()` throws if the token is empty, sets `connect_timeout`/`read_timeout` 120, adds
  `Authorization: Bearer <token>`, JSON-encodes the body with `Content-Type: application/json`, and
  calls `$this->client->request('POST', $apiEndPoint, $options)`. **No `verify` option is set**, so
  TLS verification is at the Guzzle default (on). The token is only ever an HTTP header, never in the
  URL. (Doc-comment strings still say "Huggingface" — copy-paste leftovers; behavior is Baidu.)

## Limitations to note

- Chat is single-turn as coded (only the first message is forwarded); multi-message history is
  dropped.
- No streaming, embeddings, tools, or structured output.
