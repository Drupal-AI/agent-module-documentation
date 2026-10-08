# Configuration

Menu Export is used, not really "configured" — there is no options form with lots of
settings. Instead you work through three tabs under **Structure → Menu Export**
(`/admin/config/development/menu_export`), all gated by the **Export and import menu
links** permission.

## The three tabs

- **Menu List** — tick the checkboxes for the menus you want to export (for example
  *Main navigation* and *Footer*). Saving records your selection **and** takes a
  fresh snapshot of the links in those menus.
- **Export** — a button that re‑writes the exported snapshot from your selected
  menus. Use it when you have edited links since your last save on the Menu List
  tab.
- **Import** — a button that recreates or updates the links on the current site from
  the exported snapshot.

Behind the scenes, your menu selection is stored in the `menu_export.settings`
configuration object, and the serialized links are stored in
`menu_export.export_data`. Because the second one is config, it travels with a normal
`drush config:export`.

## The deploy workflow (source → target)

The whole point is to carry hand‑built menu links through your normal config
pipeline:

**On the source site (e.g. dev):**

1. Open **Menu List**, tick the menus you want, and click **Save** — this selects
   them and snapshots their links.
2. Run `drush config:export` so `menu_export.export_data` is committed with the rest
   of your configuration.

**On the target site (e.g. production), after pulling the config:**

3. Run `drush config:import` to bring in `menu_export.export_data` (and any menu
   containers).
4. Open the **Import** tab and click the import button to materialize the links.

## Doing it from Drush

The two Drush commands do exactly what the Export and Import tabs do, which is handy
for CI:

```bash
# Source: snapshot the selected menus' links into config, then export config
drush menu_export:export      # aliases: menu-export-export, menu_export-export
drush config:export -y

# Target: import config, then materialize the menu links
drush config:import -y
drush menu_export:import      # aliases: menu-export-import, menu_export-import
```

`menu_export:export` requires that you have already selected menus (via the Menu List
tab). If you would rather set the selection from the command line:

```bash
drush php:eval "\Drupal::configFactory()->getEditable('menu_export.settings')->set('menus', ['main'])->save();"
```

You can also inspect what is selected and what will be deployed:

```bash
drush config:get menu_export.settings menus     # which menus are selected
drush config:get menu_export.export_data        # the serialized link payload
```

## Things to watch out for

- **Re‑imports update, they don't duplicate.** Links are matched by UUID, so running
  the import again refreshes existing links rather than creating copies.
- **The menu container must exist on the target first.** If a link points at a menu
  that is not present, it is reported as invalid and skipped. Core configuration
  management handles the menu containers, so let a normal `config:import` create them
  before you run the menu import.
- **Only content menu links are handled** — the links you create in the admin UI.
  Links that modules define in code (`*.links.menu.yml`) are managed by those modules
  and are not part of the export.
