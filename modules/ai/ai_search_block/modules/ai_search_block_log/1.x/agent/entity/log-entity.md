<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ai_search_block_log` entity, storage & API

## Entity (`src/Entity/AiSearchBlockLog.php`)
`@ContentEntityType` id `ai_search_block_log`, base table `ai_search_block_log`,
`admin_permission = "administer ai_search_block_log"`, `field_ui_base_route =
entity.ai_search_block_log.settings`. Handlers: `AISearchBlockLogListBuilder` (list),
`EntityViewsData`, standard forms + `ContentEntityDeleteForm` / `DeleteMultipleForm`,
`AdminHtmlRouteProvider`. Links: collection `/admin/content/ai-search-block-log`, canonical/edit/
delete under `/ai-search-block-log/{id}`.

Base fields (`baseFieldDefinitions()`): `id`, `uid` (author), `block_id` (string 255),
`created` + `expiry` (timestamps), `question` (`string_long`), `prompt_used` (`string_long`),
`response_given` (`string_long`), `detailed_output` (`string_long`, JSON), `score` (integer,
unsigned), `feedback` (`string_long`, not shown in the default view display). View-mode display for
question/response/etc. uses the core `string` formatter (HTML-escaped) and Twig autoescape.

## Service `ai_search_block_log.helper` (`AiSearchBlockLogHelper`)
- `start($block_id, $uid, $query)` — creates a log row (`question` stored with `format => plain_text`),
  returns its id. Called by the parent controller at query start.
- `logResponse($id, $response)` — sets `response_given`.
- `update($id, array $fields)` — loads the row by id and `set()`s each supplied field, then saves.
  No ownership/access check (callers are trusted server-side code — but see the scoring route in
  api/routes.md).
- `cron()` — deletes rows whose `created` is older than the retention window
  (`ai_search_block_log.settings:expiry`, default `year`), via an `accessCheck(FALSE)` entity query.

## Procedural wrappers (`ai_search_block_log.module`)
`ai_search_block_log_start()`, `ai_search_block_log_add_response()`, `ai_search_block_log_update()`
delegate to the helper; the parent module calls these through `function_exists()` /
`moduleExists()` guards so the parent works with the submodule absent.

## Config (`config/install/ai_search_block_log.settings.yml`)
`expiry` (retention granularity), `ai_analysis_prompt`, plus FAQ-creation placeholders
(`faq_creation_enabled_*`, `faq_content_type`, `faq_question_field`, `faq_answer_field`). Edited via
`AISearchBlockLogSettingsForm` (route `entity.ai_search_block_log.settings`).

## Install (`ai_search_block_log.install`)
`update_9001` adds performance indexes on `created` and composites (`created`+`block_id`/`uid`/`score`).
