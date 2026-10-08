<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Snowflake SQL API service

## Service
`snowflake.sql_api` → `Drupal\snowflake\SqlApi`.

## Methods
- `executeStatements(Statements $statements): ResultSet|StatusResultInterface`
  POSTs to `/api/v2/statements` with headers (`Bearer` token + `X-Snowflake-Authorization-Token-Type`),
  a JSON payload (statement text, **bindings**, parameters, defaults) and query options
  (`requestId`, `async`, `nullable`). 202 → `QueryStatus`; 200 → `ResultSet`;
  422/408 → `QueryFailureStatus`.
- `getStatementStatus(string $handle, int $partition = 0)` — handle is UUID-validated.
- `cancelStatement(string $handle)` — cancel a running statement.

## Building statements
Use `Statement::create($sql)->addBinding($type, $value)` (typed bindings, `Statement::BINDING_TYPES`)
and group into `Statements`. Values go as JSON bindings — **no SQL string concatenation**, so no
client-side SQL injection.

## Auth token
`$authenticator->getToken()` (key-pair JWT or OAuth) supplies the Bearer token; the token type is
sent in the `X-Snowflake-Authorization-Token-Type` header.
