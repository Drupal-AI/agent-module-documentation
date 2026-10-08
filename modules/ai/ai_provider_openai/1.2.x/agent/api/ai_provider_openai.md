# Calling OpenAI from code

You never instantiate this provider or the OpenAI SDK directly. Go through AI Core's
`ai.provider` manager so the vendor stays config-driven. This module just supplies the
`openai` provider id and the operation implementations.

## Use the site default (recommended)

```php
/** @var \Drupal\ai\AiProviderPluginManager $manager */
$manager = \Drupal::service('ai.provider');

$defaults = $manager->getDefaultProviderForOperationType('chat'); // NULL if none set
if (!$defaults) { return; } // tell user to configure /admin/config/ai/settings

/** @var \Drupal\ai\OperationType\Chat\ChatInterface $provider */
$provider = $manager->createInstance($defaults['provider_id']);    // 'openai' if it's default

use Drupal\ai\OperationType\Chat\ChatInput;
use Drupal\ai\OperationType\Chat\ChatMessage;

$output = $provider->chat(new ChatInput([
  new ChatMessage('system', 'You are terse.'),
  new ChatMessage('user', 'Name three primary colors.'),
]), $defaults['model_id'], ['my_module']);

$text = $output->getNormalized()->getText();
```

## Force OpenAI explicitly

```php
$provider = $manager->createInstance('openai');
$out = $provider->chat($input, 'gpt-4.1', ['my_module']);
```

## Other operations (same provider object)

```php
// Embeddings — vector + dimension.
$vec  = $provider->embeddings('some text', 'text-embedding-3-small')->getNormalized();
$size = $provider->embeddingsVectorSize('text-embedding-3-small'); // 1536

// Moderation — check text safety directly.
$mod = $provider->moderation('text to check', 'omni-moderation-latest')->getNormalized();
// ModerationResponse: ->isFlagged(), category scores.

// Image, speech, transcription.
$img   = $provider->textToImage('a red bicycle', 'gpt-image-1');      // TextToImageOutput (ImageFile[])
$audio = $provider->textToSpeech('Hello there', 'tts-1-hd');          // TextToSpeechOutput (AudioFile)
$text  = $provider->speechToText($binaryAudio, 'whisper-1')->getNormalized(); // string
```

## Moderation control & tags

- The 3rd arg to each method is `$tags` (array). Include `'skip_moderation'` to bypass the
  pre-call moderation check for that request only.
- Persistent toggles: `$provider->enableModeration()` / `$provider->disableModeration()`.
- Config default lives in `ai_provider_openai.settings` → `moderation` (see
  [../configure/settings.md](../configure/settings.md)).

## OpenAI-compatible / Azure host at runtime

The provider reads `ai_provider_openai.settings.host`; you can also set it on an instance via
`$provider->setConfiguration(['host' => 'my-host/v1'])` before the call (as the settings form
does for validation).

## Exceptions to catch

`AiUnsafePromptException` (moderation flagged), `AiRateLimitException`, `AiQuotaException`,
`AiResponseErrorException`, `AiSetupFailureException` — all in `Drupal\ai\Exception\`.
