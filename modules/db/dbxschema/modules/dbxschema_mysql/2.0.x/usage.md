The MySQL driver for the Database Cross-Schema Queries API, treating separate MySQL databases on one server as schemas so a single query can span them.

---

`dbxschema_mysql` is the MySQL implementation of the `CrossSchema` plugin type defined by the base `dbxschema` module. MySQL has no schema concept, so this driver maps each "schema" onto a separate MySQL **database** reachable through the same connection (same host, port and credentials) — see the MySQL identifier-qualifier docs referenced in the module. Enabling it registers a driver (plugin id and driver name `mysql`) whose `getClass()` returns the MySQL-specific `DatabaseTool`, `Connection` and `Schema` classes, which extend Drupal's core `mysql` driver classes and add cross-database table tokens (`{n:table}`) and database lifecycle helpers: `CREATE SCHEMA`/`DROP SCHEMA` (synonyms for `CREATE`/`DROP DATABASE`), existence checks, and size queries against `information_schema`. It requires core's `mysql` module and `dbxschema`. Cloning a database is implemented by shelling out to `mysqldump | mysql`, and renaming is clone-then-drop. On install it seeds the site's own database name into `dbxschema.settings:reserved_schema_patterns` so tooling won't overwrite the live install. You normally don't call these classes directly — `\Drupal\dbxschema\Database\DatabaseTool::getConnection()` resolves to them automatically when the site runs on MySQL.

---

- Enable it so `dbxschema` can cross-query multiple MySQL databases in one SQL statement.
- Provide the `mysql` `CrossSchema` driver plugin (id `mysql`) discovered by `plugin.manager.dbxschema`.
- Join Drupal's tables against tables in another MySQL database on the same server via `{n:table}` tokens.
- Query two non-Drupal MySQL databases together in a single query.
- Create a new MySQL database programmatically (`createSchema()` → `CREATE SCHEMA`).
- Clone a MySQL database (structure + data) with `cloneSchema()` (runs `mysqldump | mysql`).
- Rename a MySQL database (implemented as clone-then-drop) or drop one.
- Check database existence via `schemaExists()` against `information_schema.schemata`.
- Measure a MySQL database's or the server database's on-disk size from `information_schema.tables`.
- Validate MySQL identifier names against the driver's `SCHEMA_NAME_REGEXP` (`(?=.*\D)[0-9a-zA-Z$_]{1,64}`).
- Reserve the live Drupal database name automatically at install so it can't be clobbered.
- Serve as the default cross-schema driver for any Drupal site running on MySQL/MariaDB.
- Let a PostgreSQL-hosted Drupal site read a separate MySQL database configured as an extra settings.php key.
