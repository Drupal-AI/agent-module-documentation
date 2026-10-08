<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, routes, permissions & forms

## Permissions (`ai_content_migrate.permissions.yml`)

- **`administer ai content migrate`** — "Administer AI Content Migrate". Gates the legacy agent
  entities, the enqueue/reset pages, the dialog controller and the settings form.
- **`administer ai_content_xpaths_map`** / **`administer ai_content_xpaths_map_item`** — the XPath-map
  config-bridge entities and the test-xpath endpoint (`restrict access: true`).
- **`administer migrated records`** — records produced by the database wizard (`restrict access:
  true`).

(Per-route permission requirements are declared in `ai_content_migrate.routing.yml`; see the
route table below.)

## Content entities (`src/Entity/`, installed by `ai_content_migrate.install`)

Base fields declared in code. Entity types:

- **`ai_model`**, **`ai_import`**, **`ai_migration`** — the legacy agent flow (as in 1.0.x):
  a saved model JSON, a URL-to-import referencing a model, and a group of imports. Collections under
  `/admin/structure/` via the `ai_content_migrate.main` menu (Structure → AI Content Migrate).
- **`sitemap_analysis`** — result of one sitemap run (`sitemap_url`, `total_urls`,
  `models_generated`, `content_models` refs, `url_alternates`); edit + CSV export.
- **`content_model`** — a reusable per-template model (`title`, `url`, `urls` map,
  `content_type`, `model_data`); `update_8003` added the `urls` map field.
- **`database_migration_analysis`** — one database-dump analysis; delete hook clears its profile
  state/datasets/migrations via `DatabaseProfileMigrator::delete()`.
- **`migrated_record`** (+ **`migrated_record_type`** bundle) — non-node records produced by the
  database wizard.
- **`ai_content_xpaths_map`** (+ **`ai_content_xpaths_map_item`**) — config-bridge entities mapping a
  source dataset (the entity's `url`/`data_rows`) + XPath items (field name/type/reference
  bundle/`xpaths[]`) to a destination entity type. `hook_ENTITY_TYPE_update` regenerates
  `migrate_plus` files into `public://ai_migrations/` on save (via `MigrateFileGeneration`). Four bulk
  actions are installed in `config/install/system.action.ai_content_xpaths_map*` (save/delete for map
  and item).

## Config entity

- **`aicm_source_profile`** (schema `config/schema/ai_content_migrate.schema.yml`) — an approved
  declarative database source profile: `id`, `label`, `state`, `origin`, `spec` (YAML). Installed by
  `update_8004`; collection "Source profiles". Exportable with configuration for reuse.

## Routes (`ai_content_migrate.routing.yml`)

Legacy agent (permission `administer ai content migrate`):
- `ai_content_migrate.ai_import_enqueue` — `/admin/content/ai-import/enqueue`, `AiImportEnqueueForm`
  (generate/run `migrate_plus` YAML+CSV ZIP; delete selected migrations).
- `ai_content_migrate.reset` — `/admin/content/ai-import/reset`, `ResetController::reset` (clears
  `last_model*` state, redirects to the Explorer).
- `ai_content_migrate.dialog_content` — `/admin/ai-content-migrate/dialog/{uuid}`.
- `ai_content_migrate.settings` — `/admin/config/ai/content-migrate`, `SettingsForm`
  (`ai_content_migrate.settings` config: `default_ai_provider`, max upload MB, …).

Sitemap flow:
- `ai_content_migrate.import` — `/admin/content/ai-drupalcms-cm/import`, `SitemapImportForm`,
  permission **`access content`**. 3-step wizard: enter sitemap URL → review count → batch-analyze
  each page and build `content_model`/`sitemap_analysis` entities with a drag-and-drop Kanban remap.
- `ai_content_migrate.analysis.collection` + `entity.sitemap_analysis.edit_form` / `.export_csv`;
  `entity.content_model.collection`; `…generate_migration`, `…generate_canvas_template(s)`
  (controllers in `MigrateGenerationController`) — all `administer site configuration` (canvas/generate
  routes also require `_csrf_token`).

Database flow (all `administer site configuration`; mutating controllers require `_csrf_token`):
- `ai_content_migrate.database_migration_plan` — `/…/database-migration-plan`,
  `DatabaseMigrationWizardForm` (upload SQL dump + attachments).
- `…/database-analysis/{id}` review / `/generate` / `/run` / `/rollback`
  (`DatabaseMigrationAnalysisController`), `/review` (`DatabaseProfileSettingsForm`),
  `/profile-builder` (`DatabaseProfileBuilderForm`), `/table/{content_model}`
  (`DatabaseContentModelForm`).

XPath tester:
- `ai_content_migrate.test_xpath_endpoint` — POST `/ai-content-migrate/test-xpath`,
  `XpathTestController::handle`, permission **`administer ai_content_xpaths_map`**; fetches `test_url`
  via `HtmlFetcher` and runs submitted XPaths with a Symfony `Crawler`.

## Forms of note

- **`DatabaseMigrationWizardForm`** — uploads the dump; `hook_file_upload_validators_alter` clears all
  validators for the `database_file` field so `.sql`/`.zip`/`.tar.gz` are accepted. Detection →
  profile mapping or AI-drafted declarative profile.
- **`DatabaseProfileBuilderForm`** — shows the full local schema metadata, drafts a profile with the
  AI (`ProfileDrafter`), verifies it (`ProfileVerifier`), and saves an `aicm_source_profile`.
- **`AiImportEnqueueForm`**, **`AiContentMigrateExplorerForm`** — as in 1.0.x (migrate export; Explorer
  subclass adding a destination-folder field).

See [../api/services.md](../api/services.md) for the generator/migrator services and the privacy
boundary of the database flow.
