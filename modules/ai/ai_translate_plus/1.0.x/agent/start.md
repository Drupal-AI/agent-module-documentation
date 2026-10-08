<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Translate Plus (ai_translate_plus) — agent index

Extends the **AI Translate** submodule of Drupal AI so translation **prompts and models vary per
entity type / bundle / target language**, with Core **token** replacement and **Twig** context from
the translated entity, and **per-field translation exclusions**. Version **1.0.0-beta1**. Core `^11`.
License GPL-2.0-or-later. Package `AI`.

Dependencies: `ai:ai`, `ai:ai_translate`. Composer requires `drupal/ai:^1.2.2`.

## What it provides

- **Config entity** `ai_translate_plus_settings` (`src/Entity/AiTranslatePlusSettings.php`,
  config_prefix `entity_type_settings`) — one per entity type; holds per-language/per-bundle prompts,
  models, and disabled fields. Schema: `config/schema/ai_translate_plus.schema.yml`.
- **AI provider plugin** `chat_translation_plus`
  (`src/Plugin/AiProvider/ChatTranslationPlusProvider.php`, extends `ai_translate`'s
  `ChatTranslationProvider`) — resolves the contextual prompt/model, applies tokens + Twig, and calls
  the real provider. → [plugins/provider.md](plugins/provider.md)
- **Two service decorators** + a request-scoped context service
  (`ai_translate_plus.services.yml`): `TextExtractorDecorator` (filters disabled fields, attaches
  context) decorates `ai_translate.text_extractor`; `TextTranslatorDecorator` decorates
  `ai_translate.text_translator`; `TranslationContextService` carries context between them and the
  provider. → [api/decorators.md](api/decorators.md)
- **Controller override** `AiTranslateController::translateSingleField`
  (`src/Controller/AiTranslateController.php`) — re-defines route `ai_translate.translate_content`
  to pass the extra context into `translateContent()`.
- **Forms**: `AiTranslatePlusOverviewForm` (lists translatable entity types),
  `AiTranslatePlusSettingsForm` (per entity type). → [config/settings.md](config/settings.md)
- **Permission**: `manage ai translate plus prompts` (restrict access: true).

## Routes (`ai_translate_plus.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `ai_translate_plus.settings_form` | `/admin/config/ai/ai-translate-plus` | `manage ai translate plus prompts` |
| `ai_translate_plus.settings.entity_type` | `/admin/config/ai/ai-translate-plus/{entity_type_id}` | `administer site configuration` |
| `ai_translate.translate_content` (override) | `/admin/content/{entity_type}/{entity_id}/translate/{lang_from}/{lang_to}` | `administer ai translate` |

Translation sends content to the AI provider configured for AI Translate/AI.
