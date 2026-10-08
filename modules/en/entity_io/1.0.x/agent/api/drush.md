<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO — Drush commands

Two Drush command classes registered in `drush.services.yml` (tag `drush.command`):
`src/Commands/EntityManagementCommands.php` and `src/Commands/EntityIoStorageCommands.php`.

## Export / import (`EntityManagementCommands`)

- `entity-io:export` (alias `eioe`) — options `--all`, `--entity-type=`, `--id=`, `--format=`
  (`json`|`gz`|`br`). No options exports one sample per bundle; `--all` exports every entity of the
  supported types; `--entity-type=node --id=123` exports one entity. Delegates to
  `EntityIoExporter::toJson()` (writes files to the configured storage). `--id` requires
  `--entity-type`.
- `entity-io:import` (alias `eioi`) — options `--user=` (uid or username; `account_switcher`
  impersonation), `--entity-type=`. Reads files via `Helper\ExportDirectory::getFiles()` and calls
  `EntityImporter::import()` per file; prints validation warnings.
- `entity-io:import-folder <directory>` (alias `eioif`) — imports every `*.json` in a directory
  after an interactive confirmation. Accepts a filesystem path or a stream wrapper
  (e.g. `public://entity_io_exports`).
- `entity-io:list` (alias `eiol`) — option `--entity-type=`; prints a table of exported files with
  sizes.
- `entity-io:clear-exports` (alias `eioce`) — option `--entity-type=`; deletes generated export
  files via `ExportDirectory::clearFiles()`.

## Storage-table maintenance (`EntityIoStorageCommands`)

Operates on the `entity_io_storage` UUID-map table (constructor arg `@database`):

- `entity-io:storage-list` (alias `eiosl`) — options `--json_uuid=`, `--entity_type=`,
  `--entity_id=`; prints matching rows.
- `entity-io:storage-remove <id>` (alias `eiosr`) — deletes one row by primary key.
- `entity-io:storage-clear` (alias `eiosc`) — truncates the table.

All commands run in the CLI as the site/root account; the export/import behavior is identical to the
UI paths documented in [export.md](export.md) and [import.md](import.md).
