<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Migration (block_migration) — agent index

Drush-only tool that exports/imports custom `block_content` entities (with all translations) as YAML between Drupal sites. Version **1.0.0**, core `^10 || ^11`, package `Migration`. No web routes, no permissions, no admin UI, no config.

**Dependencies:** core `block_content`, contrib `single_content_sync` (`^1.4`; YAML-format compatibility — entity creation is done directly by this module).

**Provides:**
- Service `block_migration.exporter` → `Drupal\block_migration\Service\BlockContentExporter` (args: `@entity_type.manager`, `@language_manager`).
- Drush command class `Drupal\block_migration\Commands\BlockMigrationCommands` (tagged `drush.command`), registered in both `drush.services.yml` and `block_migration.services.yml`.
- Two Drush commands:
  - `block-migration:export-blocks` (aliases `bm-export`, `bm:export-blocks`)
  - `block-migration:import-blocks` (aliases `bm-import`, `bm:import-blocks`)

**Note on duplicate files:** the project ships stray twin files `civigo_blocks_migration.info.yml` and `civigo_blocks_migration.services.yml` (a rename leftover) that duplicate the `block_migration` definitions. Only `block_migration` is the enabled module; there is no submodule tree.

**Solution docs:**
- [Drush commands (export/import)](commands/drush.md) — command signatures, options, filtering, import UUID grouping.
- [Export service & YAML format](api/exporter.md) — `BlockContentExporter`, field-type serialization, YAML schema.
