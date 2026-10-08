A developer API that extends Drupal's database layer so a single SQL query can span several PostgreSQL schemas (or, with MySQL, several databases on one server) sharing one connection.

---

Database Cross-Schema Queries (`dbxschema`) is a pure API/framework module: it ships no routes, no permissions, no forms and no admin UI. It defines a `CrossSchema` plugin type (a per-database-driver implementation contract) plus a set of interfaces, traits, a `DatabaseTool` service and a cross-schema `Connection` that subclass Drupal's own `\Drupal\Core\Database\Connection`/`Schema`. You obtain a cross-schema connection with `DatabaseTool::getConnection($schema_name)`, add further schemas with `addExtraSchema()`, and then use the connection exactly like a normal Drupal connection — with one extra table-token syntax: `{1:table}`, `{2:table}`, … where the number selects which schema the table lives in (`0` = Drupal's own schema, `1` = the connection's current schema, `2+` = extra schemas). The base module is database-agnostic and does nothing useful alone; you must also enable at least one driver submodule — `dbxschema_pgsql` (PostgreSQL schemas) or `dbxschema_mysql` (treats separate MySQL databases as schemas). Because it builds on Drupal's connection object, parameter binding, prefixing and the schema API all keep working. Cross-querying only works when every schema/database is reachable through one connection (same host, port and credentials); an extra database defined as its own key in `settings.php` can be targeted, but you cannot then join it against Drupal's own tables. Beyond querying, the `DatabaseTool` offers schema lifecycle helpers (create / clone / rename / drop / size), a schema-name reservation registry (config `dbxschema.settings`), and schema-name/table-name validation. Note: version 2.0.x drops support for per-table prefixing in `settings.php`.

---

- Join a Drupal `node` table against tables held in a separate PostgreSQL schema in one query.
- Query two or more non-Drupal PostgreSQL schemas together in a single `SELECT` with the standard Drupal query builder.
- Treat several MySQL databases on the same server as "schemas" and cross-query them from Drupal.
- Run a Drupal site on PostgreSQL while reading data from a separate MySQL database configured as an extra `settings.php` connection key.
- Back an "External Entities" storage with data living in a non-Drupal schema.
- Obtain a ready-to-use cross-schema connection with `\Drupal\dbxschema\Database\DatabaseTool::getConnection('myschema')`.
- Add extra schemas to an existing cross-connection at runtime via `$conn->addExtraSchema('otherschema')` and reference them as `{2:table}`.
- Pin an extra schema to a specific index with `setExtraSchema('otherschema', 3)` for stable `{3:table}` tokens.
- Use `useCrossSchemaFor($object)` so a service's plain `{table}` tokens resolve against the connection's schema instead of Drupal's default.
- Programmatically create a new schema/database with `DatabaseTool::createSchema()` or `$conn->schema()->createSchema()`.
- Clone an entire schema (PostgreSQL, via a bundled `pg-clone-schema` SQL function) or database (MySQL, via `mysqldump`) with `cloneSchema()`.
- Rename a schema/database with `renameSchema()`.
- Drop a schema/database with `dropSchema()`.
- Check whether a schema exists before operating on it via `schemaExists()`.
- Measure the on-disk size of a schema (`getSchemaSize()`) or the whole database (`getDatabaseSize()`).
- Validate a user-supplied schema or table name against the driver's identifier rules using `isInvalidSchemaName()`.
- Reserve schema-name patterns (wildcards or regex) so tooling won't create schemas that collide with Drupal's or with test schemas — `reserveSchemaPattern()`, `getReservedSchemaPattern()`, `freeSchemaPattern()`.
- Discover the Drupal installation's own schema name at runtime with `getDrupalSchemaName()`.
- Extract a schema's table definitions as Drupal Schema API arrays, SQL, or a parsed structure via `$conn->schema()->getSchemaDef()`.
- Introspect tables across schemas with the cross-schema-aware `findTables()`.
- Implement your own `CrossSchema` driver plugin for another RDBMS by extending `CrossSchemaBase` and returning `DatabaseTool`/`Connection`/`Schema` classes.
- Alter discovered driver definitions from another module via the `hook_dbxschema_info` alter hook.
- Load static "proprietary" schema definitions from YAML files for third-party (non-Drupal) database layouts.
- Keep using Drupal's parameter binding (`:placeholder`) and query builder unchanged while spanning multiple schemas.
