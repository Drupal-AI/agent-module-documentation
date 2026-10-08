<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migrate (ai_migrate) — agent index

Drupal Migrate process plugins that call the AI module to generate summaries, SEO titles and taxonomy tags during a content migration. Version **1.0.x** (1.0.1-beta1). Core `^10.3 || ^11`. Package: AI.

## Dependencies
- `ai:ai` — AI provider abstraction (chat operation).
- `migrate_plus:migrate_plus` — migration entities/UI and the bundled migration group.
- `ai_content_suggestions` (submodule of AI) — **runtime** requirement enforced by the shipped migration config; supplies provider/model selection (`ai_content_suggestions.settings`) and prompts (`ai_content_suggestions.prompts`). Also `migrate` (core).

## What it provides
- Migrate **process** plugins (`@MigrateProcessPlugin`):
  - `ai_summarize_content` — `AiSummarizeContent`, summary from source text.
  - `ai_suggest_title` — `AiSuggestTitle`, generated title from source text.
  - `ai_assign_tags` — `AiAssignTags`, taxonomy term references from source text (multiple).
  - shared base: `AiProcessBase` (holds provider selection + `getGeneratedResponse()`).
- Migrate **source** plugin: `drupal10_node_fields` — `Drupal10Node` (extends `SqlBase`), reads D10 `node_field_data` + `node__body`.
- Config (config/install): a Migrate Plus migration `migrate_plus.migration.ai_migrate_content` and migration group `migrate_plus.migration_group.ai_migrate_content` ("AI Migrate Content"), installed on enable.

## No routes / permissions / services
No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `.module` or `.install`. Plugins are container-aware (`ContainerFactoryPluginInterface`) and pulled by the Migrate framework. It defines no new plugin type and no config schema. Runs only via `drush migrate:import` or the Migrate Plus UI (`/admin/structure/migrate`) — i.e. under migrate/administer-migrations access, not anonymous.

## Solution docs
- [Process & source plugins](plugins/process-plugins.md) — the three AI process plugins, the D10 source plugin, and how AI provider/prompt config is resolved.
- [Bundled migration & group](migrations/ai-migrate-content.md) — the shipped `ai_migrate_content` migration, its source→process→destination mapping, and how to run it.
