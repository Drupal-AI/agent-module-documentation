<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CRM Migrate CRM Core migrates data from a Drupal 7 CRM Core install into the modern Drupal
CRM module — contacts and relationships, with type/bundle mapping.

---

It ships migrate source plugins (`CrmCoreContact`, `CrmCoreRelationship`) that read the D7
`crm_core_contact`, `field_data_contact_name` and relationship tables via `SqlBase`
(parameterized queries), migrate process plugins (`ContactTypeMap`, `RelationshipTypeMap`) to
translate CRM Core bundles/relationship types to their Drupal CRM equivalents, and a Drush
command set (`CrmMigrateCrmCoreCommands` with an `InsertBuilder` helper) to run/assist the
migration. A bundle-mapping admin form at `/admin/config/development/crm-migrate`
(`administer crm_migrate_crm_core`, `restrict access: true`) lets you configure how CRM Core
contact types map to Drupal CRM contact bundles before running the migration.

Setup: configure a Drupal 7 migrate source database connection, map the bundles/types on the
admin form, then run the migration via Drush (or the migrate tools). Use it to bring legacy
CRM Core CRM data forward when upgrading a site to Drupal 10/11.

---

- Migrate CRM Core (D7) contacts into Drupal CRM.
- Migrate CRM Core relationships into Drupal CRM.
- Map CRM Core contact types to Drupal CRM bundles.
- Map CRM Core relationship types to Drupal CRM types.
- Read legacy contact names from `field_data_contact_name`.
- Configure bundle mapping from an admin form.
- Run the migration with the provided Drush commands.
- Use migrate_plus alongside core Migrate.
- Preserve contact ids/created/changed during migration.
- Upgrade a D7 CRM Core site to D10/D11 CRM.
- Restrict migration config to administrators.
- Assist row insertion via the InsertBuilder helper.
- Preview the bundle mapping before running migrations.
- Re-run the migration idempotently by contact id.
- Bring household/organization contact types across.
- Combine with migrate_plus source configuration.
