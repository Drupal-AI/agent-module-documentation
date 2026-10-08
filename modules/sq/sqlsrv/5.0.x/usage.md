SQL Server (`sqlsrv`) is a Drupal database driver that lets Drupal run on Microsoft SQL Server 2016+ and Azure SQL, implemented on top of PHP's `pdo_sqlsrv` extension. It is configured entirely through `settings.php` connection info, not an admin UI.

---

The module provides a full `Drupal\Core\Database` driver under `src/Driver/Database/sqlsrv/` (Connection, Schema, Select, Insert, Update, Delete, Merge, Upsert, Truncate, Condition, TransactionManager, ExceptionHandler, Install\Tasks). It is selected by pointing a connection's `driver`/`namespace`/`autoload` keys at it in `settings.php`; there is no config page, no permissions, no schema, and no Drush commands. Identifiers are quoted with SQL Server brackets (`[` … `]`) and queries are bound through PDO in "direct query" mode with scrollable buffered cursors so temporary tables survive. `Connection::preprocessQuery()` rewrites portable SQL into T-SQL: `LENGTH→LEN`, `POW→POWER`, `||→+`, `CONCAT_WS`/`LEAST` emulation, and prefixes Drupal-specific scalar functions. Missing MySQL-style functions (`GREATEST`, `IF`, `LPAD`, `MD5`, `REGEXP`, `SUBSTRING`, `SUBSTRING_INDEX`, `CONNECTION_ID`) are deployed as CLR/T-SQL scalar functions at install (`Utils::deployCustomFunctions()` from `Programmability/`). `Condition::compile()` translates `REGEXP`/`NOT REGEXP` into the deployed `REGEXP()` function and rewrites `LIKE`/`LIKE BINARY` to SQL Server bracket escaping (adding a `COLLATE …_CS_…` clause for case-sensitive matching on case-insensitive databases). It supports both case-insensitive and case-sensitive UTF-8 collations, transactions via `SAVE TRANSACTION` savepoints (with ODBC's whole-transaction-rollback caveat), a custom schema (default `dbo`) that can be auto-created at install, automatic database creation, deadlock retry with exponential backoff, and a Views `date_sql` plugin for date-based Views on SQL Server. Install-time tasks check the SQL Server/Azure version, verify a UTF-8 CI/CS collation, ensure the schema exists, and deploy the helper functions. Per SA-CORE-2024-008 it does **not** use `StatementPrefetch`, so no third-party-driver allowlisting is required.

---

- Run a Drupal 10.3+/11 site with Microsoft SQL Server as its primary database.
- Host Drupal on Azure SQL Database (version checks are auto-skipped for Azure editions).
- Connect Drupal to SQL Server during the installer by selecting "SQL Server" as the database type.
- Configure the connection via `settings.php` with `driver`, `namespace`, `autoload`, host, port, database, credentials.
- Use Windows authentication by leaving username/password blank.
- Point Drupal at a non-default database schema (multi-tenant) with the `schema` connection key.
- Auto-create the target database at install when it does not yet exist and permissions allow.
- Auto-create a custom schema at install when the user has `CREATE SCHEMA` rights.
- Enforce encrypted connections with `encrypt` and `trust_server_certificate` options.
- Connect to an Always On availability-group listener with `multi_subnet_failover`.
- Use Always Encrypted column encryption via `column_encryption` + Azure Key Vault key-store options.
- Set the transaction isolation level (e.g. READ_COMMITTED, SNAPSHOT) per connection.
- Enable or disable Multiple Active Result Sets (MARS) and connection pooling.
- Tag connections with an `appname` for identification in SQL Server logs.
- Establish a read-only (ApplicationIntent=ReadOnly) connection.
- Run REGEXP-based queries by deploying the required CLR `REGEXP` function in SQL Server.
- Provide `GREATEST`/`LEAST`/`LPAD`/`SUBSTRING_INDEX`/`IF`/`MD5` semantics that SQL Server lacks natively.
- Support case-sensitive matching (`LIKE BINARY`) on a case-insensitive database via COLLATE injection.
- Store and query BLOB/varbinary data through the driver's binary parameter binding.
- Retry automatically on SQL Server deadlocks (SQLSTATE 40001) with exponential backoff.
- Render date-based Views (date arguments/filters/grouping) correctly on SQL Server via the `date_sql` plugin.
- Migrate an existing Drupal site from MySQL/PostgreSQL onto SQL Server.
- Cache schema definitions (`cache_schema`) to speed up a site with a stable schema.
- Satisfy SA-CORE-2024-008 without extra config (the driver avoids `StatementPrefetch`).
- Pre-escape awkward reserved-word table names with the `escapedTables` settings option.
