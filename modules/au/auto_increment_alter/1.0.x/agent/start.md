<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AUTO_INCREMENT Alter (auto_increment_alter) — agent index

Alters the **AUTO_INCREMENT (next-ID) value of MySQL tables** and of content-entity base/revision
tables. Purpose: avoid entity-ID collisions on Drupal upgrades/migrations. Package `Other`.
Depends only on core **`mysql`**. Core requirement `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0-alpha5. **MySQL only** — no-ops (logs an error) on any other driver.

- **Admin UI, routes, permission, the service API, and Drush commands** →
  [api/service-and-commands.md](api/service-and-commands.md)
- **The `$settings[...]` arrays for bulk operations** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service: **`auto_increment_alter.mysql`** = `AutoIncrementAlterMysql` (final, extends
  abstract `AutoIncrementAlter`, implements `AutoIncrementAlterInterface`), in
  `src/AutoIncrementAlterMysql.php`. Constructor args: `@database`, `@entity_type.manager`,
  a dedicated logger channel `logger.channel.auto_increment_alter`, and `@settings`.
- One controller `AutoIncrementAlterController::listTables()` (read-only table listing) and four
  forms in `src/Form/`: `AutoIncrementAlterTableForm`, `AutoIncrementAlterContentEntityForm`
  (plain `FormBase`), `AutoIncrementAlterTablesForm`, `AutoIncrementAlterContentEntitiesForm`
  (`ConfirmFormBase`, settings-driven).
- One Drush command file `src/Drush/Commands/AutoIncrementAlterCommands.php` — 8 commands.
- One permission **`administer auto_increment table values`** (`restrict access: true`) gates all
  five routes. No config objects, **no config schema**, no plugins, no hooks except
  `hook_help()`.

## Routes (all require `administer auto_increment table values`)

Base path `/admin/config/development/auto-increment-alter`:

- `auto_increment_alter.list_tables` (`` `` , also the `configure` link) → controller list of every
  table + its AUTO_INCREMENT value; each row links to the single-table form with `?name=<table>`.
- `.../table` → `AutoIncrementAlterTableForm` (single table).
- `.../content-entity` → `AutoIncrementAlterContentEntityForm` (single content entity).
- `.../tables` → `AutoIncrementAlterTablesForm` (confirm; bulk from settings).
- `.../content-entities` → `AutoIncrementAlterContentEntitiesForm` (confirm; bulk from settings).

## Mechanism (from source)

- The actual DDL is in `AutoIncrementAlterMysql::alterTableAutoIncrement()`: optionally checks
  `schema()->tableExists()`, rejects negative values, then runs an
  `ALTER TABLE {<table>} AUTO_INCREMENT = <value>` statement via `$this->database->query()` and
  logs the outcome. Read side uses `information_schema.tables` (parameterized on the schema name)
  and `SHOW TABLES`.
- Content-entity methods resolve `getBaseTable()` / `getRevisionTable()` from
  `entity_type.manager`; entities absent from the install are filtered out and logged.
- Every public method first calls `isDatabaseTypeSupported()` and returns early (logging an error)
  when the driver is not `mysql`.

## Notes

- Bulk operations read only from **`settings.php`** arrays (`auto_increment_alter_tables`,
  `auto_increment_alter_content_entities`) — not from Drupal config. See
  [config/settings.md](config/settings.md).
- Alpha software (`minimum-stability: dev`). Setting a value below a table's current max IDs will
  cause duplicate-key errors on the next insert; this is an intended low-level maintenance tool.
