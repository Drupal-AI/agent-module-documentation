<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, credentials, routes & permission

## Install / enable
`composer require drupal/content_workflow_bynder` then enable. Pulls in `gathercontent/client` and `drupal/migrate_tools`; core node/taxonomy/menu_link_content/image/file/field/menu_ui/migrate and contrib migrate_plus/migrate_tools must be present.

`content_workflow_bynder_install()` (`content_workflow_bynder.install`):
- Adds an unlimited, locked `contentworkflowbynder_option_ids` string field to `taxonomy_term` (used to match Content Workflow choice option IDs back to terms).
- If the legacy `gathercontent` module is enabled, copies `gathercontent.settings`/`gathercontent.import` into the new config objects (stripping the `gathercontent_` prefix), converts each `gathercontent_mapping` into a `content_workflow_bynder_mapping`, regenerates migration definitions via `content_workflow_bynder.migration_creator`, and copies the `gathercontent_entity_mapping` tracking rows into `content_workflow_bynder_entity_mapping`.
- `hook_schema()` defines `content_workflow_bynder_entity_mapping` (`entity_id`, `entity_type`, `cwb_id`, `migration_id`, `langcode`) — the table used for rollback tracking.

## Config objects
- **`content_workflow_bynder.settings`** — `username` (Content Workflow login email), `api_key`, `account` (PHP-`serialize`d `[id => name]` of the selected account), `content_workflow_bynder_urlkey` (account slug). Defaults ship empty. Schema: `config/schema/content_workflow_bynder.schema.yml`.
- **`content_workflow_bynder.import`** — `node_default_status` (int 0/1), `node_update_method` (string, default `always_update`), `node_create_new_revision` (bool). Install defaults: status `1`, method `always_update`.
- **`content_workflow_bynder.content_workflow_bynder_mapping.*`** — the Mapping config entity (see api/migration.md). Schema: `config/schema/content_workflow_bynder_mapping.schema.yml`.

## Routes & permission
All routes require the single permission `administer content_workflow_bynder` and live under `/admin/config/services/content_workflow_bynder`:
- `content_workflow_bynder.admin_content_workflow_bynder` — admin menu block landing page.
- `content_workflow_bynder.config_form` (`/config`) → `Form\ConfigForm` — "Authentication".
- `content_workflow_bynder.import_config_form` (`/import-config`) → `Form\ImportConfigForm` — "Import configuration".

## Authentication flow (`Form\ConfigForm`)
- Fields: `username` (email) and `api_key` (textfield). `validateForm()` sets the credentials on `content_workflow_bynder.client` and calls `accountsGet()`; failure sets a form error.
- On first submit the credentials are saved and the form rebuilds to show an account `select` (populated from `accountsGet()`); choosing an account saves it (`serialize([id => name])`) plus the account slug as `content_workflow_bynder_urlkey`.
- A "Reset credentials" button clears `username`, `api_key`, `account` and `content_workflow_bynder_urlkey`.
- Credentials are held in the config object and applied to each API call by `DrupalContentWorkflowBynderClient::setCredentials()`. The client (`content_workflow_bynder.client`) extends `GatherContent\GatherContentClient`, which talks to `https://api.gathercontent.com` over HTTPS using HTTP Basic auth (email + API key); the API key is not placed in URLs.

## Services
- `content_workflow_bynder.client` → `DrupalContentWorkflowBynderClient` (arg `@http_client`) — API wrapper; adds `getActiveProjects()`, `getTemplatesOptionArray()`, async `downloadFiles()` (writes assets to `file` entities keyed by `cwb_file_id`), and a static `getAccountId()`.
- `content_workflow_bynder.metatag` → `MetatagQuery` — discovers metatag-capable fields for mapping.
- `content_workflow_bynder.migration_creator` → `MigrationDefinitionCreator` — builds Migrate definitions from a Mapping.
