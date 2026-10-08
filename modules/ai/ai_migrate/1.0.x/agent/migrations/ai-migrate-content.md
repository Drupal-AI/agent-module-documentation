<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migrate — bundled migration & group

Installed from `config/install/` when the module is enabled.

## Migration group — `ai_migrate_content`
`migrate_plus.migration_group.ai_migrate_content.yml`: id `ai_migrate_content`, label "AI Migrate Content", `source_type: Drupal 10`. No shared configuration. Appears at `/admin/structure/migrate`.

## Migration — `ai_migrate_content`
`migrate_plus.migration.ai_migrate_content.yml`. A worked example (edit for your site — the tag `vid`, field names and formats are placeholders). Structure:
- `migration_group: ai_migrate_content`, `audit: true`.
- **source**: `plugin: drupal10_node_fields` (the module's `Drupal10Node` SQL source), `key: migrate_source` — a source-DB connection you add to `settings.php` (`$databases['migrate_source']['default']`).
- **process** (source → destination):
  - passthrough base fields: `nid, type, langcode, uid, status, created, changed, promote, sticky`.
  - `field_content/value: body_value`; `field_content/format` = constant `content_format` (via `default_value`).
  - `field_description/value` ← `plugin: ai_summarize_content`, `source: body_value` (AI summary).
  - `field_tags` ← `plugin: ai_assign_tags`, `source: body_value`, `vid: tags`, `use_existing_only: 1` (existing-vocabulary tags only).
  - `title` ← `plugin: ai_suggest_title`, `source: body_value` (AI title).
- **destination**: `plugin: entity:node`.
- **dependencies.enforced.module**: `migrate`, `migrate_plus`, `ai`, `ai_content_suggestions` — so the migration config is removed when the module is uninstalled, and it documents that `ai_content_suggestions` must be present for the process plugins to resolve provider/prompt settings.

## Running it
1. `drush en ai_migrate ai_content_suggestions` (and `migrate_plus`).
2. Configure providers/models/prompts at `/admin/config/ai/suggestions` (sections: Suggest taxonomy tags, Summarise text, Suggest title). The `plugins` and prompt keys used are `summarise`, `title_suggest`, `taxonomy_suggest` (`taxonomy_suggest_from_voc` / `taxonomy_suggest_open`).
3. Add the `migrate_source` DB connection to `settings.php`.
4. Run: `drush migrate:import ai_migrate_content` (CLI) or execute via the Migrate Plus UI. Rows whose AI call returns empty are skipped (`MigrateSkipRowException`), not failed.

## Operating notes
- Re-running against the current site's own nodes updates descriptions/titles/tags in place (enrichment), not only fresh imports.
- Adjust summary length/tagging behavior by editing the AI Content Suggestions prompts rather than the migration YAML.
- Only users with migrate/administer-migrations access (or shell access for drush) can trigger it; there is no anonymous or low-privilege entry point.
