<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_menu_link_migrate — agent index

Alters core's menu-link migrations so more D7 menu links migrate. Two hooks + a static helper
+ one trap migration definition. No config, routes, permissions, Drush, or plugins. Depends on
`migmag` and `migmag_process`.

- **The hooks, the helper class, and the trap migration** → [api/menu-link.md](api/menu-link.md)

Key facts:
- `hook_migration_plugins_alter()` → `MigMagMenuLinkMigrate::applyMenuLinkMigrationConfigurationFixes()`.
- `hook_migrate_prepare_row()` → `MigMagMenuLinkMigrate::prepareMenuLinkStubMigration()`.
- Ships migration `migmag_unmigratable_menu_link_trap` for links that still can't migrate.
- Effects only manifest when core Migrate runs the menu-link migrations (i.e. during an upgrade).
