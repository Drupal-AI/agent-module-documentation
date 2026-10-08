<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Drupal 7 source database

Both Drush commands read a legacy **Drupal 7** database. The connection is resolved by
`DataMigrationReportCommands::checkSourceConnection()` (src/Commands/DataMigrationReportCommands.php)
in this order:

1. **`migrate` database key in `settings.php`.** If `Database::getConnection('default', 'migrate')`
   exists, it is used directly as the source connection. Define it the same way `migrate_drupal`
   expects, e.g.:
   ```php
   $databases['migrate']['default'] = [
     'driver' => 'mysql',
     'database' => 'drupal7db',
     'username' => '…',
     'password' => '…',
     'host' => '…',
   ];
   ```
2. **Credentials saved via the form** (State). If no `migrate` key is present, the command reads
   State keys `data_migration_report_database_driver` and `data_migration_report_database`,
   reconstructs the driver namespace by reflection, and opens the connection via
   `MigrationConfigurationTrait::getConnection()`.

If neither is available, the commands log an error linking to the credentials form and abort.

## The credentials form

- Route: `data_migration_report.migrate_database_credentials` →
  `/admin/config/system/data-migration-report-database-credentials`
  (`data_migration_report.routing.yml`), gated by core `_permission: 'administer site configuration'`.
- Class: `\Drupal\data_migration_report\Form\CredentialForm` (extends `FormBase`, uses
  `MigrationConfigurationTrait`), form id `data_migration_report_credentials_form`.
- `buildForm()` renders the standard core installer database-driver widgets:
  `getDatabaseTypes()` calls `Database::getDriverList()->getInstallableList()` and each driver's
  `getInstallTasks()->getFormOptions()`. `database`/`username`/`password` are made conditionally
  required via `#states` on the selected `driver` (sqlite drivers skip username/password).
- `validateForm()` builds a settings array like `settings.php` (adds `namespace`/`driver`),
  runs the driver's `validateDatabaseSettings()`, then attempts `getConnection($database)` — a
  failed connection surfaces the server error to the admin.
- `submitForm()` persists the driver and the selected driver's settings array into **State**
  (`data_migration_report_database_driver`, `data_migration_report_database`). Note: values are
  stored in State (the `key_value` table), not in exportable config.

`checkSourceConnection()` also reads `data_migration_report_database['prefix']` in
`getDestinationMapping()` to trim generated `migrate_map_*` table names to 63 chars.

## Requirements to actually run a report

The destination-side diff relies on `migrate_drupal`'s `migrate_map_*` tables
(`migrate_map_d7_node_complete__<bundle>`, `migrate_map_d7_user`, `migrate_map_d7_user_role`,
`migrate_map_d7_taxonomy_vocabulary`, etc.). Run the actual `migrate_drupal` import first; this
module only verifies its results.
