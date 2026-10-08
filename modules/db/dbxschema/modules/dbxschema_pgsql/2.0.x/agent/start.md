<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PostgreSQL driver for Cross-Schema Queries (dbxschema_pgsql) — agent index

Submodule of **[dbxschema](../../../../../db/dbxschema/2.0.x/agent/start.md)**. Registers the `pgsql`
`CrossSchema` driver so the cross-schema API works on PostgreSQL. Package *Cross-Schema*. Core
`^10 || ^11`. GPL-2.0-or-later. Version 2.0.0.

**Depends on:** `drupal:pgsql` (core PostgreSQL driver) and `dbxschema:dbxschema`. No routes, no
permissions, no config, no UI.

## What it provides (from source)

- **Plugin** `Plugin\CrossSchema\PostgreSql` — `@CrossSchema(id="pgsql", driver="pgsql")`; `getClass()`
  maps `DatabaseTool`/`Connection`/`Schema` to the classes below.
- **`Database\DatabaseTool`** extends base `DatabaseTool`. PostgreSQL identifier regexes
  `[a-zA-Z_\xA0-\xFF][a-zA-Z_\xA0-\xFF0-9]{0,63}`. DDL: `createSchema()` = `CREATE SCHEMA`,
  `dropSchema()` = `DROP SCHEMA`, `cloneSchema()` calls `pg_temp.dbxschema_clone_schema(src, tgt, TRUE, FALSE)`.
- **`Database\Connection`** — cross-schema `\Drupal\pgsql\Driver\Database\pgsql\Connection` subclass
  (via `CrossSchemaConnectionTrait`).
- **`Database\Schema`** — cross-schema `pgsql` `Schema` subclass (via `CrossSchemaSchemaTrait`);
  validates the schema name in its constructor.
- **`pg-clone-schema/`** — bundled third-party PL/pgSQL clone function (`clone_schema.sql`, its own
  `LICENSE`); loaded on demand, not left installed in the DB.

## Install / update behavior

- `dbxschema_pgsql_install()` (in `.install`): if the site's own connection driver is `pgsql`, adds
  the Drupal schema name (`getDrupalSchemaName()`) to `dbxschema.settings:reserved_schema_patterns`
  with description `'Drupal installation'`; then clears the plugin manager's cached definitions.
- `dbxschema_pgsql_uninstall()` clears cached definitions.
- `dbxschema_pgsql_update_9101()` drops `dbxschema_get_table_ddl` / `dbxschema_clone_schema` functions
  persisted by older versions (now loaded dynamically).

## Usage

Nothing PostgreSQL-specific to call — use the base API (`DatabaseTool::getConnection()`,
`{n:table}` tokens, schema lifecycle). See
[dbxschema api/connection.md](../../../../../db/dbxschema/2.0.x/agent/api/connection.md) and
[api/database-tool.md](../../../../../db/dbxschema/2.0.x/agent/api/database-tool.md).
