<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/ContentWorkflowBynderCommands.php` (extends `Drush\Commands\DrushCommands`), injected with `content_workflow_bynder.client`, `config.factory`, `entity_type.manager`.

## `content_workflow_bynder:list-mappings` (alias `cwb-lm`)
Lists the configured `content_workflow_bynder_mapping` entities: mapping ID, project ID/label, template ID/label, content type. Read-only, no arguments.

## `content_workflow_bynder-list-status` (alias `cwb-ls`)
Lists Content Workflow status definitions for a project.
- Optional argument `project_id`. If omitted, resolves the account via `client::getAccountId()`, lists projects (`client->projectsGet()`), and prompts to choose one.
- Calls `client->projectStatusesGet($project_id)` and returns `status_id` / `status_label`.
- `--format` (default `table`) and `--fields` options.

## `content_workflow_bynder:import` (alias `cwb-i`)
Runs an import batch for a mapping.
- Argument `mapping_id` — if omitted, prompts to select a mapping.
- Argument `status_id` — optional Content Workflow status to set on imported items.
- Argument `parent_menu_item` — optional parent menu entry (e.g. `account:user.page`) for menu hierarchy.
- Options `--publish` / `--no-publish` and `--create-new-revision` / `--no-create-new-revision` (both default TRUE).
- Loads the mapping, fetches project items (`client->itemsGet()`), keeps only items whose `templateId` matches the mapping, builds an `Import\ImportOptions` per item, and runs `content_workflow_bynder_import_process()` through `drush_backend_batch_process()`.

All commands operate as the CLI user and rely on the stored credentials in `content_workflow_bynder.settings`; the API is reached over HTTPS by the `gathercontent/client` library.
