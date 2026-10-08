<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calling OpenRouter from code

## Preferred: go through AI Core's `ai.provider` service

You almost never reference this module directly. AI Core dispatches to whatever provider/model is
configured, so vendor choice stays config-driven:

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');
// Load the openrouter provider explicitly…
$provider = $manager->createInstance('openrouter');
// …or resolve the site default for an operation type:
// [$provider_id, $model_id] = $manager->getDefaultProviderForOperationType('chat');

$messages = new \Drupal\ai\OperationType\Chat\ChatInput([
  new \Drupal\ai\OperationType\Chat\ChatMessage('user', 'Summarise Drupal in one line.'),
]);
$output = $provider->chat($messages, 'openai/gpt-4o-mini', ['my_module']);
$text = $output->getNormalized()->getText();
```

- **Model ids** are OpenRouter-style `vendor/model` strings (e.g. `openai/gpt-4o-mini`,
  `anthropic/claude-3.5-sonnet`, `google/gemini-2.0-flash-001`, `qwen/qwen3-embedding-8b`).
- **Embeddings:** `$provider->embeddings('text or [texts]', 'openai/text-embedding-3-small')`.
  Pass a `dimensions` value through provider configuration for Matryoshka models.
- **Text-to-image:** `$provider->textToImage('a red bicycle', 'google/gemini-2.5-flash-image')`
  returns a `TextToImageOutput` of `ImageFile`s.
- **Streaming:** request streamed output on the `ChatInput` (or set the provider `streamed` flag);
  iterate the returned `ChatOutput` normalized iterator for `StreamedChatMessage` chunks.
- **Tools & structured output:** attach tools / a JSON schema to the `ChatInput`; the provider maps
  them to OpenRouter's `tools` and `response_format: json_schema`.

## Direct: the client service

For raw calls (rarely needed) the module exposes `ai_provider_openrouter.client`:

```php
/** @var \Drupal\ai_provider_openrouter\Service\OpenRouterClient $client */
$client = \Drupal::service('ai_provider_openrouter.client');
$models = $client->listModels();                 // keyed by model id
$resp   = $client->chatCompletion([              // OpenAI-style payload
  'model' => 'openai/gpt-4o-mini',
  'messages' => [['role' => 'user', 'content' => 'Hi']],
]);
```

The client resolves the API key from the configured **Key** entity at construction time, so you
never handle the secret yourself. Prefer the `ai.provider` route above unless you specifically need
the raw model list or an OpenRouter-only payload feature.

## Permissions

- `administer ai providers` (`restrict access: true`) — required to reach the settings form.
- `use ai provider openrouter` — declared by this module (granted to the administrator role on
  install alongside the admin permission); note the settings route is gated only by
  `administer ai providers`.
