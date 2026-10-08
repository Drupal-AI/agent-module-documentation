<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI provider plugin `chat_translation_plus`

`src/Plugin/AiProvider/ChatTranslationPlusProvider.php` —
`#[AiProvider(id: 'chat_translation_plus', label: 'Chat proxy to LLM (using Plus Settings)')]`,
extends `Drupal\ai_translate\Plugin\AiProvider\ChatTranslationProvider`. Select it as AI Translate's
translation provider to enable contextual prompts/models. `create()` adds the `token` service and
`ai_translate_plus.translation_context` (the request-scoped context service).

## `translateText(TranslateTextInput $input, string $model_id, array $options)`

1. Loads the target `configurable_language`; if missing, logs a warning and returns an empty
   `TranslateTextOutput`.
2. **Model resolution** — `getCustomModel($lang_to)`: if context is present, reads the
   `ai_translate_plus_settings` entity for the context's entity type and picks the model
   most-specific-first: `bundle_models[bundle][lang]` → `bundle_default_models[bundle]` →
   `entity_type_models[lang]` → `entity_type_default_model`. A custom model is split via
   `loadProviderFromSimpleOption()` / `getModelNameFromSimpleOption()`; on failure it logs and falls
   back to the passed `$model_id`.
3. **Prompt resolution** — `getPromptForTranslation($lang_to)` → `getCustomPrompt(entity_type,
   bundle, lang, entity)`: same specificity order over `bundle_prompts` → `bundle_default_prompts` →
   `entity_type_prompts` → `entity_type_default_prompt`; loads the `ai` `AiPrompt` entity and, if the
   prompt text contains `[`, runs Core **`token->replace($prompt, [entity_type => entity],
   ['clear' => TRUE])`**. Falls back to `ai_translate.settings` `<lang>_prompt` / `prompt`, else a
   built-in default string.
4. **Placeholder + Twig rendering** — builds `$replacements` for `{destLang}`, `{destLangName}`,
   `{inputText}`, and (if the source language loads) `{sourceLang}` / `{sourceLangName}`; loads the
   context entity into `$twigContext[$entity_type_id]`; renders the prompt with
   `twig->renderInline($prompt, $twigContext)` then applies `strtr(..., $replacements)`. The user's
   source text is injected only via the `{inputText}` placeholder replacement done **after** Twig
   rendering (it is not part of the Twig template source).
5. **Chat call** — wraps the rendered prompt as a `ChatInput` user message with system prompt "You
   are a helpful translator.", calls `loadTranslator()` then `realTranslator->chat(...)`. Returns
   `TranslateTextOutput(normalizedText, rawOutput, [])`. `GuzzleException` is logged and yields an
   empty output.

`loadTranslator(ChatInput $messages)`: if a custom provider id was resolved it builds a chat config,
fires the `ai_translate_translation` alter hook, and creates the provider instance via the AI
provider manager; otherwise it defers to `parent::loadTranslator()`.

## Context source

The provider does not receive the entity directly. `TextTranslatorDecorator` stores the context in
`TranslationContextService` before each `translateContent()` call; the provider reads it via
`getContext()` / `hasContext()`. See [../api/decorators.md](../api/decorators.md).
