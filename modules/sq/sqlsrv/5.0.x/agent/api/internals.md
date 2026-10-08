# SQL Server driver internals

You rarely call this driver directly — the Drupal Database API does. This doc explains the
SQL-Server-specific behaviour you may hit when writing queries or debugging, all under
`src/Driver/Database/sqlsrv/`.

## Identifier quoting & statement mode

- `Connection::$identifierQuotes = ['[', ']']` — identifiers wrapped in SQL Server brackets.
- `prepareStatement()` forces `SQLSRV_ATTR_DIRECT_QUERY = TRUE`, a scrollable
  (`CURSOR_SCROLL`) buffered (`SQLSRV_CURSOR_BUFFERED`) cursor, and stringified fetches. Direct
  mode is required so temporary tables survive after the statement.
- `queryDirect($query, $args, $options)` runs a query with `bypass_preprocess` and no emulation —
  used internally by the Schema class for T-SQL that must not be rewritten.
- `query()` auto-switches to `EMULATE_PREPARES` when there are duplicate placeholders, ≥ 2100 args,
  or a placeholder/`:` count mismatch (works around pdo_sqlsrv limits).

## Query rewriting (`preprocessQuery()`)

Portable SQL is translated to T-SQL before execution:
- `LENGTH(` → `LEN(`, `POW(` → `POWER(`, and the ANSI `||` concatenation operator → `+`.
- `CONCAT_WS(...)` is rewritten into a `STUFF(... + ...)` expression (handled in `query()`).
- `LEAST(a, b, ...)` → `(SELECT MIN(i) FROM (VALUES (a),(b)) AS T(i))`.
- Drupal-specific scalar functions are schema-prefixed (`<schema>.FUNC(`).
- `queryRange()` appends `OFFSET n ROWS FETCH NEXT m ROWS ONLY` (adding `ORDER BY (SELECT NULL)` if
  the query has no ORDER BY).
- `queryTemporary()` rewrites `SELECT … FROM` into `SELECT … INTO {#temp} FROM` after stripping
  comments.

## Deployed helper functions (`Utils::deployCustomFunctions()`)

At install (`Install\Tasks::initializeDatabase()`) the driver deploys scalar functions from
`src/Driver/Database/sqlsrv/Programmability/` (config in `configuration.yml`) so SQL Server matches
MySQL semantics: `CONNECTION_ID`, `GREATEST`, `IF`, `LPAD`, `MD5`, `REGEXP`, `SUBSTRING`,
`SUBSTRING_INDEX`. They are created with global (unprefixed) names so multiple Drupal instances on
one database don't duplicate them. `REGEXP` is a stub expecting a CLR implementation (see
configure/connection.md).

## Conditions: REGEXP and LIKE (`Condition::compile()`)

- `REGEXP` / `NOT REGEXP` → rewritten to `REGEXP(:placeholder, field) = 1|0` using the deployed
  function. `Condition::where()` also detects a raw ` REGEXP ` / ` NOT REGEXP ` snippet and rewrites it.
- `LIKE` / `NOT LIKE` → value converted to SQL Server bracket escaping: `[`→`[[]`, `\%`→`[%]`,
  `\_`→`[_]`, `\\`→`\`. (The operator map keeps `LIKE` with no `ESCAPE` clause to dodge PHP bug
  #79276, fixed in PHP 8.4.)
- `LIKE BINARY` (case-sensitive match): on a **case-insensitive** DB, the field gets a
  `COLLATE <..._CS_..>` clause (derived by swapping `_CI_`→`_CS_` in the DB collation) plus bracket
  escaping; on a case-sensitive DB it degrades to a plain `LIKE`.

All values are still bound as PDO placeholders — the bracket rewriting only changes wildcard
semantics, not the parameterisation.

## Parameter binding & encoding (`Utils`)

- `ensureValidUtf8()` guarantees bound strings are valid UTF-8 (pdo_sqlsrv converts to UTF-16
  internally), recovering via `mb_convert_encoding`/`iconv //IGNORE` when needed.
- `bindValues()` streams BLOB/varbinary columns through `php://memory` with
  `PDO::PARAM_LOB` + `SQLSRV_ENCODING_BINARY`; non-blob values bind as `PARAM_STR`.

## Transactions (`TransactionManager`, `Connection::pushTransaction`/`rollBack`)

- First level → `BEGIN TRANSACTION`; nested levels → `SAVE TRANSACTION <name>` savepoints.
- Rollback uses `ROLLBACK TRANSACTION <name>`; SQL Server has no `RELEASE SAVEPOINT`.
- ODBC caveat: any error inside a transaction auto-rolls-back the entire transaction (savepoints
  included) — reflected in the rollback error handling.

## IDs, temp tables, deadlocks

- `nextId()` uses `INSERT INTO {sequences} OUTPUT (Inserted.[value]) DEFAULT VALUES` (OUTPUT instead
  of LAST_INSERT_ID, correct under concurrency); can seed an existing value via `IDENTITY_INSERT`.
- Temp tables use a `#` prefix (`db_temporary_<hex>`); `prefixTables()`/`tablePrefix()` keep the
  `#`/`##` unquoted so SQL Server recognises them.
- `executeWithDeadlockRetry(callable, $max_retries = 3)` retries on SQLSTATE `40001` with
  exponential backoff (10/20/40 ms).
- `hasJson()` probes `ISJSON()` support.

## Views date handling

`Drupal\sqlsrv\Plugin\views\query\SqlsrvDateSql` (service `sqlsrv.views.date_sql`) provides the
SQL-Server date SQL for Views date arguments/filters/granularity, replacing the core MySQL date_sql.
