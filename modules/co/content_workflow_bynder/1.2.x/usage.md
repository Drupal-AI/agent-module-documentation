<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Workflow (by Bynder) imports structured content items from the Content Workflow platform (formerly GatherContent) into Drupal using the Migrate framework.

---

Content Workflow (by Bynder) connects a Drupal site to a Content Workflow (Bynder/GatherContent) account and migrates editorial content produced there into Drupal entities. You authenticate with a Content Workflow user email plus an API key, pick an account, and create per-template mappings that describe how a Content Workflow project/template maps to a Drupal node type (with taxonomy, files/media, menu links and meta tags). The module then generates Migrate definitions dynamically and runs them through migrate_plus/migrate_tools, either from a batch UI action or the bundled Drush commands. It supports create-or-update imports, new-revision handling, multilingual content, content hierarchy via menu links, and rollback when a Drupal entity is deleted. It is a like-for-like replacement for the deprecated GatherContent module and can migrate that module's existing configuration and tracking data on install.

Authentication (email + API key + selected account) is stored in the `content_workflow_bynder.settings` config object and sent to `https://api.gathercontent.com` over HTTPS using HTTP Basic auth by the bundled `gathercontent/client` library. All admin pages and the import action are gated by the single `administer content_workflow_bynder` permission. Depends on core node/taxonomy/menu_link_content/image/file/field/menu_ui/migrate plus migrate_plus and migrate_tools; supports Drupal 9.2+, 10 and 11.

---

- Migrate content items from a Content Workflow (Bynder) project into Drupal nodes.
- Replace the deprecated GatherContent module and auto-migrate its config and tracking table.
- Authenticate to Content Workflow with a user email and API key on the Authentication form.
- Select which Content Workflow account to import from when a user has several.
- Test API connectivity by verifying credentials before saving.
- Map a Content Workflow project/template to a Drupal content type via a Mapping config entity.
- Import structured fields into node fields, taxonomy terms, files, media and meta tags.
- Create new Drupal pages or overwrite/update existing entities on re-import.
- Choose default published status and whether imports create a new revision.
- Run imports from Drush with `content_workflow_bynder:import` (alias `cwb-i`).
- List available mappings with `content_workflow_bynder:list-mappings` (alias `cwb-lm`).
- List Content Workflow project statuses with `content_workflow_bynder-list-status` (alias `cwb-ls`).
- Change a Content Workflow item's status from Drupal as part of an import.
- Build a menu hierarchy for imported content under a chosen parent menu item.
- Import multilingual content with per-language entity mapping and translations.
- Download referenced assets (images/files) from Content Workflow into Drupal file entities.
- Handle repeatable component groups (e.g. Paragraphs / entity reference revisions).
- Track imported entities so deleting a Drupal entity rolls back the corresponding migration row.
- Keep taxonomy option IDs synced via the locked `contentworkflowbynder_option_ids` field.
- Import basic meta tags when the Metatag module is present.
- Drive imports in batch from the UI or non-interactively from CI via Drush.
- Restrict all module pages and import actions to the `administer content_workflow_bynder` permission.
- Reset stored credentials and account from the Authentication form.
