<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DB Performance passively logs each request's slow **SELECT** queries, aggregates them by a normalized fingerprint into a `db_performance_query` table, and surfaces the slowest ones in an admin report that can analyze them with `EXPLAIN` and suggest (or create) database indexes.

---

The module is a self-contained, dependency-free database-tuning tool for Drupal 10/11 (MySQL, MariaDB, PostgreSQL). A single kernel event subscriber (`QueryCollectorSubscriber`) calls `Database::startLog('db_performance')` on the main `REQUEST` and, on `TERMINATE`, reads the core query log. It keeps only statements that start with `SELECT`, do not reference an ignored table (defaults: `cache_`, `watchdog`, `sessions`, `queue`, `semaphore`, `key_value`, `db_performance_query`), and ran at or above the configured **slow query threshold** (default `0.05` s). Each kept query is passed through `QueryNormalizer::normalize()` — quoted strings and numbers become `?`, `IN (...)` collapses to `IN (?)`, numeric aliases (`table_1`) become `table_alias`, whitespace is compressed — and `fingerprint()` hashes the canonical form with SHA-256. Statistics are stored/updated per fingerprint (`calls`, `total_time`, `avg_time`, `max_time`, `first_seen`, `last_seen`) together with the query's origin (non-core file basename + line, or the Views view id parsed from the caller). When the row count exceeds **max stored queries** (default `1000`), the oldest rows by `last_seen` are trimmed. The report at **`/admin/reports/db-performance`** (permission *access db performance reports*) lists the top 100 rows by average time. If **enable index suggestions** is on, up to five un-analyzed rows per view are run through `QueryAnalyzer::explain()` (driver-aware `EXPLAIN` / `EXPLAIN (FORMAT TEXT)`); when a full table scan is detected (`type=ALL`, no key on MySQL; `Seq Scan` on PostgreSQL), `IndexSuggestionService` builds a `CREATE INDEX` from the WHERE/ORDER BY columns and caches it on the row. Recommendations can be exported as `indexes.sql` (permission *manage db performance indexes*), and — only when **allow index creation from UI** is enabled — created in place via a `ConfirmFormBase` that runs the cached DDL and marks the row `index_created`. Settings live in `db_performance.settings` and are edited at **`/admin/config/development/db-performance`** (permission *administer site configuration*). The module ships a `hook_theme()` template (`db-performance-report.html.twig`), a `hook_schema()` table, config schema, and two menu links; it defines no entities, plugins, or Drush commands.

---

- See which SELECT queries are slowing a Drupal site down, ranked by average execution time.
- Debug a slow admin or listing page by finding the query that dominates its request time.
- Optimize Views by spotting a view whose generated query does a full table scan.
- Optimize custom `entityQuery`/`select()` code that appears as a slow, repeated fingerprint.
- Identify missing database indexes without New Relic, Blackfire, or other external profilers.
- Aggregate structurally identical queries (same shape, different values) into one fingerprint.
- Track how often a slow query runs (`calls`) versus how slow it is per call (`avg_time`).
- Trace a slow query back to the module file and line, or the Views view, that issued it.
- Tune sensitivity by raising or lowering the slow-query threshold for a busy vs. quiet site.
- Cap storage growth by setting the maximum number of stored query fingerprints.
- Exclude noisy infrastructure tables (cache, sessions, queue) from collection via the ignore list.
- Add your own tables or table-name patterns to the ignore list to focus on application queries.
- Get an `EXPLAIN`-based `CREATE INDEX` suggestion for a query that scans a whole table.
- Review the exact suggested DDL before touching the database.
- Export all outstanding index recommendations as a downloadable `indexes.sql` script.
- Hand that `indexes.sql` to a DBA or apply it through your own migration/deploy pipeline.
- Create a suggested index directly from the UI on a dev/staging site (with a confirm step).
- Keep index creation from the UI disabled in production while still collecting and exporting.
- Compare first-seen vs. last-seen timestamps to tell chronic slow queries from one-offs.
- Support MySQL, MariaDB, or PostgreSQL with the same driver-aware analysis.
- Run alongside Devel or Webprofiler, which show per-request queries, for over-time aggregation.
- Let a site accumulate real traffic first, then review the report to prioritize optimization work.
- Grant read-only report access to a performance reviewer separately from index-management rights.
