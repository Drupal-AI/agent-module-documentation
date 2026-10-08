# Calling Anthropic (Claude) from code

You never instantiate this provider or an Anthropic SDK directly. Go through AI Core's
`ai.provider` manager so the vendor stays config-driven. This module just supplies the
`anthropic` provider id and the `chat` implementation.

## Use the site default (recommended)

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');

$defaults = $manager->getDefaultProviderForOperationType('chat'); // NULL if none set
if (!$defaults) { return; } // tell user to configure /admin/config/ai/settings

/** @var \Drupal\ai\OperationType\Chat\ChatInterface $provider */
$provider = $manager->createInstance($defaults['provider_id']);    // 'anthropic' if it's default

use Drupal\ai\OperationType\Chat\ChatInput;
use Drupal\ai\OperationType\Chat\ChatMessage;

$output = $provider->chat(new ChatInput([
  new ChatMessage('system', 'You are terse.'),
  new ChatMessage('user', 'Name three primary colors.'),
]), $defaults['model_id'], ['my_module']);

$text = $output->getNormalized()->getText();
```

## Force Anthropic explicitly

```php
$provider = $manager->createInstance('anthropic');
$out = $provider->chat($input, 'claude-sonnet-4-5-20250929', ['my_module']);
```

## Listing available models

```php
$provider = $manager->createInstance('anthropic');
$models = $provider->getConfiguredModels('chat');            // [id => display_name], live + cached
// JSON-output-capable only:
use Drupal\ai\Enum\AiModelCapability;
$json = $provider->getConfiguredModels('chat', [AiModelCapability::ChatJsonOutput]);
$provider->clearModelsCache();                               // force a fresh fetch next time
```

## Notes & gotchas

- **Chat only.** `getSupportedOperationTypes()` returns just `['chat']` — there is no
  `embeddings`, `moderation`, `text_to_image`, `text_to_speech`, or `speech_to_text` here.
- **top_p + temperature:** for Claude 4.x+ models the provider drops `top_p` automatically
  (Anthropic rejects both together) — don't rely on setting both.
- **Moderation:** not native; wire it via the AI External Moderation module + OpenAI (config
  flag `openai_moderation`). See [../configure/settings.md](../configure/settings.md).
- **Custom endpoint:** set `ai_provider_anthropic.settings.host` to route through a proxy /
  compatible host; empty = `https://api.anthropic.com/v1`.

## Exceptions to catch

`Drupal\ai\Exception\AiQuotaException` (low credit balance),
`AiRateLimitException`, `AiResponseErrorException`, `AiSetupFailureException` — all in
`Drupal\ai\Exception\`.
