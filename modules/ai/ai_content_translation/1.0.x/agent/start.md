<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Translation (ai_content_translation) — agent index

AI-generated translations of Drupal **content entities** via **OpenAI**, layered on core
`content_translation`. Package `Content`. Version **1.0.3**. Core `^10 || ^11`. License
GPL-2.0-or-later. Depends on core **`content_translation`** and **`config`**. No composer.json,
no submodules, no Drush.

- **Settings form, config object, keys, schema, permission** → [config/settings.md](config/settings.md)
- **Translate route, controller flow, the OpenAI service, hooks** → [api/translate.md](api/translate.md)

## What it actually is

- One controller: `AITranslationController::translate($entity_type, $entity_id, $target_lang)`
  (`src/Controller/AITranslationController.php`), reached from route
  **`ai_content_translation.translate`** at `/admin/ai-translate/{entity_type}/{entity_id}/{target_lang}`.
  It creates a target-language translation of a content entity and fills each translatable text
  value from OpenAI.
- One service: `OpenAITranslationService::translateText($text, $target_language)`
  (`src/Service/OpenAITranslationService.php`, id `ai_content_translation.openai_translation`) —
  posts to `https://api.openai.com/v1/chat/completions` with the configured model/prompt and
  returns the model's text.
- One settings form: `AIContentTranslationSettingsForm` (route
  **`ai_content_translation.settings`** at `/admin/config/content/ai-content-translation`), writing
  config object **`ai_content_translation.settings`** (schema in `config/schema/`).
- One permission, **`administer ai content translation`** (`restrict access: true`), gates both
  routes. Granted to the `administrator` role on install.
- Menu link `ai_content_translation.settings` under *Configuration → Content authoring*
  (`system.admin_config_content`).

## Mechanism (from source)

- `ai_content_translation.module` adds the UI entry points via
  `hook_entity_operation_alter()` (an "AI Translate to <lang>" op per missing language),
  `hook_entity_translation_operations_alter()` (an "Add AI Translation" op on the Translations
  tab), and `hook_form_alter()` + `ai_content_translation_generate_translation_submit()` (a
  "Generate AI Translation" button on `*_content_translation_form` / `*_node_form`). Each links to
  the `translate` route.
- `translate()` loads the entity, rejects non-translatable and `taxonomy_term` entities, warns if a
  translation already exists, then `addTranslation($target_lang, $entity->toArray())` and translates
  `title`, `body`, other `text`/`text_long`/`text_with_summary`/`string`/`string_long` fields, and
  image `alt`/`title`. Body/text writes keep the source field's **`format`**.
- `translateContentEntities()` recurses through `entity_reference` /
  `entity_reference_revisions` fields (Paragraphs and other content), skipping `file`, `media`,
  `taxonomy_term`, and non-text fields; each referenced translation is saved individually.
- Every text value is sent to OpenAI **one field at a time** via the service (many API calls per
  entity). On success the controller redirects to the HTTP `referer` (fallback
  `system.admin_content`); on error it redirects to the content-translation overview.

## Config keys (config object `ai_content_translation.settings`)

`api_key`, `model` (`gpt-4` default), `system_prompt`, `temperature` (0.3), `timeout` (180),
`connect_timeout` (60), `enable_logging` (TRUE), `log_level` (`notice`), `show_sample_text`
(TRUE). Full descriptions in [config/settings.md](config/settings.md).

## Notes

- Requires an OpenAI API key; **source and translated text are sent to OpenAI** (third-party data
  egress + per-request cost). The `show_sample_text` option additionally logs text snippets — turn
  it off for sensitive content.
- Translation runs synchronously in the request (no queue/batch of its own); large structured
  entities make many sequential API calls, so raise `timeout`/`connect_timeout` accordingly.
