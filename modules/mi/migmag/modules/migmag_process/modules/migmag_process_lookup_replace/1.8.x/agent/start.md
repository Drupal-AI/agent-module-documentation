<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_process_lookup_replace — agent index

Glue module. One `hook_migrate_process_info_alter()` implementation that sets the core
`migration_lookup` process plugin's `class` to `MigMagLookup` (from `migmag_process`). No
config, routes, permissions, Drush, or plugins of its own. Depends on `migmag_process`.

- **How the override works & how to verify it** → [api/override.md](api/override.md)

Verify at runtime:
`\Drupal::service('plugin.manager.migrate.process')->getDefinition('migration_lookup')['class']`
→ `Drupal\migmag_process\Plugin\migrate\process\MigMagLookup` when enabled (core
`Drupal\migrate\Plugin\migrate\process\MigrationLookup` when not).
