<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, routes, permissions & forms

## Permission

One permission, in `ai_content_migrate.permissions.yml`:

- **`administer ai content migrate`** — "Administer AI Content Migrate". It is the `admin_permission`
  of all three entity types and the requirement on both module routes. There are no other, finer
  permissions and no `_access: TRUE`/anonymous routes.

## Content entities (`src/Entity/`)

All three are `ContentEntityType`s with `admin_permission = "administer ai content migrate"`, core
`ContentEntityForm`s, and admin-route providers under `/admin/content/…`. Base fields are declared in
code (no config schema, no `config/install`); installed/updated by `ai_content_migrate.install`
(`hook_install` + `update_8001`/`8002` install the entity types).

- **`ai_model`** (`AiModel.php`, table `ai_model`) — fields: `label` (string), **`json`**
  (`string_long`, required — the model JSON), `conversation_id` (string), `created`, `changed`.
  List builder `AiModelListBuilder` (`src/AiModelListBuilder.php`). Links: collection
  `/admin/content/ai-model`, add/edit/canonical/delete.
- **`ai_import`** (`AiImport.php`, table `ai_import`) — fields: `model` (entity_reference →
  `ai_model`, required), **`url`** (string, max 2048, required, used as the entity label), `created`,
  `changed`. Collection `/admin/content/ai-import`.
- **`ai_migration`** (`AiMigration.php`, table `ai_migration`) — fields: `label` (string, required),
  **`imports`** (entity_reference → `ai_import`, unlimited cardinality), `created`, `changed`.
  Collection `/admin/content/ai-migration`. Uses core `EntityAccessControlHandler`.

Collection menu links are declared in `ai_content_migrate.links.menu.yml` under
*Content* (`system.admin_content`).

## Routes (`ai_content_migrate.routing.yml`)

- **`ai_content_migrate.ai_import_enqueue`** — `/admin/content/ai-import/enqueue`, form
  `AiImportEnqueueForm`, permission `administer ai content migrate`, admin route.
- **`ai_content_migrate.reset`** — `/admin/content/ai-import/reset`, controller
  `ResetController::reset`, same permission. Deletes the `ai_content_migrate.last_model` and
  `.last_model_sitemap` state keys and redirects (via `TrustedRedirectResponse`) back to the AI Agents
  Explorer for this agent.

(Note: the file also contains a malformed stub route `ai_content_migrate.entity_models_list` with an
empty `_form` and a stray quote in its path — it is non-functional; use the `ai_model` entity
collection instead.)

## Forms (`src/Form/`)

- **`AiImportEnqueueForm`** (`getFormId()` = `ai_content_migrate_generate_and_execute_form`) — lists
  `ai_migration` entities with checkboxes. "Generate YAML/CSV and download" collects the linked
  imports' data, writes a CSV + one or more `migrate_plus.migration.*.yml` definitions to
  `public://ai_migrations/`, zips them, and shows a download link. Definition building
  (`buildDefinitionsFromModels()` → `extractXpathModel()`, `mapBundleUrls()`,
  `getBundleFieldInfo()`, `buildCsvDefinitionFromSimpleModel()`) emits HTML-DOM→node/file/media
  migrations that use the module's `dom`/`get_full_path`/`download_or_skip`/`empty_coalesce`/
  `entity_generate` process plugins. With **"Run migration now"** checked *and* `migrate_plus`
  enabled, it also `create()`s the `migrate_plus` Migration entities and runs them via
  `MigrateExecutable::import()`. A second submit handler `submitDeleteMigrations()` deletes selected
  `ai_migration` entities.
- **`AiContentMigrateExplorerForm`** — extends `ai_agents_explorer`'s `AiAgentExplorerForm`, adding a
  "Migration Folder Destination" textfield (default `public://migrated-content/`). It is not bound to
  a route in this module's `routing.yml`.

## Install / operate

1. `composer require drupal/ai_content_migrate` (pulls `drupal/ai_agents`), install
   `chrome-php/chrome` and a system `chromium` binary; `drush en ai_content_migrate`.
2. Configure an AI provider through `ai`/`ai_agents`.
3. Grant `administer ai content migrate` to trusted site builders only.
4. Drive the `ai_content_migrate_agent` from the AI Agents Explorer; review each proposed model, run a
   dry run, then apply/enqueue. Manage saved `AI Models` / `AI Imports` / `AI Migrations` under
   *Content*; export or run migrations from the enqueue form.
