<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Strategy (ai_content_strategy) — agent index

Admin-only tool that asks the AI module's default chat provider to analyze a site's
content/structure and return prioritized, EEAT-framed content-strategy recommendations.
Output is stored in a key-value collection and shown as editable "cards"; it never
creates entities, content types, taxonomy, or config from the model response.

## Dependencies
- `drupal/ai` (`ai:ai`) — required; provides the `ai.provider` plugin manager and
  `ai.prompt_json_decode` service used for all LLM calls. Needs a configured chat provider.
- `menu_ui` — suggested (not required); when present its primary menu is added to the prompt.
- Core: `^10.2 || ^11`.

## What it provides
- Config entity: `recommendation_category` (`src/Entity/RecommendationCategory.php`) —
  admin_permission `administer ai content strategy`; keys id/label/description/weight/status/instructions.
  Seven default categories ship in `config/install/`.
- Config object: `ai_content_strategy.settings` (`system_prompt`); schema in
  `config/schema/ai_content_strategy.schema.yml`.
- Permissions (`ai_content_strategy.permissions.yml`): `access ai content strategy`
  (restrict access) and, via the entity, `administer ai content strategy`.
- Controller: `ContentStrategyController` (`src/Controller/`) — report page + AJAX
  generate/edit/delete callbacks.
- Services (`ai_content_strategy.services.yml`): `strategy_generator`, `content_analyzer`,
  `category_prompt_builder`, `category_schema_builder`, `recommendation_storage`,
  `idea_row_builder`, `ajax_response_builder`.
- Drush command set `acs:*` (`drush.services.yml`, `src/Drush/Commands/`) mirroring the UI.
- Storage: key-value collection `ai_content_strategy.recommendations`, key `recommendations`;
  state key `ai_content_strategy.last_run`.

## Routes (all under _permission)
- `ai_content_strategy.recommendations` — `/admin/reports/ai/content-strategy` (report; `access ai content strategy`).
- `ai_content_strategy.recommendations.generate`, `.generate_more`, `.add_more_recommendations`,
  `.delete_card`, `.delete_idea` — AJAX, `access ai content strategy`.
- `ai_content_strategy.save_card` — POST, `access ai content strategy`.
- `ai_content_strategy.settings` + `entity.recommendation_category.*` — `administer ai content strategy`.

## Solution docs
- [Configuration & operation](config/settings.md) — install/enable, categories, settings, storage, routes/permissions.
- [Generation pipeline & AI provider](api/generation.md) — how the prompt is built and how the provider is called.
- [Drush commands](api/drush.md) — the full `acs:*` reference.
