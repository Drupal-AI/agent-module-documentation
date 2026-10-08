<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translate route, controller and OpenAI service

## Routes (`ai_content_translation.routing.yml`)

| Route | Path | Handler | Requirement |
|---|---|---|---|
| `ai_content_translation.settings` | `/admin/config/content/ai-content-translation` | `AIContentTranslationSettingsForm` | `_permission: administer ai content translation` |
| `ai_content_translation.translate` | `/admin/ai-translate/{entity_type}/{entity_id}/{target_lang}` | `AITranslationController::translate` | `_permission: administer ai content translation` |

`entity_id` is upcast to `entity:{entity_type}` via route `options.parameters`. The translate
route is a plain **GET** controller route (it is linked from operation dropdowns and a form
redirect, not submitted as a form).

## Entry points (`ai_content_translation.module`)

- `hook_entity_operation_alter()` — for each enabled language without an existing translation,
  adds operation `ai_translate_<langcode>` ("AI Translate to <language>") linking to the translate
  route. Gated by `isTranslatable()` + `hasPermission('administer ai content translation')` +
  `content_translation.manager::isEnabled()`.
- `hook_entity_translation_operations_alter()` — on the Translations tab, converts each missing
  language's "Add" into a dropdown with an extra "Add AI Translation" link.
- `hook_form_alter()` + `ai_content_translation_generate_translation_submit()` — on
  `*_content_translation_form` / `*_node_form` when a target langcode differs from the source,
  adds a "Generate AI Translation" submit button that redirects to the translate route.

## `AITranslationController::translate()`

Constructor injects `entity_type.manager`, `ai_content_translation.openai_translation`,
`language_manager`, `messenger`, `config.factory`.

Flow:

1. Load the entity (or use the upcast object). Guard: not found → error + redirect `<front>`;
   `taxonomy_term` → unsupported; not a `ContentEntityInterface` or not translatable → error;
   invalid `target_lang` → error; translation already exists → warning + redirect to the
   entity's `content_translation_overview`.
2. `addTranslation($target_lang, $entity->toArray())` to seed the translation.
3. Translate `title` (if present) and `body` (keeping its `format`), then loop all other fields:
   - image fields → `translateImageAttributes()` translates each item's `alt` and `title`.
   - `entity_reference` / `entity_reference_revisions` to `taxonomy_term` → skipped.
   - text fields (`text`, `text_long`, `text_with_summary`, `string`, `string_long`) → each
     non-empty delta value is sent to the service and written back with
     `['value' => $translated, 'format' => $item->format ?? NULL]`.
   - everything else (numeric, datetime, list, other references) → skipped.
4. `translateContentEntities()` recurses into referenced content/Paragraphs (see below).
5. `$translation->save()`, build a status message with view/edit links, then redirect to the HTTP
   `referer` header if present, else `system.admin_content`. Any thrown exception is logged and
   surfaced via messenger, redirecting to the overview.

### `translateContentEntities()` (recursion)

- Tracks processed entities by `type:id` to avoid infinite loops; skips `file`/`media`/
  `taxonomy_term` entity types and references.
- For each referenced translatable content entity without the target translation, it creates the
  translation, translates its text/image fields (same rules as above), saves it, then recurses.
- Paragraph ownership is checked via `getParentEntity()` where available (fallback: trust the
  traversal). Only text fields are translated in referenced entities; taxonomy references and
  non-text fields are skipped.

### Render/save sinks (how translated text is stored & shown)

- Text/body fields are written with the **source field's `format`**, so on render they pass
  through that text format's filters (core sanitisation applies as for any body field).
- `title`, `name`, `string`/`string_long` values are stored as plain field values and rendered
  through Drupal's normal auto-escaping.
- The success message passes the entity title as the `@title` placeholder and the rendered
  view/edit `Link` objects as `@view_link`/`@edit_link` (link objects are `MarkupInterface`).

## `OpenAITranslationService::translateText($text, $target_language)`

Service id `ai_content_translation.openai_translation`; args `@config.factory`, `@http_client`
(`ai_content_translation.services.yml`).

- Reads `api_key`, `system_prompt`, `model`, `temperature`, `timeout`, `connect_timeout`,
  `show_sample_text` from config; throws if `api_key` is empty.
- Builds `full_system_prompt = system_prompt . ' Translate it to ' . $target_language . '.'`.
- `POST https://api.openai.com/v1/chat/completions` (Guzzle `@http_client`) with
  `Authorization: Bearer <api_key>`, a `system` + `user` message pair, `temperature`, and the
  configured `timeout`/`connect_timeout`. TLS verification uses Guzzle's default (enabled);
  `http_errors => false` so HTTP status is checked manually (≥400 → thrown exception with the
  API's error message).
- Returns `choices[0].message.content`; unexpected shapes throw. The controller calls this once
  **per translatable field value**, so an entity with many fields/paragraphs makes many
  sequential requests.

## Operational notes

- No queue or Batch API of its own — translation happens inline in the GET request; for large
  structured content, raise `timeout`/`connect_timeout` in settings.
- The module warns rather than overwrites when a target translation already exists, so re-running
  the action does not regenerate an existing translation.
