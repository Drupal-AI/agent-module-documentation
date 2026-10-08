<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `deepseek` AiProvider plugin

`src/Plugin/AiProvider/DeepseekProvider.php` — class `DeepSeekProvider`, attribute
`#[AiProvider(id: 'deepseek', label: new TranslatableMarkup('DeepSeek'))]`. Extends
`Drupal\ai\Base\AiProviderClientBase`, implements `Drupal\ai\OperationType\Chat\ChatInterface`.

## Capabilities

- `getSupportedOperationTypes(): array` → **`['chat']`**. That is the only operation type; there is
  no tools/function-calling, embeddings, moderation, TTS, or image support.
- `isUsable($operation_type, $capabilities)` returns FALSE when config `api_key` is empty; otherwise
  TRUE, or `in_array($operation_type, ['chat'])` when an operation type is passed.
- `$moderation = TRUE` is declared but never read — no pre-moderation call is actually made.

## Models

- `getConfiguredModels()` returns a hard-coded map:
  `['deepseek-v4-flash' => 'deepseek-v4-flash', 'deepseek-v4-pro' => 'deepseek-v4-pro']`.
- `getApiDefinition()` parses `definitions/api_defaults.yml`, which instead lists models
  `deepseek-chat` (default, 32768 ctx) and `deepseek-coder`, plus chat defaults
  (`temperature: 0.7`, `top_p: 1`, `max_tokens: 1024`, `presence_penalty`/`frequency_penalty: 0`,
  `stop: []`, `safe_prompt: true`, `random_seed: null`).
- The bundled `deepseek-php` library's default model constant is `DeepSeek-R1`.
- These three sets disagree and none match DeepSeek's current public model ids
  (`deepseek-chat`, `deepseek-reasoner`). Treat model ids as unverified and confirm against the API.

## Authentication & client

- `getConfig()` → immutable config `ai_provider_deepseek.settings`.
- `loadApiKey()` → `keyRepository->getKey($this->getConfig()->get('api_key'))->getKeyValue()`; the
  config stores the **Key entity id**, not the raw secret.
- `setAuthentication($authentication)` sets `$this->apiKey` and nulls the cached client (allows
  hot-swapping the key). `getClient($api_key = '')` optionally re-authenticates then `loadClient()`.
- `loadClient()` lazily builds `DeepseekClient::build($this->apiKey)` once. It passes only the key —
  no base URL and no timeout override — so the library's defaults apply
  (base URL `https://api.deepseek.com/v3`, Guzzle client, 30s timeout, `Authorization: Bearer <key>`
  and `Content-Type: application/json` headers). There is no module setting for the base URL.

## Request flow — `chat()`

```
public function chat(array|string|ChatInput $input, string $model_id, array $tags = []): ChatOutput {
  $this->loadClient();
  $response = $this->client->query($input)->withModel($model_id)->run();
  $data = Json::decode($response);
  $message = new ChatMessage($data['choices'][0]['message']['role'] ?? '', $data['choices'][0]['message']['content'] ?? '');
  return new ChatOutput($message, $response, []);
}
```

- `withModel($model_id)` selects the model; `run()` posts to the chat endpoint and returns the raw
  JSON string. The reply is parsed OpenAI-style (`choices[0].message.{role,content}`).
- Caveat: `DeepseekClient::query()` is typed `string $content`, but `chat()` forwards `$input`
  unchanged. A `ChatInput` object or a messages array will not satisfy that signature — in practice
  only a plain string prompt flows through cleanly. `getModelSettings()` returns the general config
  untouched, so chat defaults from `api_defaults.yml` are not applied to the call.

## Operate it

1. Enable the module and configure a key (see [../config/settings.md](../config/settings.md)).
2. In the AI module, pick provider `deepseek` and a model for a chat-capable feature.
3. The provider is `isUsable()` only once `ai_provider_deepseek.settings:api_key` names a Key.
