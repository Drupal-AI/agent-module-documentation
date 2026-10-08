<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Seven commands (class `MenuMigrationCommands`, `drush.services.yml`). All mutating commands
**prompt for confirmation** — add `-y` to skip. Only `MenuLinkContent` links are handled.

| Command | Alias | Args / options | Does |
|---|---|---|---|
| `menu_migration:export` | `mme` | `<export_type_id>` | Runs a saved Menu Export entity by id. |
| `menu_migration:export-list` | `mmel` | — | Table of Drush-capable Menu Exports. |
| `menu_migration:quick-export` | `mmqe` | `<menus>` (csv), `--format=` | Export menus by id, no entity needed. |
| `menu_migration:import` | `mmi` | `<import_type_id>` | Runs a saved Menu Import entity by id. |
| `menu_migration:import-list` | `mmil` | — | Table of Drush-capable Menu Imports. |
| `menu_migration:quick-import` | `mmqi` | `<menus>` (csv), `--format=` | Import menus by id from the quick dir. |
| `menu_migration:quick-clone` | `mmqc` | `<source_menu> <target_menu>`, `--create-target` | Clone links between menus. |

## Quick commands (no config entity)

`mmqe` / `mmqi` build a transient `ExportType` / `ImportType` in memory using the **Quick
Action Settings** (`menu_migration.quick_export`: `format`, `export_path`). `--format` (values:
`json`, `yaml`, `raw`) overrides the default and is validated against installed Format plugins.

```bash
# Export main + footer to the quick-export codebase dir (default format).
drush mmqe main,footer -y
# Export just main as YAML.
drush mmqe main --format=yaml -y
# Import main back from that dir.
drush mmqi main -y
```

Unknown menu names are skipped with a warning, not an error.

## Clone

`mmqc` uses the `another_menu` destination — it copies the source menu's links into the target
menu (does not delete the source). `--create-target` creates the target menu first if missing.

```bash
drush mmqc main main_backup --create-target -y
```

## Entity-backed commands

`mme` / `mmi` load the `mm_export_type` / `mm_import_type` entity by id and run it; both refuse
ids whose plugin is not CLI-capable (`handleCli()` false) and print the configured destination/
source. `mmel` / `mmil` list only the entities that support Drush.

```bash
drush mmel                 # see available export ids + their destination + command
drush mme main_to_codebase -y
```
