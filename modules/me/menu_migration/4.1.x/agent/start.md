<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu migration — agent index

Imports/exports/clones **MenuLinkContent** menu trees between sites or menus. Two config
entity types (`mm_export_type`, `mm_import_type`) pick a plugin (destination/source) + format
+ menus; a service does the tree read/rebuild. Admin UI at
`/admin/config/development/menu-migration` (configure route `menu_migration.menu_migration`).
Only manually-created `menu_link_content` links are handled — Views/taxonomy/dynamic links are ignored.

- **Config entities + Quick Action Settings (settings keys, drush-scriptable creation)** →
  [configure/entities.md](configure/entities.md)
- **Seven Drush commands (export/import/list + quick export/import/clone)** →
  [drush/commands.md](drush/commands.md)
- **Plugin types: ExportDestination, ImportSource, Format (attributes + how to add one)** →
  [plugins/plugins.md](plugins/plugins.md)
- **Permissions (5) and what they gate** → [permissions/permissions.md](permissions/permissions.md)
- **Service API (`menu_migration.import_export`) + `MenuImportEvent` for rewriting items** →
  [api/service-events.md](api/service-events.md)

Key facts: destinations `codebase` / `download` / `another_menu`; sources `codebase` /
`file_upload`; formats `json` / `yaml` / `raw`. Quick commands (`mmqe`/`mmqi`/`mmqc`) create a
transient entity in memory so you can export/import/clone by menu ID with no saved config.
