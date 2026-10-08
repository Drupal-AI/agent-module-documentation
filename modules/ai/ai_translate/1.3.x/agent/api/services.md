# AI Translate — services & routes

## Services (`ai_translate.services.yml`)

| Service ID | Class | Purpose |
|---|---|---|
| `ai_translate.text_translator` | `TextTranslator` | Translate a string via the AI provider. |
| `ai_translate.text_extractor` | `TextExtractor` | Pull translatable text out of / back into an entity using the extractor plugins. |
| `plugin.manager.text_extractor` | `FieldTextExtractorPluginManager` | Manager for the `text_extractor` plugin type. |
| `ai_translate.subscriber` | `AiTranslateRouteSubscriber` | Swaps the core content-translation controller when `use_ai_translate` is on. |

### `TextTranslator::translateContent()`

```php
public function translateContent(
  string $input_text,
  \Drupal\Core\Language\LanguageInterface $langTo,
  ?\Drupal\Core\Language\LanguageInterface $langFrom = NULL,
  array $context = [],
): string
```

Uses `ai.provider`'s default provider for operation type `translate_text` and its configured
`model_id`. Strips ```` ```html ```` / ``` ``` ``` fences and surrounding quotes from the LLM output.
Throws `\Drupal\ai_translate\TranslationException` on any provider error (also logged to channel
`ai_translate`). Example:

```php
$t = \Drupal::service('ai_translate.text_translator');
$lm = \Drupal::languageManager();
$french = $t->translateContent('Hello world', $lm->getLanguage('fr'));
```

### `TextExtractor`

- `extractTextMetadata(ContentEntityInterface $entity): array` — array of per-field metadata
  (each has `_columns` plus the raw field values) for translatable fields.
- `insertTextMetadata(ContentEntityInterface $translation, array $processed): void` — writes
  translated values back into the translation entity via the matching extractor plugin.

## Routes (`ai_translate.routing.yml`)

| Route | Path | Permission | Notes |
|---|---|---|---|
| `ai_translate.settings_form` | `/admin/config/ai/ai-translate` | `manage ai translation prompts` | Settings form. |
| `ai_translate.translate_content` | `/ai_translate/translate/{entity_type}/{entity_id}/{lang_from}/{lang_to}` | `create ai content translation` | GET; runs a Batch, then redirects. |
| `ai_translate.translate_interface` | `/admin/ai-translate/interface-translate-callback` | `create ai interface translation` | AJAX callback; reads `string_row_id`, `string_row_key`, `langcode` query params, returns a `ReplaceCommand` with the translated locale textarea. |

The content-translate flow (`AiTranslateController::translate`) builds a `BatchBuilder` with one
`translateSingleField` op per extracted field plus a final `insertTranslation` op that calls
`addTranslation()` and saves. `html_entity_decode()` is applied to each translated value before saving.
