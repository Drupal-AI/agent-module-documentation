<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Menu Link Migration (`migmag_menu_link_migrate`) modifies Drupal core's menu-link migrations so that as many source menu links as possible are migrated, including links core would otherwise drop.

---

Core's Drupal 7 → modern-core menu-link migrations silently skip menu links whose route/target can't be resolved (external links, links to not-yet-migrated entities, unrouted paths), leaving gaps in the migrated menus. This submodule fixes that with two hook implementations. `hook_migration_plugins_alter()` calls `MigMagMenuLinkMigrate::applyMenuLinkMigrationConfigurationFixes()` to patch the core menu-link migration definitions so more links survive, and `hook_migrate_prepare_row()` calls `MigMagMenuLinkMigrate::prepareMenuLinkStubMigration()` to help stub the links' targets during the run. It also ships a helper migration definition (`migmag_unmigratable_menu_link_trap`) used to catch links that still can't be migrated. The static helper `MigMagMenuLinkMigrate` also exposes `getSourceMenuLinkData($mlid)` for reading a source menu link's raw data. The module has no configuration, routes, permissions, or Drush commands; it depends on `migmag` and `migmag_process` (it leans on the improved lookup/stub behaviour). Its effects apply when core Migrate builds and runs the menu-link migrations, so it is only relevant on a site performing a Drupal upgrade.

---

- Migrate menu links that core's `d7_menu_links` migration would otherwise skip.
- Preserve external and unrouted menu links during a Drupal 7 → 11 upgrade.
- Keep menu links pointing at entities that are migrated later in the run via better stubbing.
- Reduce manual menu rebuilding after an upgrade by carrying more links across automatically.
- Patch core menu-link migration definitions without editing them by hand.
- Trap genuinely unmigratable menu links with the `migmag_unmigratable_menu_link_trap` migration.
- Read a source menu link's raw data during migration development (`getSourceMenuLinkData`).
- Combine with `migmag_process` lookup/stub improvements for correct link target resolution.
- Improve menu completeness in a large multi-menu D7 site upgrade.
- Avoid losing deep-nested child menu links whose parents migrate as stubs.
- Enable only menu-link fixes without pulling in rollback features.
- Ensure custom menus (not just the main menu) migrate their links.
- Handle links to nodes/terms that are stubbed and later filled in.
- Debug which menu links fail to migrate and why via the trap migration.
- Apply consistent menu-link migration behaviour across an upgrade project.
- Support re-running the upgrade and getting the same, fuller set of menu links.
