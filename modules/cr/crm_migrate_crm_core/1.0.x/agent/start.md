<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Migrate CRM Core (crm_migrate_crm_core) — agent index

**Migrates Drupal 7 CRM Core contacts/relationships into Drupal CRM.**

- **Version:** 1.0.x  **Core:** ^10 || ^11
- **Depends:** crm, migrate, migrate_plus
- **Sources:** `CrmCoreContact`, `CrmCoreRelationship` (`SqlBase`, parameterized `select()`); **process:** `ContactTypeMap`, `RelationshipTypeMap`.
- **Drush:** `src/Commands/CrmMigrateCrmCoreCommands.php` (+ `InsertBuilder`).
- **Config route:** `/admin/config/development/crm-migrate` (`BundleMappingSettingsForm`), permission `administer crm_migrate_crm_core` (`restrict access: true`).
- **Security:** admin-gated migration config + Drush; source queries are parameterized (no raw SQL concatenation). No public endpoints.

See [drush/migrate.md](drush/migrate.md).
