<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MySQL driver for Cross-Schema Queries (dbxschema_mysql) — agent index

Submodule of **[dbxschema](../../../../../db/dbxschema/2.0.x/agent/start.md)**. Registers the `mysql`
`CrossSchema` driver so the cross-schema API works on MySQL. Package *Cross-Schema*. Core `^10 || ^11`.
GPL-2.0-or-later. Version 2.0.0.

**Depends on:** `drupal:mysql` (core MySQL driver) and `dbxschema:dbxschema`. No routes, no
permissions, no config, no UI.

MySQL has no schemas, so this driver treats each separate **MySQL database** reachable through one
connection (same server+port+credentials) as a "schema".

## What it provides (from source)

- **Plugin** `Plugin\CrossSchema\MySql` — `@CrossSchema(id="mysql", driver="mysql")`; `getClass()`
  maps `DatabaseTool`/`Connection`/`Schema` to the classes below.
- **`Database\DatabaseTool`** extends base `DatabaseTool`. Identifier regex `(?=.*\D)[0-9a-zA-Z$_]{1,64}`.
  `getDrupalSchemaName()` returns the `prefix` `db.` part or the configured `database`.
  DDL: `createSchema()`/`dropSchema()` use `CREATE`/`DROP SCHEMA` (synonyms for DATABASE);
  `schemaExists()`/`getSchemaSize()`/`getDatabaseSize()` query `information_schema`;
  `cloneSchema()` shells out `mysqldump "src" | mysql "tgt"` (names via `escapeshellcmd`) run through
  `exec(nohup … &)`; `renameSchema()` = clone-then-drop.
- **`Database\Connection`** — cross-schema `\Drupal\mysql\Driver\Database\mysql\Connection` subclass
  (via `CrossSchemaConnectionTrait`).
- **`Database\Schema`** — cross-schema `mysql` `Schema` subclass (via `CrossSchemaSchemaTrait`);
  validates the schema/database name in its constructor.

## Install behavior

- `dbxschema_mysql_install()`: if the site driver is `mysql`, adds the Drupal database name to
  `dbxschema.settings:reserved_schema_patterns` (`'Drupal installation'`); clears cached plugin defs.
- `dbxschema_mysql_uninstall()` clears cached definitions.

## Usage

Use the base API — `DatabaseTool::getConnection()`, `{n:table}` tokens, schema lifecycle. See
[dbxschema api/connection.md](../../../../../db/dbxschema/2.0.x/agent/api/connection.md) and
[api/database-tool.md](../../../../../db/dbxschema/2.0.x/agent/api/database-tool.md). Cross-querying
requires all databases to share one server+port+credentials.
