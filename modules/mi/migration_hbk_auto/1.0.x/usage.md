<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migration Hbk Auto ships a Vue.js single-page admin interface plus a set of controller endpoints that generate field/config definitions and import taxonomy terms, files and configuration from a Drupal 7 source site during migration.
---
The Vue app (`buildinterface` library, loading `vue.global.js` from unpkg) is rendered at `/admin/migration-hbk-auto/import-from-d7` and drives JSON endpoints: `manage-config` (write/check config), `generate-fields` (create field storage/instances from D7 field data), `import-files` (create file entities from D7 fids), and `import-terms` (check which terms exist). A settings form at `/admin/config/system/migration-settings` stores the D7 `source_site_url` in `migration_hbk_auto.settings`, and `get-migration-settings` returns that config as JSON. Services `ManageNodesConfig`, `ManageFieldsConfig` and `ConfigManager` do the entity/config writes.

**Access note (report only):** the settings form and `get-migration-settings` require `administer site configuration`, but the four action endpoints (`import-from-d7`, `manage-config`, `generate-fields`, `import-files`, `import-terms`) require only `_permission: "access content"` — a permission granted to anonymous users by default — even though `generate-fields` creates Drupal field configuration, `import-files` creates file entities, and `manage-config` writes configuration from the JSON request body. Treat this as an administrative developer tool and lock those routes down before use. Setup: set the D7 source URL on the settings form, then run the imports from the Vue UI.
---
- Import Drupal 7 content structure into Drupal 10/11.
- Configure the Drupal 7 source site URL for migration.
- Generate Drupal field storage/instances from D7 field data.
- Import files/images from a Drupal 7 site by fid.
- Check which Drupal 7 taxonomy terms already exist locally.
- Write/verify configuration entities from the migration UI.
- Drive migration steps from a Vue.js single-page interface.
- Fetch current migration settings as JSON.
- Stage a D7→D10/11 migration with a guided UI.
- Map D7 fields to a target entity type and bundle.
- Bulk-create fields for a content type during migration.
- Recreate a D7 vocabulary's terms on the new site.
- Review generated config before importing content.
- Restrict migration endpoints to trusted admins (recommended).
- Attach the Vue build interface to the import page.
- Run repeated import passes for fields, terms and files.
