<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Migrate CRM Core — migrate + drush

1. **Source DB** — register the Drupal 7 database as a migrate source connection (settings.php
   `$databases['migrate']['default'] = [...]` or a migrate_plus source config).
2. **Bundle mapping** — *Configuration → Development → CRM Migrate CRM Core bundle mapping*
   (`/admin/config/development/crm-migrate`, `BundleMappingSettingsForm`, permission
   `administer crm_migrate_crm_core`): map each CRM Core contact type to a Drupal CRM bundle.
   `ContactTypeMap` / `RelationshipTypeMap` process plugins apply these at migration time.
3. **Run** — use the module's Drush commands (`src/Commands/CrmMigrateCrmCoreCommands.php`;
   `drush.services.yml`) or standard `drush migrate:*` (migrate_plus). Sources:
   - `crm_core_contact` — reads `crm_core_contact` + `field_data_contact_name` (title, given,
     middle, family, generational, credentials); id = `contact_id`.
   - `crm_core_relationship` — relationship rows.

Source queries use `SqlBase::select()` with bound parameters — safe against SQL injection.
