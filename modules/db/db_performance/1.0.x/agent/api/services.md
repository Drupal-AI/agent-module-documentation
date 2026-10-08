<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection pipeline & services

All classes are under `src/`. No public plugin types — these are plain `@service` objects plus
one tagged event subscriber.

## Collection: `QueryCollectorSubscriber`

`src/EventSubscriber/QueryCollectorSubscriber.php`, service `db_performance.query_collector`,
tagged `event_subscriber`. Ctor: `QueryNormalizer $normalizer`, `Connection $connection`,
`ConfigFactoryInterface $configFactory`.

- Subscribes to `KernelEvents::REQUEST` (`onKernelRequest`, prio 100) and
  `KernelEvents::TERMINATE` (`collectQueries`, prio 100). Both act only on the **main** request.
- `onKernelRequest()` resets a static per-request fingerprint set and calls
  `Database::startLog('db_performance')` (log key constant `LOG_KEY`).
- `collectQueries()` reads `Database::getLog('db_performance')` and for each log entry:
  - skips empty SQL; keeps only queries where `stripos($sql, 'SELECT') === 0`;
  - `ignoreQuery()` skips if the SQL text `str_contains` any ignore pattern
    (config `ignore_tables`, else `DEFAULT_IGNORE_TABLES`);
  - skips if `time < slow_query_threshold` (falls back to `0.05`);
  - normalizes + fingerprints; **deduplicates one row per fingerprint per request** via the
    static `$requestQueries` set;
  - `extractOrigin($caller)` parses `"… in /path/file.php:123"`; ignores core paths
    (`/core/`), stores `basename` (≤255 chars) + line, and a Views id when the caller matches
    `ViewExecutable|views.module` and a `*.view.yml` filename;
  - `storeQuery()` inserts or updates the aggregate row (see schema below), then `trimIfNeeded()`.
- `trimIfNeeded()` deletes the oldest rows by `last_seen` when the count exceeds
  `max_stored_queries` (fallback `1000`). All storage is wrapped in try/catch that silently
  ignores errors (e.g. table not yet created).

## Fingerprinting: `QueryNormalizer`

`src/Service/QueryNormalizer.php`, service `db_performance.query_normalizer` (no deps).

- `normalize(string $sql): string` — in order: `'…'` → `?`; `\b\d+\b` → `?`;
  `IN (...)` → `IN (?)`; `([a-z_]+)_\d+` → `$1_alias`; collapse whitespace; trim.
- `fingerprint(string $normalized): string` — `hash('sha256', $normalized)` (64 chars, the
  `query_hash` column).

## Analysis: `QueryAnalyzer`

`src/Service/QueryAnalyzer.php`, service `db_performance.query_analyzer` (`@database`).

- `explain(string $query): ?array` — `makeExecutableForExplain()` swaps each `?` placeholder for
  an alternating dummy (`1`, then `'x'`, …), then runs driver-aware EXPLAIN:
  `explainMysql()` = `EXPLAIN <query>`; `explainPostgres()` = `EXPLAIN (FORMAT TEXT) <query>`
  (parses lines for `Seq Scan|Index Scan|Bitmap Heap`). Returns `null` on any exception.
- `hasTableScan(array $rows): bool` — MySQL/MariaDB: a row with `type=ALL` and empty/`NULL` key;
  PostgreSQL: a `Seq Scan` row.
- `getRowsExamined(array $rows): int` — sums `rows`/`Rows`/`plan_rows`.

Note: `explain()` runs the reconstructed query string directly (not parameterized), but the input
is the module's own stored `query_normalized` (site-generated), and only `SELECT` statements are
ever collected — EXPLAIN of a SELECT is read-only.

## Suggestion: `IndexSuggestionService`

`src/Service/IndexSuggestionService.php`, service `db_performance.index_suggestion`
(`@db_performance.query_analyzer`, `@db_performance.query_normalizer`).

- `suggest(string $queryNormalized): ?array` — returns
  `['create_index' => 'CREATE INDEX … ON … (…)', 'rows_examined' => int]` only when EXPLAIN
  reports a table scan **and** columns and a table can be parsed; else `null`.
- `extractTable()` (regex on `FROM …`), `extractColumnsForIndex()` (up to 5 columns from
  `WHERE/AND/OR … <op>` and `ORDER BY …`, table-prefix stripped), `generateIndexName()`
  (`idx_<table>_<cols>`, non-`[a-z0-9_]` replaced with `_`). All identifiers are regex-restricted
  to `[a-z_][a-z0-9_.]*`.

## DDL + export: `IndexManager`

`src/Service/IndexManager.php`, service `db_performance.index_manager` (`@database`).

- `createIndex(string $sql): ?\Throwable` — runs `$connection->query($sql)`; returns the caught
  Throwable on failure, `null` on success. Called only from `CreateIndexForm` with the row's
  cached `index_suggestion`.
- `markIndexCreated(int $id): void` — sets `index_created = 1`.
- `exportAllRecommendations(): string` — builds the `indexes.sql` body from rows with a non-empty
  `index_suggestion` and `index_created = 0`, ordered by `avg_time` DESC, each terminated with `;`.

## Schema table `db_performance_query`

`db_performance.install` (`hook_schema`). Columns: `id` (serial PK), `query_hash`
(varchar 64, indexed), `query_normalized` (text), `calls` (int), `total_time`/`avg_time`/`max_time`
(float), `first_seen`/`last_seen` (int timestamps), `index_suggestion` (text),
`index_created` (tinyint 0/1), `origin_file` (varchar 255), `origin_line` (int),
`origin_view` (varchar 255).
