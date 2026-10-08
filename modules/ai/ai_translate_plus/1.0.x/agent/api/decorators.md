<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service decorators & translation context

Wiring: `ai_translate_plus.services.yml` (autowire/autoconfigure on). Two decorators (priority 100)
and one plain service carry per-entity context from extraction through translation into the AI
provider.

## `TranslationContextService`

`src/Service/TranslationContextService.php` (service `ai_translate_plus.translation_context`). A
simple in-memory holder: `setContext(array)`, `getContext()`, `clearContext()`, and `hasContext()`
(TRUE only when `entity_type_id`, `bundle` and `lang_to` are all set). It is request-scoped state,
not persisted.

## `TextExtractorDecorator` — decorates `ai_translate.text_extractor`

`src/Decorator/TextExtractorDecorator.php` (`decoration_priority: 100`), implements
`ai_translate\TextExtractorInterface`, wraps `@.inner` plus `config.factory` and
`entity_type.manager`.

`extractTextMetadata($entity, $parents)`:

1. Calls the inner extractor.
2. Loads the `ai_translate_plus_settings` entity for `$entity->getEntityTypeId()`; reads
   `getDisabledFields()[$bundle]`. Any failure is swallowed (translation continues unfiltered).
3. **Filters out** metadata items whose `field_name` is in the bundle's disabled list.
4. Attaches `ai_translate_plus_context` (`entity_type_id`, `bundle`, `entity_id`) to **every**
   remaining metadata item, so downstream code knows which entity is being translated.

`insertTextMetadata()` delegates unchanged; `getInner()` exposes the wrapped service.

## `TextTranslatorDecorator` — decorates `ai_translate.text_translator`

`src/Decorator/TextTranslatorDecorator.php` (`decoration_priority: 100`), implements
`TextTranslatorInterface`, wraps `@.inner` plus `TranslationContextService`.

`translateContent($input_text, $langTo, $langFrom, $context)`: if `$context` carries
`entity_type_id` + `bundle` + `lang_to`, it calls `contextService->setContext($context)`, then
delegates to the inner translator, and **always clears** the context afterward (in a `finally`-style
try/catch, including on exception). This is how the `chat_translation_plus` provider later reads the
active entity context.

## Controller override — carrying context through the batch

`src/Controller/AiTranslateController.php` extends AI Translate's controller and overrides
**`translateSingleField()`**. When a field's metadata contains `ai_translate_plus_context`, it
builds a `$translationContext` (`entity_type_id`, `bundle`, `entity_id`, `lang_to`, `field_name`,
`field_type`) and passes it as the 4th arg to `aiTranslator->translateContent(...)`. After
translation it runs `html_entity_decode()` on each result (the source comment notes StringFormatter/
Markup sanitation applies downstream) and stores the field under `results.processedTranslations`.
The route `ai_translate.translate_content` is repointed to this controller in
`ai_translate_plus.routing.yml` (still `_permission: administer ai translate`).

## Flow summary

`extract` (attach context, drop disabled fields) → `translateSingleField` (build context) →
`TextTranslatorDecorator` (stash context) → `ChatTranslationPlusProvider` (read context, resolve
prompt/model, render, call LLM) → decoder clears context.
