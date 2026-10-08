<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Migrate provides Drupal Migrate process plugins that call the AI module to generate content summaries, SEO-friendly titles and taxonomy tags while a migration runs.

---

AI Migrate integrates Drupal's AI framework into the Migrate pipeline. It ships three MigrateProcessPlugin implementations — `ai_summarize_content`, `ai_suggest_title` and `ai_assign_tags` — plus a `drupal10_node_fields` SQL source plugin and a bundled Migrate Plus migration (`ai_migrate_content`) and migration group. During a migration, each process plugin takes a source text field (for example a Drupal 10 body value), sends it to the AI provider configured for the AI Content Suggestions submodule, and maps the returned text back onto a destination field: a summary into a description field, a generated title into the node title, and a set of taxonomy term references into a tags field. Tagging can be restricted to an existing vocabulary (terms not already present are skipped) or allowed to create new terms on the fly. Provider, model and per-task prompts are read from `ai_content_suggestions.settings` and `ai_content_suggestions.prompts`, so the migration reuses the same AI configuration as the rest of the site. Migrations run from the CLI with `drush migrate:import` or through the Migrate Plus UI at `/admin/structure/migrate`.

---

- Add AI-generated summaries to migrated nodes with the `ai_summarize_content` process plugin.
- Generate SEO-friendly titles from body text using the `ai_suggest_title` process plugin.
- Auto-assign taxonomy tags from content with the `ai_assign_tags` process plugin.
- Restrict tag suggestions to an existing vocabulary via `use_existing_only: 1`.
- Let the tagging plugin create new taxonomy terms when `use_existing_only` is off.
- Choose which vocabulary the tag plugin reads/writes with the `vid` plugin key.
- Read Drupal 10 node and body fields with the bundled `drupal10_node_fields` SQL source plugin.
- Migrate content from a separate source database defined in settings.php (`migrate_source` connection).
- Reuse the AI provider, model and prompts configured under AI Content Suggestions.
- Run migrations from the CLI with `drush migrate:import ai_migrate_content`.
- Run and monitor migrations from the Migrate Plus UI at `/admin/structure/migrate`.
- Group AI-enabled migrations under the auto-created "AI Migrate Content" migration group.
- Enrich existing Drupal content by re-running the migration to update descriptions, titles and tags.
- Migrate legacy Drupal 10 blog/news content into a Drupal CMS site with populated summary and tag fields.
- Fill an editorial "description"/summary field automatically instead of copying the body.
- Keep AI output on failed rows out of the destination by skipping the row (MigrateSkipRowException on empty AI response).
- Adjust summary length, tone and tagging behavior by editing the AI Content Suggestions prompts.
- Extend the pipeline by mapping additional destination fields alongside the AI-generated ones.
- Combine AI process plugins with standard Migrate process plugins in the same migration.
- Support both Drupal 10.3+ and Drupal 11 destination sites.
- Use as a template for building your own AI-assisted Migrate Plus migrations.
