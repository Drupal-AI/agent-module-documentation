# Call amazee.ai from code

You never instantiate the amazee.ai client directly. Go through AI Core's `ai.provider`
service (`\Drupal\ai\AiProviderPluginManager`) so the provider/model is config-driven and
swappable.

## Chat

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');

// Either resolve the site default for the operation type...
$provider = $manager->getDefaultProviderForOperationType('chat');
// ...or force amazee.ai explicitly:
// $provider = $manager->createInstance('amazeeio');

$input = new \Drupal\ai\OperationType\Chat\ChatInput([
  new \Drupal\ai\OperationType\Chat\ChatMessage('system', 'You are a helpful assistant.'),
  new \Drupal\ai\OperationType\Chat\ChatMessage('user', 'Introduce yourself!'),
]);

// $model_id comes from the provider's configured models (e.g. 'chat'); $tags are cache/telemetry tags.
$response = $provider->chat($input, 'chat', ['my_module']);
$text = $response->getNormalized()->getText();
```

When you used `getDefaultProviderForOperationType()`, pass the returned model id from
`$manager->getDefaultProviderModel('chat')` (or read `ai.settings` `default_providers.chat`)
rather than hard-coding `'chat'`.

## Embeddings

```php
$provider = $manager->createInstance('amazeeio');
$input = new \Drupal\ai\OperationType\Embeddings\EmbeddingsInput('Some text to embed.');
$response = $provider->embeddings($input, 'embeddings', ['my_module']);
$vector = $response->getNormalized()->getEmbedding();
```

## Supported operation types

`chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`,
`chat_with_tools`, `embeddings` (`getSupportedOperationTypes()`). Capabilities:
`StreamChatOutput`, `ChatFiberSupport`.

## Listing models

```php
$provider = \Drupal::service('ai.provider')->createInstance('amazeeio');
$chat_models = $provider->getConfiguredModels('chat');       // cached ~24h
$embed_models = $provider->getConfiguredModels('embeddings');
```

## Errors

A gateway budget/quota error surfaces as `\Drupal\ai\Exception\AiQuotaException` (via
`handleApiException()`). On the anonymous free trial the exception message links to
`/admin/config/ai/providers/amazeeio` to upgrade. Setup/auth failures throw
`\Drupal\ai\Exception\AiSetupFailureException`.

## Note on live calls

Chat/embeddings actually hit amazee.ai's gateway and require a provisioned key
(`amazeeio_ai` Key populated via the settings form / trial). Without credentials the calls
fail at `loadClient()` — configuration and model wiring can still be inspected without a key.
