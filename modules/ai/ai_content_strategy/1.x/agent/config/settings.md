<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & operation

## Install / enable
- `composer require drupal/ai_content_strategy` then `drush en ai_content_strategy`.
- Requires `drupal/ai` with a working chat provider. Configure providers at
  `/admin/config/ai/providers` and set a default chat model; `StrategyGenerator::checkHealth()`
  (or `drush acs:health`) reports if none is usable.

## Permissions (`ai_content_strategy.permissions.yml` + entity)
- `access ai content strategy` — `restrict access: TRUE`. Gates the report page **and** every
  generate/edit/delete AJAX callback (`ai_content_strategy.routing.yml`). Grant only to trusted
  staff: it authorizes calls to the (metered) AI provider, not just viewing.
- `administer ai content strategy` — the config entity `admin_permission`
  (`RecommendationCategory` annotation); gates the settings form and all category routes.

## Config objects
- `ai_content_strategy.settings` — single key `system_prompt` (`config/install/ai_content_strategy.settings.yml`,
  schema type `text`). Edited by `SettingsForm` at `/admin/config/ai/content-strategy/settings`.
  Used as the chat system role in `StrategyGenerator::generateRecommendations()`; a hardcoded
  default is used if unset.
- `ai_content_strategy.prompts` — schema-declared (`content_strategy`, `generate_more`) but the
  shipped code builds prompts from `CategoryPromptBuilder` rather than this object.

## Recommendation Category config entity
- `config_prefix: recommendation_category`; `config_export` = id, label, description, weight,
  status, instructions. `instructions` is the free-text the AI receives for that category.
- Seven defaults in `config/install/`: `content_gaps`, `authority_topics`,
  `expertise_demonstrations`, `trust_signals`, `content_series`, `orphaned_topics`,
  `underutilized_types`.
- Managed at `/admin/config/ai/content-strategy/categories` via `RecommendationCategoryForm`
  (add/edit; instructions required) and core `EntityDeleteForm`. `postSave`/`postDelete`
  invalidate the schema cache (`ai_content_strategy:composite_schema`) and the
  `recommendation_category_list` cache tag.
- Because categories are config entities they export/import with `drush config:export` for
  multi-site reuse.

## Where results live
- Key-value collection `ai_content_strategy.recommendations`, key `recommendations`, shape
  `{data: {<category_id>: [cards]}, timestamp, pages_analyzed}`. Each card:
  `{title, description, priority, content_ideas[], uuid}`; each idea (after normalization):
  `{text, implemented, link, uuid}` — see `RecommendationStorageService`.
- `hook_uninstall()` deletes the key-value collection, all category entities, the
  `ai_content_strategy.last_run` state, and the schema cache.
- Update hooks `10001`–`10003` install default categories and the settings object.

## Routes & UI
- Report: `ai_content_strategy.recommendations` → `/admin/reports/ai/content-strategy`
  (`ContentStrategyController::recommendations`), themed by `ai_content_strategy_recommendations`.
- AJAX callbacks (all `access ai content strategy`): `.generate` (regenerate all),
  `.generate_more/{section}/{uuid}` (5 more ideas for a card), `.add_more_recommendations/{section}`
  (2 more cards), `.delete_card/{section}/{uuid}`, `.delete_idea/{section}/{uuid}/{idea_uuid}`,
  and `.save_card/{section}/{uuid}` (POST; inline autosave, values passed through `strip_tags`).
- CSV export is client-side JS (`js/content-strategy-export.js`); there is no export route.
- Menu/task links: report under Reports; settings/categories tabs under the AI settings group
  (`*.links.menu.yml`, `*.links.task.yml`).
