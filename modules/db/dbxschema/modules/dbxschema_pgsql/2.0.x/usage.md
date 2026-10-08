The PostgreSQL driver for the Database Cross-Schema Queries API, letting one query span several PostgreSQL schemas of the same database.

---

`dbxschema_pgsql` is the PostgreSQL implementation of the `CrossSchema` plugin type defined by the base `dbxschema` module. It ships no routes, permissions, config or UI — enabling it simply registers a driver (plugin id and driver name `pgsql`) whose `getClass()` returns the PostgreSQL-specific `DatabaseTool`, `Connection` and `Schema` classes. Those extend Drupal's core `pgsql` driver classes and add cross-schema support: schema-qualified table tokens (`{n:table}`), schema lifecycle DDL (`CREATE`/`DROP SCHEMA`, size, `schemaExists`), and full schema cloning through a bundled `pg-clone-schema` PL/pgSQL function (`dbxschema_clone_schema`, loaded per-query into `pg_temp` from `clone_schema.sql`). It requires core's `pgsql` module and `dbxschema`. On install it seeds the site's own PostgreSQL schema name into `dbxschema.settings:reserved_schema_patterns` so tooling won't overwrite the live install, and an update hook (`dbxschema_pgsql_update_9101`) removes DDL/clone functions that older versions had persisted in the database. You typically don't call this module's classes directly — use `\Drupal\dbxschema\Database\DatabaseTool::getConnection()`, which resolves to these classes automatically when the site runs on PostgreSQL.

---

- Enable it so `dbxschema` can cross-query multiple PostgreSQL schemas in one SQL statement.
- Provide the `pgsql` `CrossSchema` driver plugin (id `pgsql`) discovered by `plugin.manager.dbxschema`.
- Join Drupal's `public`-schema tables against tables in another PostgreSQL schema of the same database.
- Query two non-Drupal PostgreSQL schemas together via `{2:table}` / `{3:table}` tokens.
- Create a new PostgreSQL schema programmatically (`createSchema()` → `CREATE SCHEMA`).
- Clone an entire PostgreSQL schema (structure + data) with `cloneSchema()` using the bundled `pg-clone-schema` function.
- Rename or drop a PostgreSQL schema via the `DatabaseTool` / schema API.
- Measure a PostgreSQL schema's or the database's on-disk size.
- Validate PostgreSQL identifier names against the driver's `SCHEMA_NAME_REGEXP`/`TABLE_NAME_REGEXP`.
- Reserve the live Drupal schema name automatically at install so it can't be clobbered.
- Extract a schema's tables as Drupal Schema-API arrays or SQL via `getSchemaDef()`.
- Serve as the default cross-schema driver for any Drupal site running on PostgreSQL.
- Remove obsolete persisted DDL functions from earlier releases with update hook 9101.
- Underpin External-Entities-style storage backed by non-Drupal PostgreSQL schemas.
