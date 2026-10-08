<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command — `db:info` (alias `dbi`)

## Registration

`drush.services.yml` registers the command class:

```yaml
services:
  db_info.commands:
    class: \Drupal\database_info_schema\Commands\DatabaseCommands
    arguments: ['@database']
    tags:
      - { name: drush.command }
```

`src/Commands/DatabaseCommands.php` — `DatabaseCommands extends DrushCommands`. The constructor
receives the core `Connection` (`@database`) but then builds its own `new DbModel()` into
`$this->db_model` (the injected connection is not otherwise used). This is the classic annotated
(services-file) Drush command style, so it works under Drush that supports `drush.services.yml`.

## Command

- **`@command db:info`**, **`@aliases dbi`**.
- Signature: `getDbInfo($tableName = NULL)`.
  - No argument → `showGeneralInfo()`.
  - With a table name → `showTableDetails($tableName)`.

### `drush db:info` (no argument) — `showGeneralInfo()`

Calls `DbModel::get_db_name()`, `get_colletion()`, `get_db_tables()` and prints:

- `DB Name`, `DB Collation`, `DB Size` (`%.2f MB`) as `writeln` lines.
- A titled table "Table List" via `io()->table(['Table','Rows','Size (MB)'], $table_rows)`.
- (The name/collation/size lines are printed a second time after the table — a source quirk.)

### `drush db:info <table>` (e.g. `drush db:info users`) — `showTableDetails($tableName)`

Calls `DbModel::get_table_details($tableName)` and prints:

- Title `Table: <name>`.
- Section "Table Structure" → `io()->table(['Field Name','Type','Null','Key','Default'], columns)`.
- Section "Indexes" → `io()->table(['Name','Column','Unique','Type'], indexes)`.

## Notes

- All data comes from `DbModel` (see [pages.md](pages.md) for the exact queries); the CLI and web
  paths share that model.
- Documented usage examples in the annotation: `drush db:info` and `drush db:info users`.
- MySQL/MariaDB only (uses `INFORMATION_SCHEMA`, `DESCRIBE`, `SHOW INDEX`).
