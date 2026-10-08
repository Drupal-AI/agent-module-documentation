# AI Translate — services, routes & access

## Services (`ai_translate.services.yml`)

| Service ID | Class | Purpose |
|---|---|---|
| `ai_translate.text_translator` | `TextTranslator` | Translate a string via the AI provider (with optional result caching). |
| `ai_translate.text_extractor` | `TextExtractor` | Pull translatable text out of / back into an entity using the extractor plugins. |
| `ai_translate.translation_orchestrator` | `EntityTranslationOrchestrator` | Shared workflow: access check, extract, translate each field, save the translation. Autowired. |
| `plugin.manager.text_extractor` | `FieldTextExtractorPluginManager` | Manager for the `text_extractor` plugin type. |
| `ai_translate.subscriber` | `AiTranslateRouteSubscriber` | Swaps the core content-translation controller when `use_ai_translate` is on. |
| `cache.ai_translate` | (cache bin) | Dedicated cache bin backing the optional translation cache (`cache_ai_translate` table). |

Interfaces are aliased to the services (`TextTranslatorInterface`, `TextExtractorInterface`,
`EntityTranslationOrchestratorInterface`) for dependency injection / autowiring.

### `EntityTranslationOrchestrator` (new in 1.4.x)

Centralises the translation workflow that the route controller, the AI function call, the Tool plugin,
and Drush all reuse.

- `checkTranslateAccess(ContentEntityInterface $entity, AccountInterface $account, string $langTo): AccessResultInterface`
  — the single access gate. Requires **all** of:
  1. `create ai content translation` permission,
  2. `$entity->isTranslatable()`,
  3. a `translation` handler for the entity type,
  4. `$entity->access('update', $account, TRUE)`,
  5. `$translationHandler->getTranslationAccess($entity, 'create')`.
- `resolveSourceEntity($entity, $langFrom)` — returns the source-language translation if present.
- `extractTextMetadata($entity)` — delegates to the text extractor.
- `translateTextMetadataItem($singleField, $langFrom, $langTo)` — translates each `_columns` value,
  `html_entity_decode()`s the result; returns `NULL` on `TranslationException`.
- `saveTranslatedEntity($entity, $langTo, $processed, $failures)` — `addTranslation()` + save, applies
  publish/moderation status (see `translation_status`), returns an `EntityTranslationResult`.
- `translateEntity($entity, $langFrom, $langTo): EntityTranslationResult` — the whole flow end to end
  (used by Drush, the function call, and the Tool plugin). **Note:** this method performs extract →
  translate → save but does *not* itself call `checkTranslateAccess()`; callers are responsible for the
  access check first (the controller, function call, and Tool plugin all do; Drush runs with CLI trust).

`EntityTranslationResult` is a value object: `success()`, `existing()`, `failure()` factories, plus
`isSuccess()`, `translationExists()`, `getTranslatedEntity()`, `getMessage()`, `getFailures()`.

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
`ai_translate`).

**Caching (new in 1.4.x):** when `ai_translate.settings:cache_translations` is on, a successful
translation is stored in the `cache.ai_translate` bin and reused next time the same text is translated
by the same provider+model into the same language. The cache ID is
`ai_translate:<provider>:<model>[:<chat_provider>:<chat_model>]:<from|auto>:<to>:sha256(text)` — the
chat provider/model are appended when the resolved provider is this module's `chat_translation` proxy
(which discards the passed model and runs the default chat model). Cache entries are tagged
`config:ai_translate.settings` plus `config:ai.ai_prompt.<promptId>` for the active default and
language prompts, so editing a prompt or the settings drops affected entries. Empty results are not
cached; read/write failures are logged and fall through to a live translation.

### `TextExtractor`

- `extractTextMetadata(ContentEntityInterface $entity): array` — per-field metadata (each has `_columns`
  plus the raw field values) for translatable fields.
- `insertTextMetadata(ContentEntityInterface $translation, array $processed): void` — writes translated
  values back into the translation entity via the matching extractor plugin.

## Routes (`ai_translate.routing.yml`)

| Route | Path | Access | Notes |
|---|---|---|---|
| `ai_translate.settings_form` | `/admin/config/ai/ai-translate` | `_permission: manage ai translation prompts` | Settings form. |
| `ai_translate.translate_content` | `/ai_translate/translate/{entity_type}/{entity_id}/{lang_from}/{lang_to}` | `_csrf_token: 'TRUE'` + `_custom_access: AiTranslateController::checkAccess` | Runs a Batch, then redirects to the translation overview (or the new translation's edit form per `redirect_after_create`). |
| `ai_translate.translate_interface` | `/admin/ai-translate/interface-translate-callback` | `_permission: create ai interface translation` | AJAX callback; reads `string_row_id`, `string_row_key`, `langcode` query params, returns a `ReplaceCommand` with the translated locale textarea. `_admin_route: TRUE`. |

`AiTranslateController::checkAccess()` loads the entity, returns `AccessResult::forbidden()` for an
unknown entity type, a non-content entity, or a language the entity already has a translation in, and
otherwise defers to `EntityTranslationOrchestrator::checkTranslateAccess()`. The "AI translate" links
in the overriding overview controller are only rendered when `$link->getUrl()->access()` passes, so the
column is hidden for languages/entities the user cannot translate.

The content-translate flow (`AiTranslateController::translate`) builds a `BatchBuilder` with one
`translateSingleField` op per extracted field plus a final `insertTranslation` op that calls
`saveTranslatedEntity()`. Only **new** translations are created; a language the entity already has is
skipped (`@todo` note in source about updating existing translations).
