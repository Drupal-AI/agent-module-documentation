# Configure AI Translate

Config object: `ai_translate.settings` (schema in `config/schema/ai_translate.schema.yml`).
Form: `\Drupal\ai_translate\Form\AiTranslateSettingsForm` at `/admin/config/ai/ai-translate`
(route `ai_translate.settings_form`, permission `manage ai translation prompts`).

## Settings keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_ai_translate` | bool | `true` | When true, AI Translate takes over the core "Translate" tab (route subscriber swaps the controller). Turn off to keep core translation UI and use this only as a back-end framework. Changing it triggers a route rebuild. |
| `cache_translations` | bool | `true` (new installs) | Reuse a previously generated translation when the same text is translated between the same two languages again. Stored results record the provider+model; switching model translates afresh; editing a prompt drops results that used it. See `api/services.md` for the cache ID/tagging. |
| `prompt` | string | `ai_translate__ai_translate_default` | ID of the default `ai.ai_prompt` config entity (constraint: `ConfigExists` prefix `ai.ai_prompt.`). |
| `translation_status` | string | `keep_original` | `keep_original` or `create_draft` (new translation set unpublished + `moderation_state=draft` if the field exists). |
| `redirect_after_create` | string | `list` | `list` (translation overview) or `edit` (edit form of the new translation). |
| `reference_defaults` | sequence | `{}` | Entity type IDs whose referenced entities are translated by default when the host is translated. |
| `entity_reference_depth` | int | `1` | Max recursion depth for reference translation: one of `0` (unlimited), `1`, `2`, `5`, `10`. |
| `language_settings` | map keyed by langcode | `{}` | Per-language override: `model` (AI provider `provider__model` string) and `prompt` (an `ai.ai_prompt` ID). |

### Caching default vs. existing sites

New installs ship `cache_translations: true` (`config/install/ai_translate.settings.yml`). The post-update
`ai_translate_post_update_disable_translation_cache()` sets it **off** on sites updating into 1.4.x, so
nothing changes underneath a running site — opt in from the settings form. A separate post-update
`ai_translate_post_update_convert_ai_prompt()` converts legacy textual prompts to `ai.ai_prompt` config
entities (renaming `{{ source_lang }}` → `{sourceLang}`, etc.).

## Prompts (AI module prompt entities)

- Prompt type `ai_translate` is installed (`ai.ai_prompt_type.ai_translate`) with variables:
  `sourceLang`, `sourceLangName`, `destLang` (not required), `destLangName` (required), `inputText` (required).
- Default prompt entity `ai.ai_prompt.ai_translate__ai_translate_default` ships in `config/install`.
- Prompt text is a Twig template; the settings form validates it renders to at least
  `MINIMAL_PROMPT_LENGTH` = 50 characters after substituting the variables. Source-language variables are
  applied via Twig (`renderInline`), the rest (`{destLangName}`, `{inputText}`) via `strtr`.
- The form field uses the AI module's `#type => 'ai_prompt'` element (`#prompt_types => ['ai_translate']`).

## Where translation actually runs

- `ai_translate.text_translator` calls `ai.provider`'s default provider for operation type
  `translate_text` — so the model/endpoint/API key come from the **AI module** config, not this module.
  If no dedicated translation provider is configured, the bundled `chat_translation` provider
  ("Chat proxy to LLM") runs the translation as a chat operation against the default chat provider/model.
  A per-language `model` here overrides the model selection surfaced in the form
  (`getSimpleProviderModelOptions('chat')`).

## Drush / programmatic config

```php
$c = \Drupal::configFactory()->getEditable('ai_translate.settings');
$c->set('translation_status', 'create_draft')
  ->set('cache_translations', TRUE)
  ->set('entity_reference_depth', 2)
  ->set('language_settings', ['fr' => ['model' => 'openai__gpt-4o', 'prompt' => 'ai_translate__ai_translate_default']])
  ->save();
```
