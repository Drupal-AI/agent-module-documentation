<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datastore query, SQL + import API (dkan_datastore)

`dkan_datastore` imports the tabular file (CSV/TSV) behind a dataset resource into a per-resource DB
table, then exposes it two ways: a **structured JSON query API** (`/api/1/datastore/query…`) and a
**bracketed SQL-DSL endpoint** (`/api/1/datastore/sql`). Import/drop of resources is a separate,
permission-gated API. All routes set `_auth: ['basic_auth','cookie']`.

Controllers: `Drupal\dkan_datastore\Controller\QueryController`, `QueryDownloadController` (both extend
`AbstractQueryController`), `ImportController`; `Drupal\dkan_datastore\SqlEndpoint\WebServiceApi`.
Services: `dkan.datastore.service` (`DatastoreService`), `dkan.datastore.query` (`Service\Query`),
`dkan.datastore.sql_endpoint.service` (`DatastoreSqlEndpointService`).

## Query API — `_permission: 'access content'`

| Route | Method · Path |
| --- | --- |
| `dkan_datastore.1.query` | GET/POST `/api/1/datastore/query` |
| `dkan_datastore.1.query.download` | GET/POST `/api/1/datastore/query/download` |
| `dkan_datastore.1.query.id` | GET/POST `/api/1/datastore/query/{identifier}` |
| `dkan_datastore.1.query.id.download` | GET/POST `/api/1/datastore/query/{identifier}/download` |
| `dkan_datastore.1.query.dataset.index` | GET/POST `/api/1/datastore/query/{dataset}/{index}` |
| `dkan_datastore.1.query.dataset.index.download` | GET/POST `…/{dataset}/{index}/download` |
| `dkan_datastore.1.query.schema.get` | GET `/api/1/datastore/query/schema` |

Request body is a JSON "datastore query" (`docs/query.json` schema): `resources`, `properties`,
`conditions`, `joins`, `groupings`, `sorts`, `limit`, `offset`, `rowIds`, `format` (`json`/`csv`).
`{identifier}` is a distribution/resource UUID; `{dataset}/{index}` resolves via
`DatasetInfo::getDistributionUuid`. `rowIds` and requesting `record_number` are mutually exclusive
(the internal `record_number` column cannot be requested directly). `LIMIT` is capped by
`dkan_datastore.settings:rows_limit` (default 500). A "degraded performance" state
(`dkan_datastore.degraded_performance`) can block conditions/joins/sorts/offsets with a 503.

**SQL safety of the query path:** the DKAN `Query` object is compiled to a Drupal DB `Select` by
`dkan_common\Storage\SelectFactory`, which uses `escapeField()`/`escapeTable()`/`escapeAlias()`,
`safeProperty()` (rejects `.` in property names), a whitelist of join operators
(`safeJoinOperator`), a whitelisted function set (`sum,count,avg,max,min`), and **parameterized
conditions** (`->condition($field,$value,$op)`; fulltext MATCH uses named `:wordsN` placeholders).
The base table is the resolved datastore table for the resource — not a caller-supplied table name.

## SQL-DSL endpoint — `/api/1/datastore/sql`

Not raw SQL: `WebServiceApi::runQuery` → `DatastoreSqlEndpointService` parses a **bracketed DSL** with
`SqlParser` (a `maquina` state machine). Only `SELECT <cols|*|COUNT(*)> FROM <resourceId>`,
`WHERE col = "val" [AND …]`, `ORDER BY col [ASC|DESC]`, `LIMIT n [OFFSET m]` are accepted, e.g.
`[SELECT * FROM d7f3…][WHERE state = "AK"][LIMIT 10];`. The `FROM` token is a **resource identifier**
resolved to a datastore table via `DatastoreService::getStorage()`; arbitrary table names are not
reachable and WHERE values become parameterized equality conditions. So this endpoint is **not** a
classic SQL-injection / arbitrary-table surface.

Routes: `dkan_datastore.sql_endpoint.get.api` (GET `/api/1/datastore/sql`) and
`dkan_datastore.sql_endpoint.post.api` (POST `/api/1/datastore/sql`). The GET takes the query in
`?query=`; the POST takes the JSON body `{"query": "…"}`; both accept an optional `show_db_columns`
flag. On a default open-data portal anonymous users hold `access content`, so the datastore is public
by design. The nested `dkan_alt_api` submodule provides a parallel `/alt/api/1/datastore/sql`
(GET+POST) gated by the `query the alternate sql endpoint api` permission, for sites that want a
separately-permissioned SQL endpoint. Verify the exact access requirements per route with
`drush route` before relying on them.

## Import / drop API

| Route | Method · Path | Access |
| --- | --- | --- |
| `dkan_datastore.1.imports` | GET `/api/1/datastore/imports` | `datastore_api_import` |
| `dkan_datastore.1.imports.post` | POST `/api/1/datastore/imports` | `datastore_api_import` |
| `dkan_datastore.1.imports.id` | GET `/api/1/datastore/imports/{identifier}` | `access content` |
| `dkan_datastore.1.imports.delete` | DELETE `/api/1/datastore/imports` | `datastore_api_drop` |
| `dkan_datastore.1.imports.id.delete` | DELETE `/api/1/datastore/imports/{identifier}` | `datastore_api_drop` |

POST body `{identifier, version?, deferred?}` queues/runs an import (`DatastoreService::import`).
The MySQL fast path (`dkan_datastore_mysql_import`) runs `LOAD DATA LOCAL INFILE` on the **already
localized** file path with sanitized column headers and a fixed delimiter/EOL set — the file path is
server-resolved, not request-supplied.

## Admin routes

`/admin/dkan/resources`, `/admin/dkan/datastore` (both `administer site configuration`),
`/admin/dkan/datastore/status` (`dkan.harvest.dashboard`),
`/admin/dkan/datastore/mysql_import` (`administer site configuration`).

Drush: `dkan_datastore` provides `DatastoreCommands`, `ReimportCommands`, `PurgeCommands`,
`DegradedModeCommands`.
