<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Migration — agent index

Migrates Drupal 6/7 Views into D10/11 `view` config entities (core's migrate_drupal skips
Views). Built on migrate_plus + migrate_tools. **No permissions, no config schema, no own
Drush commands, no `configure` route.**

- **The shipped migrations, source DB setup, running them, "Views ID List"/idlist** →
  [configure/migrations.md](configure/migrations.md)
- **The 21 handler plugin types and how to add a custom migrate-views handler** →
  [plugins/handlers.md](plugins/handlers.md)

Key facts:
- Migrations: `d7_views_migration`, `d6_views_migration`, in migration group **`views_migration`**
  (config `migrate_plus.migration.*`, `migrate_plus.migration_group.views_migration`).
- Source plugins: `d7_views_migration`, `d6_views_migration`. Destination plugin: **`entity:view`**
  (a `@MigrateDestination` override that writes Views config entities).
- Run via migrate_tools: `drush migrate:import d7_views_migration` (also `:status`, `:rollback`,
  `--idlist=<vid,vid>`, `--update`). A form alter adds a **"Views ID List"** field to the
  migrate_tools execute form for this group.
- Extensible: 21 plugin managers `plugin.manager.migrate.views.<type>`; annotations
  `@MigrateViews<Type>`; each type has a default plugin `d7_default`; custom plugins live in
  `Plugin/migrate/views/<type>/d7/` and implement `alterHandlerConfig()`.
- Requires a configured D7/D6 **source database** (via the core Upgrade / migrate_upgrade flow).
