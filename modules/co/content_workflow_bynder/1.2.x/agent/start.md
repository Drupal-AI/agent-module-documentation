<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Workflow (by Bynder) (content_workflow_bynder) — agent index

Imports structured content items from the **Content Workflow** platform (Bynder, formerly GatherContent) into Drupal entities via the **Migrate** framework. Version 1.2.1; core `^9.2 || ^10 || ^11`.

## What it is
- Authenticate to a Content Workflow account (email + API key), select an account, then define per-template **Mapping** config entities that map a Content Workflow project/template to a Drupal content type.
- Migrate definitions are generated dynamically and executed through migrate_plus/migrate_tools, from a batch UI action or Drush.
- Replacement for the deprecated `gathercontent` module; `hook_install()` migrates its settings, mappings and tracking rows.

## Dependencies
- Core: `node`, `taxonomy`, `menu_link_content`, `image`, `file`, `field`, `menu_ui`, `migrate`.
- Contrib: `migrate_plus`, `migrate_tools`.
- Composer: `gathercontent/client` (the API client library), `drupal/migrate_tools`.
- Optional: `paragraphs`, `entity_reference_revisions`, `metatag`, `token`, tablesorter JS.

## Provides
- **Config entity:** `content_workflow_bynder_mapping` (`src/Entity/Mapping.php`).
- **Config objects:** `content_workflow_bynder.settings` (credentials/account), `content_workflow_bynder.import` (import defaults). Schema in `config/schema/`.
- **Services:** `content_workflow_bynder.client` (`DrupalContentWorkflowBynderClient`, extends `GatherContent\GatherContentClient`), `content_workflow_bynder.metatag` (`MetatagQuery`), `content_workflow_bynder.migration_creator` (`MigrationDefinitionCreator`).
- **Migrate plugins:** source `content_workflow_bynder_migration`; destination `cwb_entity` (derived per entity type); process plugins `content_workflow_bynder_get|concat|file|media|taxonomy|reference_revision|sub_process|migrate_lookup_multiple`.
- **Base field:** `cwb_file_id` on `file` entities; unlimited locked `contentworkflowbynder_option_ids` field on `taxonomy_term` (added in `hook_install`).
- **Permission:** `administer content_workflow_bynder` (single permission gating everything).
- **Drush commands:** `content_workflow_bynder:import` (`cwb-i`), `content_workflow_bynder:list-mappings` (`cwb-lm`), `content_workflow_bynder-list-status` (`cwb-ls`).
- **Routes:** admin menu `content_workflow_bynder.admin_content_workflow_bynder`; forms `content_workflow_bynder.config_form` (Authentication) and `content_workflow_bynder.import_config_form` (Import config), all under `/admin/config/services/content_workflow_bynder`.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, config objects, credentials, routes & permission.
- [api/migration.md](api/migration.md) — Mapping entity, dynamic migration generation, source/destination/process plugins, import batch & entity-delete rollback.
- [drush/commands.md](drush/commands.md) — the three Drush commands and their arguments/options.
