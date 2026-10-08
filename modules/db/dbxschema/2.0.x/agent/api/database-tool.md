<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DatabaseTool: schema lifecycle, name validation & reservations

Source: `src/Database/DatabaseTool.php` (abstract), `src/Database/DatabaseToolFactory.php`,
`src/Database/DatabaseToolInterface.php`, and the per-driver overrides in
`modules/dbxschema_{pgsql,mysql}/src/Database/DatabaseTool.php`.

`DatabaseTool` is the driver-agnostic toolbox. The abstract base implements the driver-independent
logic (reservations, validation dispatch, `parseTableDdl()`); each driver subclass supplies the DDL.

## Obtaining a tool

```php
use Drupal\dbxschema\Database\DatabaseTool;

$tool = DatabaseTool::getDatabaseTool();              // default driver (site connection)
$tool = DatabaseTool::getDatabaseTool('pgsql');       // by driver name
$tool = DatabaseTool::getDatabaseTool($connection);   // from a Connection object
```

Or the container: service `dbxschema.tool` (factory `DatabaseTool::getDatabaseTool`), and
`dbxschema.tool.factory` → `DatabaseToolFactory::get($connection)` which returns the right driver tool
for a given connection. If no `CrossSchema` plugin matches the driver, a `DatabaseToolException`
(wrapped as `PluginException`) is thrown — the hint reminds you to enable the driver submodule.

## Schema lifecycle (each takes an optional `?CrossSchemaConnectionInterface $db`)

- `schemaExists(string $schema_name): bool`
- `createSchema(string $schema_name): void` — PostgreSQL `CREATE SCHEMA`; MySQL `CREATE SCHEMA`
  (synonym for `CREATE DATABASE`).
- `cloneSchema(string $source, string $target): void` — PostgreSQL uses the bundled
  `pg-clone-schema` function (`pg_temp.dbxschema_clone_schema(...)`, loaded per query from
  `clone_schema.sql`); MySQL shells out to `mysqldump | mysql`. Target must not already exist.
- `renameSchema(string $old, string $new): void` — MySQL implements this as clone-then-drop.
- `dropSchema(string $schema_name): void` — PostgreSQL `DROP SCHEMA`; MySQL `DROP SCHEMA`.
- `getSchemaSize(string $schema_name): int` — size in bytes.
- `getDatabaseSize(): int`.

The same lifecycle is also reachable from a connection's schema object:
`$xconn->schema()->createSchema()` / `->cloneSchema($src)` / `->renameSchema($new)` / `->dropSchema()`
(the `CrossSchemaSchemaInterface` variants operate on the connection's own schema name).

These are **privileged DDL/administrative operations** meant to be invoked from trusted PHP with
developer-controlled schema names — the module ships no route, form or permission that exposes them.
Validate any externally-influenced name with `isInvalidSchemaName()` before use (see below).

## Name validation

- `isInvalidSchemaName(string $name, bool $ignore_reservation = FALSE, bool $reload_config = FALSE): string`
  — returns an **empty string when valid**, otherwise a human-readable reason. Driver subclasses first
  check length (< 64) and the driver identifier regex, then delegate to the base for reservation checks.
- Identifier regexes (driver constants):
  - PostgreSQL: `SCHEMA_NAME_REGEXP` / `TABLE_NAME_REGEXP` = `[a-zA-Z_\xA0-\xFF][a-zA-Z_\xA0-\xFF0-9]{0,63}`
    (lowercase-oriented, no `$`, must not start with a digit / `pg_`).
  - MySQL: `(?=.*\D)[0-9a-zA-Z$_]{1,64}` (must not be all-numeric).
- `getDrupalSchemaName(): string` — the Drupal install's own schema/database name (PostgreSQL: current
  schema; MySQL: the configured database or the `prefix` `db.` part).

## Schema-name reservation registry

Backed by `dbxschema.settings:reserved_schema_patterns` (see [../config/settings.md](../config/settings.md)).
Patterns support `*` wildcards and bare regex (a `*` not preceded by `.` becomes `.*`). Static per class.

- `reserveSchemaPattern(string $pat_regex, string $description = '')` — throws on an empty/invalid pattern.
- `getReservedSchemaPattern(): array`
- `isSchemaReserved(string $schema_name)` — returns matched `[pattern => description]` or `FALSE`.
- `freeSchemaPattern(string $pat_regex, bool $free_all_matching = FALSE): array`
- `initSchemaReservation(bool $reload = FALSE)` — (re)loads patterns from config.

Both driver submodules seed the Drupal install's own schema name into the reservation list at install
(`dbxschema_{pgsql,mysql}_install()`), so tooling won't overwrite it. Default config also reserves
`_test*`.

## `parseTableDdl(string $table_ddl): array`

Parses a `CREATE TABLE` DDL string (as produced by the driver's table-DDL helper) into
`['columns' => …, 'constraints' => …, 'indexes' => …, 'dependencies' => …]`, extracting foreign-key
dependencies. Used by `getSchemaDef()` on the schema object to return a schema in `SQL` / `Drupal`
Schema-API / parsed formats.

## Exceptions

`DatabaseToolException`, `ConnectionException`, `SchemaException`, `CrossSchemaException`
(all under `src/Exception/`).
