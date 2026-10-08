<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `--migrate-debug` / `--migrate-debug-pre` Drush options

Migrate Devel does **not** add new Drush commands; it adds two **options** to the existing
migrate commands (from migrate_tools / migrate_run) and prints row data via an event
subscriber. It has no command of its own — run a normal import with the extra flag.

## The options

| Option | Added to | Dumps (per row) | When |
|---|---|---|---|
| `--migrate-debug` | `migrate:import` (and legacy `migrate-import` / `migrate-status`) | Source, Destination, **DestinationIdValues** | POST_ROW_SAVE (after each row is saved) |
| `--migrate-debug-pre` | `migrate:import` | Source, Destination | PRE_ROW_SAVE (before each row is saved) |

Registration is dual for compatibility:
- **Modern**: `drush.services.yml` → `MigrateDevelCommands` (`@hook command migrate:import`)
  declares `--migrate-debug` and `--migrate-debug-pre`.
- **Legacy**: `migrate_devel.drush.inc` implements `hook_drush_command_alter()` /
  `hook_drush_help_alter()` for `migrate-import` / `migrate-status`.

## Usage

```bash
# Dump each row's source + destination + new destination ids as the migration runs:
drush migrate:import <migration_id> --migrate-debug

# Dump source + destination BEFORE each row is saved:
drush migrate:import <migration_id> --migrate-debug-pre
```

Output is colored, indented VarDumper (`CliDumper`) and only appears under CLI
(`PHP_SAPI === 'cli'`). The subscriber checks `Drush::config()->get('runtime.options')` for the
flag, so it activates only for the invocation that passed it.

## Side effect: config revert (migrate_plus)

When `--migrate-debug` is used, the legacy `.drush.inc` path also:
1. Clears cached migration definitions (`clearCachedDefinitions()`), and
2. If `migrate_plus` **and** `config_update` are enabled, reverts each migration's config
   (`config_update.config_update` → `revert('migration', $id)`) and imports any missing
   migration config — so edits to `migrate_plus.migration.*` YAML are re-read on the next run.

Without `config_update`, it logs "Missing config_update for revert." and skips reverting.

## Which events fire

`MigrationEventSubscriber::getSubscribedEvents()` subscribes:
- `MigrateEvents::PRE_ROW_SAVE` → `debugRowPreSave` (acts on `--migrate-debug-pre`)
- `MigrateEvents::POST_ROW_SAVE` → `debugRowPostSave` (acts on `--migrate-debug`)
