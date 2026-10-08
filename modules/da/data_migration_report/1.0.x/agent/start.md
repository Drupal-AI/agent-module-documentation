<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Migration Report (data_migration_report) — agent index

Drush-driven verifier for Drupal 7 → Drupal 10/11 migrations. Generates content-mapping YAML
from the D7 source database and diffs migrated destination rows against the source, emitting a
console summary and an HTML report. Built on `migrate_drupal` and its `migrate_map_*` tables.

- **Type:** module. **Package:** Migration. **Core:** `^10.3 || ^11`.
- **Dependencies (Drupal):** `migrate_drupal` (core). No Composer library deps.
- **Provides:** two Drush commands, one admin form/route, one theme hook, a preprocess function.
  No permissions of its own, no config entities, no config schema, no plugin types. The source
  DB connection is stored in **State** (`data_migration_report_database`,
  `data_migration_report_database_driver`), not config.

## Drush commands (`drush.services.yml` → `DataMigrationReportCommands`)
- `generate:content-mapping` (alias `gcm`) — scans the D7 source DB, writes per-entity/bundle
  YAML to `public://data_migration_report/migration-mapping/<entity_type>/`.
- `migration:test <entity_type> <bundle>` (alias `mt`) — options `--limit`, `--ids`; loads the
  mapping YAML, compares source vs destination, prints a summary table, writes an HTML report to
  `public://data_migration_report/migration-reports/<entity_type>/`.
- Supported source types: `user`, `node`, `taxonomy_term`, `block_custom`, `comment`,
  `menu_links`, `url_alias`, `file`, `file_private`, `field_collection_item`, `paragraphs_item`.

## Route / form
- `data_migration_report.migrate_database_credentials` →
  `/admin/config/system/data-migration-report-database-credentials`,
  `_form: \Drupal\data_migration_report\Form\CredentialForm`,
  `_permission: 'administer site configuration'`. Menu link under System config
  (`data_migration_report.links.menu.yml`). This is the `configure` route.

## Theme / data
- `hook_theme()` defines `migration_report` (template `templates/migration-report.html.twig`);
  `template_preprocess_migration_report()` builds the per-field error-count arrays.
- `field_types.yml` — D7 and D10 field-type → column-name maps consumed by
  `getFieldTypeColumnMapping()`.

## Solution docs
- [Configure the source database](config/source-database.md) — `migrate` key vs the credentials
  form, State storage, `checkSourceConnection()`.
- [Drush commands & workflow](drush/commands.md) — `gcm` / `mt`, mapping YAML shape, the diff
  algorithm, preprocessors, report output.
