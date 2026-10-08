<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Info (database_info_schema) — agent index

Developer/DBA tool that reports on the site's **own** database (MySQL/MariaDB): database name,
collation, total size, table list with row counts and sizes, and per-table columns and indexes.
Exposed as a **Drush command** and two **admin web pages**. info.yml name is
*"Database Info Drush Command"*. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.3.1. **No dependencies, no permissions of its own, no config form, no config schema.**

## What it actually is

- **Model** — `src/Model/DbModel.php` (`DbModel`), the only logic. Methods:
  `get_db_name()` (name + total size MB from `information_schema.TABLES`), `get_colletion()`
  (default charset/collation from `INFORMATION_SCHEMA.SCHEMATA`), `get_db_tables()` (table list
  with size + row count, sorted by size), `get_table_details($tableName)` (columns via
  `DESCRIBE`, row count, indexes via `SHOW INDEX`).
- **Web routes** — `database_info_schema.routing.yml`, controller
  `src/Controller/IndexController.php` (`IndexController` extends `ControllerBase`). Both routes
  require the `access content` permission. Renders Drupal `#type => table` render arrays.
- **Drush command** — `drush.services.yml` registers `src/Commands/DatabaseCommands.php`
  (`DatabaseCommands`, service `db_info.commands`); command `db:info` (alias `dbi`).
- **Menu link** — `database_info_schema.links.menu.yml` adds "Database Information" under
  `system.admin_config_system`, pointing at the report route.
- `database_info_schema.module` is empty (no hooks). No `*.permissions.yml`, no `config/`.

## Solution docs

- **Web pages, routes, controller and the DbModel queries** → [api/pages.md](api/pages.md)
- **The `drush db:info` / `dbi` command** → [api/drush.md](api/drush.md)
