<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `media_directories_ai.settings`

Form `Drupal\media_directories_ai\Form\AiSettingsForm` (form id `media_directories_ai_settings_form`),
route `media_directories_ai.config_form` → **`/admin/config/media/media_directories/ai`**,
permission `administer site configuration`. It appears as the **AI** local task (weight 20)
under the parent module's settings page.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_ai_alt_text` | bool | `false` | Master switch. Also hides the prompt/field settings behind `#states`. |
| `alt_text_prompt` | string | `''` | Prompt sent when generating alt text. Empty ⇒ `AiAltTextService::DEFAULT_PROMPT`. A media-language instruction is appended automatically. |
| `ai_translation_types` | sequence of strings | `[]` | Media type ids for which AI translation is offered. |
| `translation_prompt` | string | `''` | Prompt used for translation. Empty ⇒ `AiTranslationService::DEFAULT_PROMPT` — *"Translate text accurately while preserving the original meaning, tone, and formatting."* |
| `ai_fillable_fields` | map bundle → list of field names | `{}` | Which text-bearing fields show an **AI fill** button in the upload/edit/bulk forms. Field names use the browser's `field:property` notation (e.g. `field_media_image:alt`). |
| `ai_translatable_fields` | map bundle → list of field names | `{}` | Which fields are included when AI-translating a media item. |

`AiAltTextService::DEFAULT_PROMPT` is:

> Write concise, descriptive alt text for this image in 1-2 sentences. Describe the key
> visual content and context. Do not include phrases like "Image of" or "Photo of". Return
> only the alt text, nothing else.

Schema: `config/schema/media_directories_ai.schema.yml`; defaults ship in
`config/install/media_directories_ai.settings.yml`.

`media_directories_ai_update_11001()` seeds the two field maps from
`MediaTypeService::getMediaTypes()`: every `*:alt` field becomes `ai_fillable_fields`, and
every translatable field of type `string`, `string_long`, `text`, `text_long` or
`text_with_summary` becomes `ai_translatable_fields`.

## Drush

```bash
drush cget media_directories_ai.settings

drush cset media_directories_ai.settings enable_ai_alt_text 1 -y
drush cset media_directories_ai.settings alt_text_prompt 'Describe this product photo in one sentence for an online shop.' -y

# Sequences/maps need php:eval.
drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("ai_translation_types", ["image", "document"])
    ->set("ai_fillable_fields", ["image" => ["field_media_image:alt"]])
    ->set("ai_translatable_fields", ["image" => ["name", "field_media_image:alt"]])
    ->save();'
```

## Prerequisite: an AI provider

Alt text is only offered when **both** of these hold:

```php
\Drupal::config('media_directories_ai.settings')->get('enable_ai_alt_text')   // TRUE
&& $provider_manager->getDefaultProviderForOperationType('chat_with_image_vision')
     has a non-empty provider_id AND model_id
```

Check it live:

```bash
drush php:eval '
  print "available: " . var_export(\Drupal::service("media_directories_ai.alt_text")->isAvailable(), TRUE) . "\n";
  print json_encode(\Drupal::service("ai.provider")->getDefaultProviderForOperationType("chat_with_image_vision")) . "\n";'
```

Configure the provider/key/default model on the `ai` module's own admin pages
(`/admin/config/ai/...`) — this submodule never stores credentials.

## How the UI learns about it

`MediaDirectoriesAiHooks::pageAttachmentsAlter()` (`#[Hook('page_attachments_alter')]`)
rewrites the settings the browser module published:

```php
$settings['enableAiAltText'] = $alt_text_service->isAvailable();
foreach ($settings['mediaTypeTranslationSettings'] as $type_id => &$type_settings) {
  $type_settings['enableAiTranslations'] = in_array($type_id, $ai_translation_types);
}
```

`media_directories_browser` deliberately publishes both as `FALSE`, so *"the AI buttons do
not appear"* almost always means `isAvailable()` returned FALSE (switch off, or no vision
provider) rather than a JS problem.
