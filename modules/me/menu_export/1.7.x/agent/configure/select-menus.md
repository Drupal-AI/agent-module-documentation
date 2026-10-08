<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select menus and export/import (admin)

There is no `configure` route in info.yml, but the module ships an admin section at a fixed
path with three tabs. All require the **`export and import menu links`** permission.

## Routes / tabs

| Route | Path | Form | Purpose |
|---|---|---|---|
| `menu_export.config_form` | `/admin/config/development/menu_export` | `MenuExportConfigurationForm` | "Menu List": choose which menus to export (checkboxes). Saving also snapshots the links into `menu_export.export_data`. |
| `menu_export.export` | `/admin/config/development/menu_export/export` | `MenuExportForm` | "Export": button that (re)writes `menu_export.export_data` from the selected menus. |
| `menu_export.import` | `/admin/config/development/menu_export/import` | `MenuImportForm` | "Import": button that recreates/updates the links from `menu_export.export_data`. |

Menu link: under *Structure* (`system.admin_structure`) → "Menu Export".

## Config objects (no schema shipped)

- **`menu_export.settings`** → key `menus`: an array of menu machine names selected for export
  (e.g. `['main', 'footer']`).
- **`menu_export.export_data`** → the exported payload: each selected menu's
  `menu_link_content` entities, serialized as arrays of field values (includes `uuid`,
  `menu_name`, `title`, `link`, `weight`, `parent`, etc.). Written by export, consumed by
  import.

```bash
# which menus are selected for export:
drush config:get menu_export.settings menus
# inspect the exported payload:
drush config:get menu_export.export_data
```

Set the selection programmatically:

```php
\Drupal::configFactory()->getEditable('menu_export.settings')
  ->set('menus', ['main'])->save();
```

## Flow (source → target)

1. **Source:** open Menu List, tick the menus, **Save** (this selects them and snapshots
   links). Or set `menu_export.settings` `menus` and run the export (Export tab or
   `drush menu_export:export`).
2. `drush config:export` — `menu_export.export_data` now travels with your config.
3. **Target:** `drush config:import`, then open the Import tab (or
   `drush menu_export:import`) to recreate/update the `menu_link_content` entities.

## Caveats

- Import matches existing links by **UUID** (updates in place); links whose `menu_name` does
  not exist on the target are reported as invalid and skipped — create the menu container
  first (core config manages containers).
- Only **content** menu links are handled; links defined in modules' `*.links.menu.yml` are
  not.
- See [../drush/commands.md](../drush/commands.md) for the CLI equivalents.
