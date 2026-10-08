<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Export — agent index

Exports/imports **content** menu links (`menu_link_content` entities) between sites via
config. Fills the gap where core Configuration Management syncs menu containers but not the
links inside them. No `configure` route in info.yml (the admin form is at a fixed path). One
permission, two Drush commands, no plugins, no config schema.

- **Admin flow, config objects (`menu_export.settings`, `menu_export.export_data`), routes** →
  [configure/select-menus.md](configure/select-menus.md)
- **Drush commands (`menu_export:export`, `menu_export:import`) & the deploy workflow** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Admin: `/admin/config/development/menu_export` (Menu List / Export / Import tabs), all gated
  by permission **`export and import menu links`**.
- `menu_export.settings` → `menus` = array of menu machine names selected for export.
- `menu_export.export_data` → the serialized `menu_link_content` entities (keyed by link),
  written on export and read on import (matched by **UUID** so re-import updates in place).
- Exports **custom/content** links only, not `*.links.menu.yml` module links.
