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

## Translate text (new in 1.4.x)

The provider implements `TranslateTextInterface` — translation is done by prompting a chat
model, so `$model_id` is a chat model (e.g. `'chat'`).

```php
$provider = $manager->createInstance('amazeeio');
$input = new \Drupal\ai\OperationType\TranslateText\TranslateTextInput('Bonjour', 'fr', 'en');
$out = $provider->translateText($input, 'chat', ['my_module']);
$translated = $out->getNormalized();
```

## Text to image (new in 1.4.x)

```php
$provider = $manager->createInstance('amazeeio');
$input = new \Drupal\ai\OperationType\TextToImage\TextToImageInput('A beautiful sunset over the city.');
$response = $provider->textToImage($input, $model_id, ['my_module']); // $model_id = an image-generation model
```

## Supported operation types

`chat`, `chat_with_complex_json`, `chat_with_image_vision`, `chat_with_structured_response`,
`chat_with_tools`, `embeddings`, `text_to_image`, `translate_text`
(`getSupportedOperationTypes()`). Capabilities: `StreamChatOutput`, `ChatFiberSupport`.

## Listing models

```php
$provider = \Drupal::service('ai.provider')->createInstance('amazeeio');
$chat_models = $provider->getConfiguredModels('chat');       // cached ~24h
$embed_models = $provider->getConfiguredModels('embeddings');
$image_models = $provider->getConfiguredModels('text_to_image');
```

## Errors

- Gateway budget/quota error → `\Drupal\ai\Exception\AiQuotaException` (via
  `handleApiException()`). On the anonymous free trial the message links to
  `/admin/config/ai/providers/amazeeio` to upgrade.
- Gateway rate-limit error → `\Drupal\ai\Exception\AiRateLimitException`.
- Setup/auth failures (missing/invalid key at `loadClient()`) →
  `\Drupal\ai\Exception\AiSetupFailureException`.

## Note on live calls

Chat/embeddings/image/translate actually hit amazee.ai's gateway and require a provisioned key
(`amazeeio_ai` Key populated via the settings form / trial). Without credentials the calls
fail at `loadClient()` — configuration and model wiring can still be inspected without a key.
