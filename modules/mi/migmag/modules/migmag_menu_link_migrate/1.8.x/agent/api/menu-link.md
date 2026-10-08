<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_menu_link_migrate — hooks & helper

## Hooks (`migmag_menu_link_migrate.module`)

- **`hook_migration_plugins_alter(array &$migrations)`** →
  `MigMagMenuLinkMigrate::applyMenuLinkMigrationConfigurationFixes($migrations, TRUE)`. Patches
  the core menu-link migration definitions so as many links as possible migrate (the second
  arg `TRUE` = "migrate as much as possible").
- **`hook_migrate_prepare_row(Row $row, MigrateSourceInterface $source, MigrationInterface $migration)`**
  → `MigMagMenuLinkMigrate::prepareMenuLinkStubMigration($row, $migration)`. Assists stubbing of
  link targets while rows are processed.

## Helper class `Drupal\migmag_menu_link_migrate\MigMagMenuLinkMigrate`

Static methods:
- `applyMenuLinkMigrationConfigurationFixes(array &$migrations, bool $migrateAsMuchAsPossible = FALSE): void`
- `prepareMenuLinkStubMigration(Row $row, MigrationInterface $migration): void`
- `getSourceMenuLinkData($mlid): ?array` — raw source menu-link data by menu link id.

## Trap migration

Ships `migrations/migmag_unmigratable_menu_link_trap.yml` — a migration that catches menu links
which still cannot be migrated, so they are recorded rather than silently lost.

## Notes for this site

The **effects require the core migration plugin manager to enumerate/run migrations**. On this
Drupal 11 site that manager cannot list definitions (an unrelated pathauto issue), so you cannot
observe the altered menu-link migrations here without fixing that; the module's presence
(enabled state + dependency on `migmag_process`) is still inspectable. No configuration exists.
