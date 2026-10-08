<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Snowflake (snowflake) — agent index

**Client service for the Snowflake SQL API v2 with key-pair/OAuth auth and parameterized statements.**

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** ^9 || ^10 || ^11 — requires `key`.
- **Config routes:** `/admin/config/snowflake`, `/settings`, `/auth`, `/auth/key-pair` — all perm `administer snowflake` (restricted). (OAuth form commented out.)
- **Service:** `snowflake.sql_api` (`SqlApi`) — `executeStatements()`, `getStatementStatus()`, `cancelStatement()`.
- Endpoint from configured account identifier: `https://{account}.snowflakecomputing.com/api/v2/statements`.

**Security:** Config routes are restricted-permission admin routes. SQL is sent with **typed bindings/JSON** (no string concatenation → no SQLi from the client), credentials are held in **Key** entities (not plain config), statement handles are UUID-validated, and Guzzle default TLS applies (no `verify=>false`). No security findings. See [api.md](api.md) and [configure/auth.md](configure/auth.md).
