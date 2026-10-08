# API — generate route, provider helper, AI Core call

## Provider resolution — `ai_image_alt_text.provider`

Service id `ai_image_alt_text.provider`, class `Drupal\ai_image_alt_text\ProviderHelper`
(args: `@config.factory`, `@ai.provider`). One public method:

```php
/** @var array|null $data */
$data = \Drupal::service('ai_image_alt_text.provider')->getSetProvider();
// $data === NULL  → no provider configured (button/route bail out)
// else            → ['provider_id' => <instantiated provider>, 'model_id' => <string>]
```

Logic:
- If `ai_image_alt_text.settings:ai_model` is set, it loads that provider/model via
  `AiProviderPluginManager::loadProviderFromSimpleOption()` +
  `getModelNameFromSimpleOption()`.
- Otherwise it asks AI Core for the default provider of the **`chat_with_image_vision`**
  operation type (`getDefaultProviderForOperationType('chat_with_image_vision')`) and
  `createInstance()`s it. Returns `NULL` if none is set.

Note `provider_id` in the returned array is the **instantiated provider object**, ready to
call `->chat(...)` on.

## Generate route — `ai_image_alt_text.generate`

`GET /admin/config/ai/ai_image_alt_text/generate/{file}/{lang_code}`
(permission `generate ai alt tags`; `{file}` is an `entity:file`). Controller
`Drupal\ai_image_alt_text\Controller\GenerateAltText::generate`. Returns a `JsonResponse`
with either `{"alt_text": "..."}` or `{"error": "..."}` (403 no file access, 400 not an
image, 500 no provider / AI exception). The JS on the widget calls this and drops the result
into the alt field.

## How the AI Core chat call is built

Inside the controller (this is the pattern to reuse if calling AI Core with an image):

```php
use Drupal\ai\OperationType\Chat\ChatInput;
use Drupal\ai\OperationType\Chat\ChatMessage;
use Drupal\ai\OperationType\GenericType\ImageFile;

// 1. Prepare the image (optionally through an image style derivative).
$image = new ImageFile();
$image->setBinary(file_get_contents($scaled_image_uri)); // or ->setFileFromFile($file)
$image->setMimeType($mime_type);
$image->setFilename($name);

// 2. Render the prompt (Twig) with the entity language + filename.
$prompt_text = \Drupal::service('twig')->renderInline($prompt, [
  'entity_lang_name' => $languageName,
  'filename' => $file->getFilename(),
]);

// 3. Build a ChatInput whose user message carries the image(s).
$input = new ChatInput([
  new ChatMessage('user', (string) $prompt_text, [$image]),
]);

// 4. Send through the resolved provider and read the normalized text.
$output = $provider->chat($input, $model_id);
$alt_text = $output->getNormalized()->getText();
```

Key point: the image is attached as the **third argument** (`$images`) of `ChatMessage`, and
the operation used is AI Core's **chat** operation with a vision-capable model — see AI Core
`agent/api/ai.md`.

## Not provided

No Drush commands, no plugin types, no hooks for others to implement. The only extension
point is swapping the AI provider/model (via config) or the image style used for
preprocessing.
