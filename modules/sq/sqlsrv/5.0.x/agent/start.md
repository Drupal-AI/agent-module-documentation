# SQL Server (sqlsrv) — agent index

A Drupal core database driver for Microsoft SQL Server 2016+ and Azure SQL, built on PHP's
`pdo_sqlsrv` extension. Configured only through `settings.php` connection info — **no admin UI**
(`configure` null), no permissions, no config schema, no Drush commands, no submodules. Requires
Drupal 10.3+/11 and the `pdo_sqlsrv` PHP extension.

- **How to configure the connection: `settings.php` keys, URL format, all sqlsrv options, custom schema** →
  [configure/connection.md](configure/connection.md)
- **Driver internals: query rewriting, bracket quoting, REGEXP/LIKE, custom functions, transactions, temp tables, deadlock retry, Views date_sql** →
  [api/internals.md](api/internals.md)

Key facts:
- Namespace `Drupal\sqlsrv\Driver\Database\sqlsrv`; source under `src/Driver/Database/sqlsrv/`.
- Identifier quotes are SQL Server brackets `[` `]`; queries run in PDO direct-query mode with buffered scroll cursors.
- Portable SQL is rewritten to T-SQL (`LENGTH→LEN`, `||→+`, `CONCAT_WS`/`LEAST` emulation) and missing
  MySQL functions are deployed as scalar functions at install.
- Supports both `_CI_` and `_CS_` UTF-8 collations; custom schema (default `dbo`) auto-created at install.
- Does **not** use `StatementPrefetch`, so SA-CORE-2024-008 allowlisting is **not** required.
