<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Lifecycle — analyzer, batch, and entity

## The analyzer (`ContentAIAnalyzer`)

Service `ai_content_lifecycle.content_ai_analyzer`, constructed with `@config.factory`, `@entity_type.manager`,
`@ai.provider`, `@renderer`, `@language_manager`, `@logger.factory`, `@date.formatter`, `@module_handler`.

- `analyzeContent(EntityInterface $entity): ?string`
  1. `extractEntityContent()` builds `{title, content, updated?, language}`. `content` comes from rendering the
     entity in a view mode via `renderer->renderInIsolation()`, then `League\HTMLToMarkdown\HtmlConverter`
     (`strip_tags => TRUE`); on a render exception it falls back to `extractTextFieldsContent()` (concatenated
     `strip_tags`'d text/string fields).
  2. Builds the prompt: `pre_prompt` + a built-in `technicalSystemPrompt` (which demands **strict RFC8259 JSON**
     `{mark_for_update, reason}`), substitutes `[conditions]` with the per-entity prompt from `getPromptForEntity()`
     and `[ai_content_lifecycle:date]` with today's date, then runs `hook_ai_content_lifecycle_prompt` alter.
  3. Sends a `ChatInput` (`system` = prompt, `user` = `json_encode($content)`) to the provider — either
     `getDefaultProviderForOperationType('chat')` or the configured `provider_id__model_id` — via
     `provider->chat($messages, $model_id)->getNormalized()->getText()`.
  4. `json_decode`s the reply; if `mark_for_update` is true and `reason` is non-empty, returns the `reason` string;
     otherwise returns `NULL`. Exceptions are logged and return `NULL`.
- `getPromptForEntity()` — bundle prompt → entity-type `default` prompt → config `default_prompt` →
  `ContentLifecycleSettingsForm::DEFAULT_SYSTEM_PROMPT`.
- `updateContentLifecycleWithAnalysis($entity, $lifecycle = NULL)` — finds/creates the lifecycle entity, runs
  `analyzeContent()`, sets `ai_prompt_results`, saves.

All model access is through `@ai.provider`; this module opens **no HTTP connection and stores no API key/token** —
TLS and credentials are the `ai` module's provider responsibility.

## The batch (`ContentLifecycleBatchController` + `BatchProcess`)

- `batchCreate()` (route `ai_content_lifecycle.batch_create`) reads `enabled_entity_types` / `enabled_bundles` and
  queues a `BatchProcess::processBundle` op per enabled entity-type/bundle, then `batch_set()` + `batch_process()`
  back to the settings page. (Gated by the undefined `administer ai content lifecycle settings` permission — see
  config/settings.md — so effectively superuser-only today.)
- `BatchProcess::processBundle($entity_type_id, $bundle_id, &$context)` — queries all ids of the bundle with
  `->accessCheck(FALSE)`, loads them in slices of 10, and for each entity:
  - if a `ContentLifeCycle::findForEntity()` record exists and its `review_status` is `reviewed`/`ignored` → skip;
  - otherwise run `analyzer->analyzeContent()`; when it returns a reason, create-or-update a lifecycle entity with
    `ai_prompt_results` = reason and `review_status = 'analyzed'`, and save.
  Errors are logged and counted as skipped. This runs as the batch-initiating (admin) user and reads content with
  access checks disabled, which is the intended "scan everything" behaviour; note that content — including
  unpublished items — is sent to the configured AI provider during analysis.

## The `content_life_cycle` entity (`src/Entity/ContentLifeCycle.php`)

Revisionable, translatable content entity; `admin_permission = "administer content_life_cycle"`
(`restrict access: true`), full admin route set under `/admin/content/(content-life-cycle|life-cycle-management)`.
Base fields: `label`, `entity_type`, `entity_bundle`, `entity_id` (the referenced content),
`uid` (author; `preSave()` defaults to anonymous/0 when unset), `created`, `changed`,
`ai_prompt_results` (**text_long**, shown with `text_default`), `review_status` (**list_string**:
pending/analyzed/reviewed/updated/ignored, default pending).

Helpers: `setReferencedEntity()`, `getReferencedEntity()` (loads by stored type+id, logs+returns NULL on error),
static `findForEntity()` (`loadByProperties` on entity_type+bundle+id).

### Display & the AI text

`ai_prompt_results` is set from the model's `reason` as a bare string (no explicit text format), so on display the
`text_default` formatter runs it through the field's fallback format, which escapes HTML — the AI-produced reason
is rendered as escaped text, not live markup. The list builder (`ContentLifeCycleListBuilder::buildRow()`) renders
each field via `->view()` (auto-escaped), and the canonical template `content-life-cycle.html.twig` prints the
`content` render array. `label` is a 255-char string field shown with the `string` formatter (escaped).

## User lifecycle hooks (`.module`)

- `hook_user_cancel` (`user_cancel_reassign`) — sets `uid = 0` on the cancelled user's lifecycle records.
- `hook_ENTITY_TYPE_predelete` for users — deletes that user's lifecycle records and their revisions.
  Both query with `->accessCheck(FALSE)` (operating on the account's own tracking records during account deletion).
