# Configuration

There is no admin UI. You configure the SQL Server driver entirely in
**`settings.php`** (or via the installer's database form, which writes the same
keys). This requires the `pdo_sqlsrv` PHP extension and SQL Server 2016+ / Azure
SQL.

## Minimal connection

Add (or adjust) the default database connection in `settings.php`:

```php
$databases['default']['default'] = [
  'driver' => 'sqlsrv',
  'namespace' => 'Drupal\\sqlsrv\\Driver\\Database\\sqlsrv',
  'autoload' => 'modules/contrib/sqlsrv/src/Driver/Database/sqlsrv/',
  'host' => 'localhost',
  'port' => '1433',
  'database' => 'drupal_db',
  'username' => 'drupal_user',
  'password' => 'your_password',
];
```

Key points:

- **`autoload`** must be the real filesystem path to the driver — use
  `modules/contrib/sqlsrv/...` for a Composer install (or
  `modules/custom/sqlsrv/...` for a manual one).
- Leave **`username`** and **`password`** blank to use **Windows
  authentication**.
- Keep the real password out of committed config — reference an environment
  variable instead, e.g. `'password' => getenv('SQLSRV_PASSWORD')`.

You can also express the connection as a database URL, which recognizes the
`schema`, `cache_schema`, and `trust_server_certificate` parameters in addition
to the standard ones:

```
sqlsrv://user:pass@host:1433/drupal_db?module=sqlsrv&schema=drupal&trust_server_certificate=true
```

## Custom schema (default `dbo`)

By default tables go in the `dbo` schema. To use another, add `'schema' =>
'drupal'` (or `?schema=drupal` in the URL). At install the driver creates the
schema if the database user has `CREATE SCHEMA` rights; otherwise create it
manually first and grant table permissions on it, or give the user a
`DEFAULT_SCHEMA`.

## SQL-Server-specific options

All of these are optional keys you can add to the connection array; they're
passed through to the PDO connection string.

| Key | Default | What it does |
|---|---|---|
| `schema` | `dbo` | Default schema for tables. |
| `encrypt` | on | Encrypt data on the wire. Keep this on in production. |
| `trust_server_certificate` | off | Accept self-signed certificates — for development only. |
| `multi_subnet_failover` | off | For Always On availability groups / failover clusters. |
| `multiple_active_result_sets` | on | Set to `FALSE` to disable MARS. |
| `transaction_isolation` | — | Isolation level (e.g. READ_COMMITTED, SNAPSHOT). |
| `login_timeout` | — | Connection login timeout, in seconds. |
| `pooling` | on | Set to `FALSE` to disable connection pooling. |
| `appname` | — | A name shown for the connection in SQL Server logs. |
| `readonly` | — | Open a read-only (ApplicationIntent=ReadOnly) connection. |
| `column_encryption` | — | Enable Always Encrypted column encryption (SQL Server 2016+). |
| `key_store_authentication` | — | Key store auth method (e.g. `KeyVaultClientSecret`). |
| `key_store_principal_id` | — | Azure Key Vault application ID. |
| `key_store_secret` | — | Azure Key Vault application secret. |
| `cache_schema` | off | Cache table schema definitions for speed — only for a stable schema. |
| `escapedTables` | — | Map of reserved-word table names to their pre-bracketed form. |
| `transactions` | on | Set to `FALSE` to disable transactional DDL support. |

`escapedTables` example, for awkward reserved-word table names:

```php
$databases['default']['default']['escapedTables'] = [
  'user' => '[user]',
  'my-table' => '[my-table]',
];
```

## What happens at install

When you install Drupal against SQL Server (or on a fresh connection), the driver:

1. **Checks the SQL Server version** — requires 13.0 (2016) or newer. This check
   is skipped for Azure SQL editions, which are always current.
2. **Checks the collation** — it must be a UTF-8 collation, either
   case-insensitive (`_CI_`) or case-sensitive (`_CS_`); both are supported. A
   freshly auto-created database inherits the instance's default collation.
3. **Ensures the schema exists** — creating your custom schema if needed.
4. **Deploys helper functions** — scalar functions that give SQL Server the
   MySQL-style semantics Drupal expects (`GREATEST`, `IF`, `LPAD`, `MD5`,
   `SUBSTRING_INDEX`, and others).

## Gotchas worth knowing

- **REGEXP**: core installs fine without it, but if a contrib module uses the
  `REGEXP` operator you must deploy a CLR `REGEXP` function in SQL Server
  (requires enabling CLR and a .NET assembly). Most sites don't need this.
- **LIKE**: use standard Drupal backslash escaping in `condition(..., 'LIKE')` —
  the driver converts `%`/`_` to SQL Server bracket escaping for you.
- **BLOB comparisons**: SQL Server can't compare a string to a `varbinary`
  without a CAST, so avoid `->condition('blob_field', $string)`.
- **Transactions**: the ODBC layer rolls back the **whole** transaction on any
  in-transaction error, even with savepoints — this is a platform limitation that
  can't be fixed in PHP.
- **SA-CORE-2024-008**: this driver does not use `StatementPrefetch`, so no
  third-party-driver allowlist entry is required.
