<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, services and hooks

## Routes

All three API routes are **POST**, sit under the browser's API prefix, require the browser's
permission `access media directories browser`, and allow `_auth: [basic_auth, cookie]`.
Controller: `Drupal\media_directories_ai\Controller\AiApiController`.

| Route | Path | Method |
|---|---|---|
| `media_directories_ai.api.alt_text` | `/api/media-directories-browser/ai/alt-text` | `generateAltText(Request)` |
| `media_directories_ai.api.alt_text_from_file` | `/api/media-directories-browser/ai/alt-text-from-file` | `generateAltTextFromFile(Request)` |
| `media_directories_ai.api.translate` | `/api/media-directories-browser/ai/translate` | `aiTranslate(Request)` |
| `media_directories_ai.config_form` | `/admin/config/media/media_directories/ai` | settings form, `administer site configuration` |

`alt-text` takes an existing media **UUID**; `alt-text-from-file` takes the raw binary plus a
MIME type, which is what the browser uses *during upload*, before a media entity exists.

## Services

```yaml
media_directories_ai.alt_text:
  class: Drupal\media_directories_ai\Service\AiAltTextService
  arguments: ['@entity_type.manager', '@config.factory', '@language_manager', '@?ai.provider']

media_directories_ai.translation:
  class: Drupal\media_directories_ai\Service\AiTranslationService
  arguments: ['@config.factory', '@language_manager', '@?ai.provider']
```

The `@?` prefix means the provider manager is optional — the services are constructible even
if `ai` is not providing that service, and `isAvailable()` simply returns FALSE.

### `AiAltTextService`

| Member | Notes |
|---|---|
| `const MAX_IMAGE_DIMENSION = 1280` | images are downscaled to this before being sent |
| `const DEFAULT_PROMPT` | used when `alt_text_prompt` is empty |
| `isAvailable(): bool` | `enable_ai_alt_text` **and** a default provider for `chat_with_image_vision` with non-empty `provider_id` **and** `model_id` |
| `generateAltText(string $uuid): string` | loads the media, throws `\InvalidArgumentException` if not found / not an image, `\RuntimeException` on provider failure |
| `generateAltTextFromBinary(string $binary, string $mime_type, string $langcode = 'en'): string` | the pre-save path |

### `AiTranslationService`

| Member | Notes |
|---|---|
| `const DEFAULT_PROMPT` | *"Translate text accurately while preserving the original meaning, tone, and formatting."* |
| `isAvailable(): bool` | provider manager present and usable |
| `translateFields(array $field_values, string $target_langcode, ?string $source_langcode = NULL): array` | returns the translated map |

```php
$alt = \Drupal::service('media_directories_ai.alt_text')->generateAltText($media->uuid());

$translated = \Drupal::service('media_directories_ai.translation')
  ->translateFields(['name' => 'Spring campaign'], 'de', 'en');
```

## Hooks

One implementation, in `Drupal\media_directories_ai\Hook\MediaDirectoriesAiHooks`
(autowired via `media_directories_ai.services.yml`, with a `#[LegacyHook]` wrapper in
`media_directories_ai.module`):

`#[Hook('page_attachments_alter')] pageAttachmentsAlter(array &$attachments)` — returns
early unless `drupalSettings.mediaDirectoriesBrowser` is present, then sets
`enableAiAltText` from `AiAltTextService::isAvailable()` and, for each entry of
`mediaTypeTranslationSettings`, `enableAiTranslations` from whether the bundle is in
`ai_translation_types`.

No `*.api.php`, no plugin types, no permissions, no Drush commands, no templates.

## Debugging checklist

```bash
# 1. Is the feature switched on and is a vision provider configured?
drush php:eval 'print var_export(\Drupal::service("media_directories_ai.alt_text")->isAvailable(), TRUE);'

# 2. What ends up in drupalSettings?
drush php:eval '
  $a = [];
  \Drupal::service("Drupal\media_directories_browser\Hook\MediaDirectoriesBrowserHooks")->pageAttachments($a);
  \Drupal\media_directories_ai\Hook\MediaDirectoriesAiHooks::pageAttachmentsAlter($a);
  $s = $a["#attached"]["drupalSettings"]["mediaDirectoriesBrowser"];
  print json_encode(["enableAiAltText" => $s["enableAiAltText"], "types" => $s["mediaTypeTranslationSettings"]], JSON_PRETTY_PRINT);'

# 3. Which media types are enabled for AI translation?
drush cget media_directories_ai.settings ai_translation_types
```
