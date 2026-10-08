<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `xai` AI provider plugin

`src/Plugin/AiProvider/XAIProvider.php` — `#[AiProvider(id: 'xai', label: 'xAI')]`, extends
`AiProviderClientBase` and implements `ChatInterface`.

## Client

`loadClient()` resolves the API key (from the configured Key via `loadApiKey()` when not already set),
then builds `new GrokClient(new GrokConfig($this->apiKey))` from the `grok-php/client` library. The
xAI endpoint and HTTP transport are handled internally by that library (this module does not construct
a Guzzle client or set a base URI itself). `setAuthentication($key)` stores the key and nulls the
client; `getClient(string $api_key = '')` optionally hot-swaps the key before returning the client.

## Capabilities

- `getConfiguredModels()` returns `['grok-2' => 'Grok 2']`.
- `getSupportedOperationTypes()` returns `['chat']` (embeddings, moderation, text_to_image,
  text_to_speech, speech_to_text are present only as commented-out entries).
- `isUsable()` is false until `ai_provider_xai.settings:api_key` is set.
- `getApiDefinition()` reads `definitions/api_defaults.yml`; `getModelSettings()` passes config
  through unchanged.

## `chat()` — scaffold, read before use

```php
public function chat(array|string|ChatInput $input, string $model_id, array $tags = []): ChatOutput {
  $this->loadClient();
  $messages = [['role' => 'user', 'content' => 'How do black holes form?']];
  $options = new ChatOptions(model: Model::GROK_2, temperature: 1.2, stream: false);
  $response = $this->client->chat($messages, $options);
  $message = new ChatMessage('user', (string) $response['choices'][0]['message']['content']);
  return new ChatOutput($message, $response['choices'][0]['message']['content'], []);
}
```

The method **ignores `$input` and `$model_id`**: it always sends the fixed prompt "How do black holes
form?" with `model: GROK_2`, `temperature: 1.2`, no streaming, and returns the model's answer as a
`ChatMessage` (with role forced to `user`). To make it functional you would normalize `$input`
(system role + `getMessages()`), map `$model_id`, and thread through `definitions/api_defaults.yml`
options — mirroring what `ai_provider_x`'s `XProvider::chat()` does.
