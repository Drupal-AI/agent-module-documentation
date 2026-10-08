<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slow-query report, EXPLAIN suggestions, export & create-index

Routes in `db_performance.routing.yml`; controller/forms in `src/`.

## Report page — `ReportController::report()`

- Route `db_performance.report`: `GET /admin/reports/db-performance`, permission
  **`access db performance reports`**. Menu link under *Reports*.
- Reads config flags `enable_index_suggestions` and `allow_index_creation`.
- Selects the top **100** `db_performance_query` rows ordered by `avg_time` DESC.
- For up to **5** rows per render that have no cached `index_suggestion` (only when
  `enable_index_suggestions` is on), calls `IndexSuggestionService::suggest($query_normalized)`;
  a returned `create_index` is written back to the row (`->update()`), so suggestions are computed
  lazily and cached.
- Builds a `#theme => 'db_performance_report'` render array with per-row `query`
  (the normalized SQL), `calls`, `avg_time_ms`, `max_time_ms`, `origin`
  (`View: <id>` / `<file>:<line>` / empty), `index_suggestion`, `index_created`, and — when
  `allow_index_creation` is on, a suggestion exists, and it isn't created yet — a *Create index*
  link to `db_performance.create_index`.
- `export_url` is set only when the current user has `manage db performance indexes`.

The page shows **normalized** SQL (literals/numbers already replaced with `?`), aggregate
timings, and origin file basename/line or Views id — it does not display live data values.

## Export — `ReportController::export()`

- Route `db_performance.export`: `/admin/reports/db-performance/export`, permission
  **`manage db performance indexes`**.
- Returns a `Response` from `IndexManager::exportAllRecommendations()` with
  `Content-Type: application/sql` and `Content-Disposition: attachment; filename=indexes.sql`
  (uncreated suggestions, ordered by `avg_time` DESC, each a `CREATE INDEX …;`).

## Create index — `CreateIndexForm`

- Route `db_performance.create_index`: `/admin/reports/db-performance/create/{id}` with
  `id: \d+`, permission **`manage db performance indexes`**. Extends `ConfirmFormBase`.
- `buildForm()` loads the row by `id` (parameterized `->condition('id', $id)`); errors out if the
  row is missing, has no `index_suggestion`, or is already `index_created`. Shows the query and
  suggested DDL (`htmlspecialchars`-escaped inside `<pre>`/`<code>`).
- `submitForm()` runs `IndexManager::createIndex($record->index_suggestion)`; on the returned
  Throwable it shows the error message, otherwise `markIndexCreated()` and redirects to the page.
- The DDL executed is the **cached, module-generated** `index_suggestion` (built by
  `IndexSuggestionService` from regex-restricted identifiers), not free-form user input. This route
  only appears/functions when `allow_index_creation` is enabled and the user holds the manage
  permission — keep the flag off in production.

## Permissions (`db_performance.permissions.yml`)

- `access db performance reports` — view the page (read-only).
- `manage db performance indexes` — export recommendations and create indexes.
- Both declare `restrict access: FALSE`; neither is granted by default, so an admin must assign
  them to a role. Grant the view permission separately from the manage permission to give a
  reviewer read-only visibility.
