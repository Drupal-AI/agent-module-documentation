<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GatherContent connects Drupal to the GatherContent (Content Workflow) SaaS platform and imports its items into Drupal content, taxonomy, and menu entities via configurable migrations.

---

Authentication (account email + API key) is configured at /admin/config/services/gathercontent/config (perm 'administer gathercontent'), and import mappings are defined through the import-configuration form. A DrupalGatherContentClient (wrapping the gathercontent/client library over Drupal's http_client) fetches projects, templates, and items; the module builds Migrate definitions (MigrationDefinitionCreator) and runs them through migrate_plus/migrate_tools to create or update Drupal entities, mapping GatherContent fields to Drupal fields including files, images, and metatags. Submodules add the mapping UI (gathercontent_ui) and pushing Drupal content back to GatherContent (gathercontent_upload, gathercontent_upload_ui). Credentials are stored in gathercontent.settings config. It is aimed at editorial teams who draft in GatherContent and publish in Drupal.

---

- Import GatherContent items into Drupal nodes.
- Map GatherContent template fields to Drupal fields.
- Sync editorial content drafted in GatherContent into the CMS.
- Update existing Drupal content from GatherContent revisions.
- Import images and files referenced by GatherContent items.
- Create taxonomy terms from GatherContent data.
- Push Drupal content back to GatherContent (upload submodule).
- Run imports as Migrate migrations via drush or the UI.
- Authenticate to GatherContent with email + API key.
- Build repeatable content-migration definitions.
- Map metatags from GatherContent fields.
- Coordinate a headless editorial workflow with Drupal publishing.
- Bulk-onboard content from an agency's GatherContent project.
- Keep translations aligned between the two systems.
- Configure per-template import mappings in the UI.
- Schedule or re-run imports as content changes upstream.
