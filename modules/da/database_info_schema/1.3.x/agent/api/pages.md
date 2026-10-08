<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web report pages, routes, controller and DbModel

## Install / enable

`drush en database_info_schema -y`. No dependencies, no configuration step. A menu link
"Database Information" (`database_info_schema.links.menu.yml`) appears under
Administration » Configuration » System (`system.admin_config_system`).

## Routes (`database_info_schema.routing.yml`)

| Route id | Path | Controller method | Requirement |
|----------|------|-------------------|-------------|
| `database_info_schema.content` | `/admin/database/info` | `IndexController::generate_report` | `_permission: 'access content'` |
| `database_info.table.content` | `/admin/database/table/{tablename}` | `IndexController::generate_table_report` | `_permission: 'access content'` |

Both routes declare `_permission: 'access content'`. There is no `*.permissions.yml`, so the
module defines no permission of its own.

## Controller — `src/Controller/IndexController.php`

`IndexController extends ControllerBase`. It instantiates `new DbModel()` directly (no DI) and
builds Drupal render arrays.

- `generate_report()` — calls `DbModel::get_db_name()`, `get_colletion()`, `get_db_tables()`.
  Renders `#type => item` lines for database name, collation and size, then a `#type => table`
  of `[table, rows, size, View Details link]`. Each "View Details" link is built with
  `Url::fromRoute('database_info.table.content', ['tablename' => $table['table']])`.
- `generate_table_report($tablename)` — calls `DbModel::get_table_details($tablename)` and renders
  the row count plus two `#type => table` blocks: **Fields** (`['Field Name','Type','Null','Key','Default']`)
  and **Indexes** (`['Name','Column','Unique','Type']`). The `{tablename}` route parameter is
  passed to the model unchanged.

## Model — `src/Model/DbModel.php` (`DbModel`)

Constructed with `Database::getConnection()` into `$this->database`. Targets MySQL/MariaDB
system schema. Methods:

- `get_db_name()` — reads the connection's `database` option; runs
  `SELECT SUM(data_length + index_length)/1024/1024 AS size_mb FROM information_schema.TABLES
  WHERE table_schema = :db_name`. Returns `['database_name' => ..., 'database_size' => ...]`.
- `get_colletion()` (sic) — `SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME FROM
  INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = :db_name` (`fetchField`).
- `get_db_tables()` — `SELECT table_name, (data_length+index_length)/1024/1024 AS size_mb,
  table_rows FROM information_schema.TABLES WHERE table_schema = '<db_name>' ORDER BY size_mb DESC`;
  returns rows of `['table','rows','size']` (size `%.2f`). `<db_name>` comes from the connection
  options set by the preceding `get_db_name()`/`get_colletion()` call.
- `get_table_details($tableName)` — runs `describe <tableName>`, `select count(*) as total_rows
  from <tableName>`, and `SHOW INDEX FROM <tableName>` (the last wrapped in try/catch). Returns
  `['rows' => int, 'columns' => [...], 'indexes' => [...]]`. Columns map `Key === 'PRI'` to
  `Primary`; indexes map `Non_unique == 0` to `Yes (Unique)`.

## Operating notes

- The pages report on the **active Drupal database connection** only; there is no connection or
  target selector.
- Output is Drupal core `#theme => table` render arrays — no custom template, JS or CSS library.
- Table sizes are `(data_length + index_length)` in MB; `table_rows` for InnoDB is the engine's
  estimate, not an exact count (the per-table page's "Total Rows" uses `count(*)` and is exact).
