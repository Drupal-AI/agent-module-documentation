<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GatherContent (gathercontent) — agent index

**Imports GatherContent (Content Workflow) SaaS items into Drupal via Migrate.**

- **Version:** 6.1.x  | **Core:** ^9.2 || ^10  | **Package:** GatherContent
- **Configure:** `/admin/config/services/gathercontent` (perm `administer gathercontent`); auth at `.../config`, mappings at `.../import-config`.
- **Depends:** node, taxonomy, menu_link_content, image, file, field, menu_ui, migrate, migrate_plus, migrate_tools. **Library:** gathercontent/client ^1.2.
- **Submodules:** gathercontent_ui, gathercontent_upload, gathercontent_upload_ui.
- **Services:** `gathercontent.client` (DrupalGatherContentClient over `http_client`), `gathercontent.metatag`, `gathercontent.migration_creator`.

**Credentials:** account email + API key are kept in `gathercontent.settings` config; the API client uses Drupal `http_client`.
