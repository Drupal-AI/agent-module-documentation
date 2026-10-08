<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/MenuExportDrushCommands.php` (registered via `drush.services.yml`,
tag `drush.command`). Both operate on the same config the admin forms use.

## `menu_export:export`

```bash
drush menu_export:export
# aliases: menu-export-export, menu_export-export
```

Serializes every `menu_link_content` entity in the menus listed in
`menu_export.settings` `menus` into the **`menu_export.export_data`** config object (clearing
it first). Prints "Menu(s) exported successfully"; throws if nothing was exported (e.g. no
menus selected). Run this **before** `drush config:export` so the link data is committed with
your config.

Prerequisite: the menus must already be selected — set them via the Menu List admin form or:

```bash
drush php:eval "\Drupal::configFactory()->getEditable('menu_export.settings')->set('menus', ['main'])->save();"
```

## `menu_export:import`

```bash
drush menu_export:import
# aliases: menu-export-import, menu_export-import
```

Reads `menu_export.export_data` and creates/updates each `menu_link_content` entity, matching
on **UUID** (so re-imports update in place, not duplicate). Prints "Menu(s) imported
successfully"; if any link's target `menu_name` does not exist it throws with the list of
missing menus. Run this **after** `drush config:import` on the target site.

## Typical deploy pipeline

```bash
# source:
drush menu_export:export      # snapshot content menu links into menu_export.export_data
drush config:export -y        # commit config (incl. menu_export.export_data)

# target (after pulling config):
drush config:import -y        # bring in menu_export.export_data (+ menu containers)
drush menu_export:import      # materialize the menu_link_content entities
```

Notes: only **content** menu links are handled; ensure the target menu containers exist
first (managed by core config). See [../configure/select-menus.md](../configure/select-menus.md).
