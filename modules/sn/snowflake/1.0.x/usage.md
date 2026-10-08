<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Snowflake provides a Drupal service (`snowflake.sql_api`, `SqlApi`) that talks to the Snowflake SQL API v2 over HTTPS, so custom code can run SQL statements against a Snowflake account and read structured result sets.

---


Connection and auth are configured via admin forms (`/admin/config/snowflake/*`, permission `administer snowflake`): account identifier, statement defaults, and an authentication method — key-pair (JWT signed with a private key) or OAuth — with credentials referenced through the Key module rather than stored in plain config. `SqlApi` builds the endpoint from the configured account identifier, adds a `Bearer` token + token-type header, and POSTs statements with typed **bindings** and parameters as JSON (no string concatenation of SQL), and supports async execution, status polling by statement handle (UUID-validated), and cancellation. Result sets are wrapped in typed classes (`ResultSet`, `QueryStatus`, `QueryFailureStatus`, etc.).

Setup: install Key, create a Key for your Snowflake private key/OAuth secret, set the account identifier and auth method under `/admin/config/snowflake`, then call `snowflake.sql_api` from code.
---
- Run SQL against Snowflake from Drupal code.
- Configure the Snowflake account identifier.
- Choose key-pair or OAuth authentication.
- Store credentials via the Key module (not plain config).
- Sign JWTs for key-pair auth.
- Execute a group of statements with `executeStatements()`.
- Bind typed parameters to a statement (no SQL concatenation).
- Set statement/parameter defaults in config.
- Run statements asynchronously.
- Poll a statement's status by handle.
- Cancel a running statement.
- Validate statement handles as UUIDs.
- Read typed result sets and metadata.
- Handle query failure/timeout statuses.
- Set the request id per statement group.
- Send `Bearer` auth + token-type headers.
- Integrate a Snowflake data warehouse with Drupal.
- Restrict Snowflake settings to `administer snowflake`.
- Build ETL/reporting features on Snowflake data.
- Reuse one client service across modules.
