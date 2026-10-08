<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migration Hbk Auto (migration_hbk_auto) — agent index

**Vue.js admin UI + controller endpoints to import Drupal 7 fields, terms, files and config during migration.**

- **Version:** 1.0.x (1.0.8)
- **Core:** ^10 || ^11
- **Depends:** migrate (Composer: migrate_plus, migrate_tools, migrate_upgrade, views_migration)
- **Routes:** `import-from-d7`, `manage-config`, `generate-fields`, `import-files`, `import-terms` (all `_permission: "access content"`); `migration-settings` form + `get-migration-settings` (`administer site configuration`).
- **Services:** `manage_nodes_config`, `manage_fields_config`, `config_manager`. **Library:** loads Vue 3 from unpkg CDN.
- **Security (report):** the mutating import/config endpoints are gated only by `access content` (effectively anonymous) yet create fields/files and write config — lock down before use. Loads Vue from an external CDN.

See [api/endpoints.md](api/endpoints.md).
