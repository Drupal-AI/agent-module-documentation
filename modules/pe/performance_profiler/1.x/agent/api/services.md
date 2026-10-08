# Services, profiling mechanism, AJAX route & theme (API)

## Services

| Service id | Class | Constructor args |
|---|---|---|
| `performance_profiler.event_subscriber` | `EventSubscriber\PerformanceProfilerEventSubscriber` | `@config.factory` |
| `performance_profiler.database_actions` | `PerformanceDatabaseActions` | `@database`, `@logger.factory`, `@messenger`, `@renderer` |
| `performance_profiler.benchmark` | `PerformanceBenchmark` | (none) |
| `performance_profiler.commands` | `Commands\PerformanceProfilerCommands` | `@messenger`, `@performance_profiler.benchmark`, `@performance_profiler.database_actions` |

## Request → shutdown profiling flow

1. `PerformanceProfilerEventSubscriber::onRequest` (`KernelEvents::REQUEST`, priority **-100**) calls
   `Timer::start('performance_profiler')`, and if config `database` is on
   `Database::startLog('performance_profiler_db')`, then `drupal_register_shutdown_function('performance_profiler_shutdown')`.
2. `performance_profiler_shutdown()` (in `.module`) registers `performance_profiler_shutdown_final()`
   to run last.
3. `performance_profiler_shutdown_final()` decides whether to record: skips the profiler's own AJAX
   route unless `self` is set; skips XHR requests unless `ajax` is set; stops the timer and computes
   `round(memory_get_peak_usage()/1024/1024, 2)` Mb and `round(Timer::read()/1000, 3)` s; applies the
   `memory`/`time` thresholds; and for anonymous users records only when both `anonymous` and
   `watchdog` are set. If `database` is on it calls `performance_profiler_db_get_results()`.
   - **watchdog sink:** builds an HTML summary (run time, memory, path/alias, and read/write DB
     breakdown) and logs it with `\Drupal::logger('performance_profiler')->debug()`.
   - **toolbar/popup sink:** only when (`toolbar` or `popup`) **and**
     `currentUser()->hasPermission('access performance profiler')` — writes the element into
     `tempstore.private->get("performance_profiler_<session_id>")->set('storage', …)`, keyed by path.

`performance_profiler_db_get_results()` reads `Database::getLog('performance_profiler_db')` and returns
`['info' => …, 'details' => …]`: total/read/write counts, times and averages, the **top 20** slowest
queries (with query text + args), and per-module query time/count (top 9 by time and by count).

## AJAX route & controller

`performance_profiler.ajax_performance_data` → `Controller\AjaxPerformanceData::get()`
(`_permission: access performance profiler`). It reads the current session's private tempstore
(`performance_profiler_<session_id>`), **immediately clears it** (`set('storage', NULL)`), picks the
entry for `?path=` (or the last entry), and returns a rendered `performance_profiler_toolbar` element
as a plain `Response`. Data is per-session and permission-gated; there is no cross-user read.

## `PerformanceBenchmark` — `performance_profiler.benchmark`

Pure PHP micro-benchmark (no DI). `run(array &$return_results = [])` runs every `test*` method
(`testMath`, `testStringManipulation`, `testLoops`, `testIfElse`), fills `$return_results[<method>]`
and `['total']`, and returns padded human lines. Used by the run form and the `pp-php` Drush command.

## `PerformanceDatabaseActions` — `performance_profiler.database_actions`

Raw-SQL MySQL benchmark helper. Constants: `TABLE_PREFIX = 'performance_profiler_db_test_'`;
`QUERY_TYPES = ['select','select_sort','select_sort_no_index','select_like','join','join_two']`.
`tables()` returns the specs for the three test tables (`main`, `ref_by_uuid`, `ref_by_id`).

Public methods:

- `run(bool $is_ajax = FALSE)` — full cycle: drop-if-exists → create → fill (10 000 rows each) → run
  every `QUERY_TYPES` query → drop. Returns an `AjaxResponse` (ajax) or a messages array (CLI). Used
  by the run form's DB button and the `pp-db` Drush command.
- `createTable(string $table, array $specification, bool $is_ajax)` — `CREATE TABLE IF NOT EXISTS`.
- `fillTable(string $table, bool $is_ajax, string $insert_type = 'one_operation')` — inserts generated
  rows; `insert_type` ∈ `one_operation` | `cycle` | `transaction`. Skips a table that already has rows.
- `truncateTable(string $table, bool $is_ajax)`, `dropTable(string $table, bool $is_ajax)`.
- `runQuery(string $query_type, bool $is_ajax)` — runs one fixed benchmark query against the test
  tables; unknown/failed queries are caught and reported via messenger.
- `memoryUsage(bool $include_memory = FALSE)` — prints total time / peak-memory status message.
- Static: `tables()`, `getQueryTitles()`.

Table/query identifiers are module constants and fixed form option keys — not request input — so the
raw SQL string-building is not attacker-influenced. Every method is reachable only through the
`administer site configuration` forms or Drush (CLI). These statements create/insert/drop real tables
in the site's database; use on dev/staging only.

```php
// Programmatic benchmark run (equivalent to the UI/Drush).
\Drupal::service('performance_profiler.benchmark')->run($php_results);
\Drupal::service('performance_profiler.database_actions')->run();
```

## Theme hooks

`hook_theme()` defines `performance_profiler_toolbar` (vars `data`, `path`, `short_message`),
`performance_profiler_benchmark_php`, `performance_profiler_benchmark_db`,
`performance_profiler_benchmark_db_actions` (each var `value`); templates live in `templates/`.
`hook_toolbar()` adds the toolbar item (library `performance_profiler/performance_profiler_toolbar`)
and `hook_page_attachments()` attaches `performance_profiler/performance_profiler_dynamic` plus
`drupalSettings.performanceProfiler.path` — both only when the current user has `access performance
profiler`.
