<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI AutoEvals — settings, evaluation sets, permissions, cron

## Install / enable

- `composer require drupal/ai_autoevals` (pulls `ai` + `key`), `drush en ai_autoevals`.
- Configure at **`/admin/config/ai/autoevals`** (`ai_autoevals.settings_form`, `Form\SettingsForm`,
  `administer ai autoevals`). Install ships one enabled set `default`
  (`config/install/ai_autoevals.evaluation_set.default.yml`) and a `strict` optional set.
- A provider **and** model must be configured (either in settings or as the `ai` system default) or
  `Evaluator`/`AiFactExtractor` throw / no-op. The provider key is a `key` entity managed by `ai`.

## Config object `ai_autoevals.settings` (schema `config/schema/ai_autoevals.schema.yml`)

`default_provider_id`, `default_model_id` (strings; empty → fall back to `ai`'s default chat
provider/model via `AiProviderPluginManager::getDefaultProviderForOperationType('chat')`),
`operation_types` (string[], default `[chat, chat_completion]`), `auto_track` (bool),
`fact_extraction_method` (`ai_generated` | `rule_based` | `hybrid`), `context_depth` (int, default
3), `retention_period` (int days, default 90; 0 disables purge), `debug_mode` (bool),
`global_exclude_query_keywords` / `global_exclude_response_keywords` / `global_exclude_tags`
(string[]; `getGlobalExcludeTags()` defaults to `['ai_agents']`). `Service\AiAutoevalsConfig` is the
typed accessor for all of these and exposes `getProvider()`/`isConfigured()`. `SettingsForm` uses
`ai.form_helper` to render provider/model selects.

## Evaluation set config entity `ai_autoevals_evaluation_set` (`Entity\EvaluationSet`)

- `@ConfigEntityType(id = "ai_autoevals_evaluation_set")`, `config_prefix`
  `ai_autoevals.evaluation_set`, `admin_permission = "administer ai autoevals"`. Schema
  `ai_autoevals.evaluation_set.*`.
- `config_export`: `id, label, description, operation_types, fact_extraction_method,
  custom_knowledge, prompt_template_id, custom_prompt_template, choice_scores, tags, exclude_tags,
  context_depth, enabled, weight, query_keywords, response_keywords, keyword_match_mode,
  exclude_query_keywords, exclude_response_keywords`.
- Matching helpers on the entity: `matchesOperationType()`, `matchesTags()`, `matchesQuery()`,
  `matchesResponse()`, `matchesQueryExclusion()`, `matchesResponseExclusion()`, `hasKeywords()`,
  `hasCustomKnowledge()`, `getChoiceScores()` / `getScoreForChoice()`.
- `choice_scores` maps choices A–E to floats (default set: A 0.4, B 0.6, C 1.0, D 0.0, E 1.0).
- Managed at `/admin/content/ai-autoevals/sets` (list = `view ai autoevals sets`; add/edit/delete =
  `manage ai autoevals sets`), forms `Form\EvaluationSetForm` / `EvaluationSetDeleteForm`.

### Programmatic creation — `EvaluationSet::builder($id, $label)` → `Entity\EvaluationSetBuilder`

Fluent methods (from README/source) include `withDescription()`, `forOperations()`,
`triggerOnKeywords()`, `withCustomKnowledge()`, `withFactExtractionMethod()`, `build()`. Returns an
`EvaluationSet` config entity you then `save()`.

## Permissions (`ai_autoevals.permissions.yml`)

`administer ai autoevals` (**restrict access: true**; also the entity create/admin permission),
`view ai autoevals results`, `edit ai autoevals results`, `delete ai autoevals results`,
`view ai autoevals sets`, `manage ai autoevals sets`, `requeue ai autoevals`, `batch ai autoevals`.
`EvaluationResultAccessControlHandler` maps entity view→`view`, update→`edit`, delete→`delete`
results permissions; create→`administer ai autoevals`.

## Storage & cron

- Table `ai_autoevals_conversation_cache` (`ai_autoevals.install` `hook_schema`) holds transient
  conversation context keyed by `request_id` (see `Service\ConversationTracker`, `cache.default`
  backed). The `cache.ai_autoevals_facts` bin caches extracted facts.
- `hook_cron()` deletes up to 100 `ai_autoevals_evaluation_result` entities older than
  `retention_period` days per run (skipped when `retention_period <= 0`).
- `hook_uninstall()` deletes the `ai_autoevals.settings` config object.
