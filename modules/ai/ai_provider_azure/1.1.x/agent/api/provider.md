# Provider API

This is an **AI-module provider**, not a standalone API. You call it through the AI module's
provider service, never directly.

## Plugin identity

- `#[AiProvider(id: 'azure', label: new TranslatableMarkup('Azure'))]`
- `class AzureProvider extends AiProviderClientBase implements ChatInterface, EmbeddingsInterface,
  TextToImageInterface, SpeechToTextInterface, TextToSpeechInterface` (uses `ChatTrait`).

## Capabilities & operation types

```php
getSupportedOperationTypes() // ['chat','embeddings','text_to_image','speech_to_text','text_to_speech']
getSupportedCapabilities()   // [AiProviderCapability::StreamChatOutput]
isUsable($op)                // TRUE if $op is in the supported list
maxEmbeddingsInput()         // 8191
canOverrideConfiguration()   // TRUE
```

`hasPredefinedModels = FALSE` — models must be configured (see
[configure/setup.md](../configure/setup.md)); `getConfig()` returns `ai_provider_azure.settings`.

## Calling it via the AI module

```php
/** @var \Drupal\ai\AiProviderPluginManager $pm */
$pm = \Drupal::service('ai.provider');
$azure = $pm->createInstance('azure');           // or $pm->getDefaultProviderForOperationType('chat')

// Chat (model id = your configured Azure model / deployment id):
$messages = new \Drupal\ai\OperationType\Chat\ChatInput([
  new \Drupal\ai\OperationType\Chat\ChatMessage('user', 'Hello'),
]);
$output = $azure->chat($messages, 'my-azure-gpt-deployment');
$text = $output->getNormalized()->getText();
```

Other entry points mirror the interfaces: `embeddings($input, $model_id)`,
`textToImage($prompt, $model_id)`, `speechToText($binary, $model_id)`,
`textToSpeech($text, $model_id)`. Each builds a payload and calls the `openai-php` client.

## How a request is built (internals)

- `getClient($op, $modelInfo)` → `setAuthentication(loadAzureApiKey($model['api_key']))` (loads the
  value from the **Key** entity) → `loadClient()`.
- `loadClient()` uses `createVariablesFromEndpoint()` to split the configured **endpoint** into a
  base URI + query params based on the operation's path fragment
  (`chat/completions`, `embeddings`, `images/generations`, `audio/translations`, `audio/speech`),
  sets the auth header per `connect_header` (`api-key` default, or the custom one), applies any
  `extra_headers` (token-replaced), and instantiates either `\OpenAI::factory()` or
  `LightweightProviderClient` (when `custom_consumer` is set).
- `chat()` normalises `ChatInput` → OpenAI `messages`, merges `$this->configuration`, supports tools
  (`getChatTools()`) and structured `response_format` (`getChatStructuredJsonSchema()`), and streams
  via `AzureChatMessageIterator` when streamed.
- Errors are mapped: "Request too large" → `AiRateLimitException`, "You exceeded your current quota"
  → `AiQuotaException`; a missing/empty Key throws `AiSetupFailureException`.

## Extending

There is no plugin type or hook to implement here. To add another Azure-like backend, configure
another model/endpoint, or (for a different vendor) implement your own `#[AiProvider]` plugin in the
AI module — this module is one such implementation to model yours on.
