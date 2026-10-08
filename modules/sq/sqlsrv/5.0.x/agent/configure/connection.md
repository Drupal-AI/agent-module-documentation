# Configure the SQL Server connection

There is no admin UI. The driver is chosen and tuned entirely in `settings.php` (or via the
installer's database form, which writes the same keys). Requires the `pdo_sqlsrv` PHP extension
(5.12.0+) and SQL Server 2016+ / Azure SQL.

## Minimal `settings.php`

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

- Install the module with Composer **before** running the installer: `composer require drupal/sqlsrv:^5.0`.
- Drivers no longer need copying to a `/drivers` directory (remove any old copy).
- `autoload` must be the real filesystem path to the driver (`modules/contrib/sqlsrv/...` for a
  Composer install, `modules/custom/sqlsrv/...` for a manual install).
- Leave `username`/`password` blank to use **Windows authentication**.

## Database-URL form

```
sqlsrv://user:pass@host:1433/drupal_db?module=sqlsrv&schema=drupal&trust_server_certificate=true
```

`createConnectionOptionsFromUrl()` recognises the `schema`, `cache_schema`, and
`trust_server_certificate` query parameters in addition to the standard core ones.

## Custom schema (default `dbo`)

Set `'schema' => 'drupal'` (settings) or `?schema=drupal` (URL). At install `ensureSchemaExists()`
creates the schema if the user has `CREATE SCHEMA` rights; otherwise create it manually first and
grant table DML/DDL on it. Alternatively give the DB user a `DEFAULT_SCHEMA`.

## sqlsrv-specific connection options

All optional; passed through to the PDO DSN by `Connection::open()`.

| Key | Type | Default | DSN / effect |
|---|---|---|---|
| `schema` | string | `dbo` | Default schema for tables. |
| `encrypt` | bool | `1` | `Encrypt` — encrypt data on the wire (keep on in prod). |
| `trust_server_certificate` | bool | `0` | `TrustServerCertificate` — accept self-signed certs (dev). |
| `multi_subnet_failover` | bool | `0` | `MultiSubnetFailover` — availability-group / failover-cluster. |
| `multiple_active_result_sets` | bool | `TRUE` | Set FALSE → `MultipleActiveResultSets=false` (disable MARS). |
| `transaction_isolation` | int | — | `TransactionIsolation` (1 RU, 2 RC, 4 RR, 8 SER, 16 SNAPSHOT). |
| `login_timeout` | int | — | `LoginTimeout` seconds. |
| `pooling` | bool | `TRUE` | Set FALSE → `ConnectionPooling=0`. |
| `appname` | string | — | `APP` — name shown in SQL Server connection logs. |
| `readonly` | bool | — | `ApplicationIntent=ReadOnly`. |
| `column_encryption` | string | — | `ColumnEncryption` — Always Encrypted (SQL Server 2016+). |
| `key_store_authentication` | string | — | `KeyStoreAuthentication` (e.g. `KeyVaultClientSecret`). |
| `key_store_principal_id` | string | — | `KeyStorePrincipalId` — Key Vault app id. |
| `key_store_secret` | string | — | `KeyStoreSecret` — Key Vault app secret. |
| `cache_schema` | bool | `FALSE` | Cache table schema definitions (faster; only for a stable schema). |
| `escapedTables` | array | — | Map of `unescaped => already-bracketed` table names, used as-is. |
| `transactions` | bool | `TRUE` | Set FALSE to disable transactional DDL support. |

`escapedTables` example:

```php
$databases['default']['default']['escapedTables'] = [
  'user' => '[user]',
  'my-table' => '[my-table]',
];
```

## Install-time checks (`Install\Tasks`)

Running the installer (or a fresh connection) performs:
1. **checkDatabaseVersion** — requires SQL Server ≥ 13.0 (2016); version check is **skipped for Azure**
   SQL editions (they are always current).
2. **checkEncoding** — the collation must be UTF-8 and either `_CI_` (case-insensitive) or `_CS_`
   (case-sensitive); both are supported. A fresh auto-created DB inherits the instance's default collation.
3. **ensureSchemaExists** — create the configured custom schema if missing.
4. **initializeDatabase** — deploy the helper scalar functions (see api/internals.md).

## REGEXP support (optional)

Core installs without it. If a contrib module uses the `REGEXP` operator you must install a CLR
function named `[REGEXP](@pattern, @matchString) RETURNS bit` in SQL Server (requires enabling CLR
and deploying a .NET assembly). Most sites do not need this.

## Notes / gotchas

- **LIKE**: use standard Drupal backslash escaping in `condition(..., 'LIKE')`; the driver converts
  `%`/`_` to SQL Server bracket escaping internally. For raw T-SQL LIKE, use `->where()`.
- **BLOB compares**: SQL Server can't compare a string to a varbinary without a CAST — avoid
  `->condition('blob_field', $string)`.
- **Transactions**: the ODBC layer rolls back the **whole** transaction on any in-transaction error,
  even with savepoints (cannot be fixed in PHP).
- **SA-CORE-2024-008**: this driver does not use `StatementPrefetch`, so no allowlist entry is needed.
