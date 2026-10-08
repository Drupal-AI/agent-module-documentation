# Settings & benchmark forms (configure)

Three admin routes, all under `/admin/config/development/performance-profiler` and all gated by
`administer site configuration`:

| Route | Path | Form | Purpose |
|---|---|---|---|
| `performance_profiler.settings` | `/admin/config/development/performance-profiler` | `Form\PerformanceProfilerForm` (`performance_profiler_settings`) | Edit profiler behaviour (writes `performance_profiler.settings`). |
| `performance_profiler.run` | `…/run` | `Form\PerformanceProfilerRunForm` (`performance_profiler_run`) | AJAX buttons: "Run PHP benchmark", "Run Database benchmark". |
| `performance_profiler.database` | `…/database` | `Form\PerformanceProfilerDbForm` (`performance_profiler_database`) | Manually create/fill/query/truncate/drop the DB-test tables. |

Local tasks (`performance_profiler.links.task.yml`): **Settings**, **Benchmarks** (`.run`),
**Database actions** (`.database`). Menu link `performance_profiler.settings` sits under
`system.admin_config_development`.

## Settings form fields → config keys

`PerformanceProfilerForm` (a `ConfigFormBase`) edits the config object `performance_profiler.settings`.
Keys and install defaults (`config/install/performance_profiler.settings.yml`):

| Config key | Form label / group | Default | Effect |
|---|---|---|---|
| `watchdog` | Appearance › Log statistics into watchdog | `0` | Log each request's timing/memory/DB summary via `\Drupal::logger('performance_profiler')->debug()` (viewable in dblog). |
| `toolbar` | Appearance › Log statistics into Toolbar | `0` | Add a toolbar item that polls the AJAX route. Checkbox is force-disabled when the core `toolbar` module is not installed. |
| `popup` | Appearance › Log statistics into Popup | **`1`** | Attach the dynamic JS/CSS that shows a bottom-right popup polling the AJAX route. |
| `anonymous` | Appearance › Log statistics for anonymous user | `0` | Allow collecting stats for anonymous requests (see gating below). |
| `database` | Log entries › Log Database queries | `0` | Start `Database::startLog('performance_profiler_db')` on the request and summarise read/write counts, timings and the top-20 slow queries. |
| `self` | Log entries › Log self AJAX query | `0` | Include the profiler's own AJAX route (`performance_profiler.ajax_performance_data`) in stats. Normally off. |
| `ajax` | Log entries › Log AJAX queries | `0` | Include XHR requests in stats. When off, any `isXmlHttpRequest()` request is skipped. |
| `memory` | Track › Min memory usage to track (Mb) | `''` | If numeric and `>0`, only record requests whose peak memory ≥ this. |
| `time` | Track › Min execution time to track (seconds) | `''` | If numeric and `>0`, only record requests whose run time ≥ this. A request is skipped only when **both** the memory and time thresholds exclude it. |

`submitForm()` writes all nine keys back to `performance_profiler.settings`. No config schema file is
shipped (`config/schema/` is absent), so these keys are untyped in config inspection.

## Who can see the output (access model)

- The **toolbar** (`hook_toolbar`), the **popup** attachment (`hook_page_attachments`), and the
  per-request tempstore write in `performance_profiler_shutdown_final()` are **all gated by
  `\Drupal::currentUser()->hasPermission('access performance profiler')`**. Collected data is stored
  in the caller's **own** private tempstore (`tempstore.private`, key `performance_profiler_<session_id>`),
  and the AJAX route `performance_profiler.ajax_performance_data` (also `_permission: access performance
  profiler`) reads it back and immediately clears it.
- `access performance profiler` is declared `restrict access: TRUE` and is **not granted to any role
  by default** — so although `popup` defaults to on, no toolbar/popup/AJAX output is shown until an
  administrator grants the permission. Grant it deliberately, and only to trusted operators, since the
  output can include DB query text and file paths.
- **Anonymous:** in `performance_profiler_shutdown_final()`, anonymous requests are recorded only when
  **both** `anonymous` and `watchdog` are enabled; anonymous timing/memory then goes to the log
  (dblog is admin-only). Toolbar/popup still require the permission regardless.

## Benchmark run form (`performance_profiler.run`)

Two `#ajax` buttons. "Run PHP benchmark" calls `performance_profiler.benchmark`→`run()` (math/string/
loop/if-else micro-benchmarks) and renders `performance_profiler_benchmark_php`. "Run Database
benchmark" calls `performance_profiler.database_actions`→`run(TRUE)`, which drops→creates→fills→queries→
drops the test tables and renders `performance_profiler_benchmark_db`. Nothing is persisted to config.

## Database actions form (`performance_profiler.database`)

Manual control of the throwaway MySQL test tables (`performance_profiler_db_test_main`,
`…_ref_by_uuid`, `…_ref_by_id`). Pick an **Action** (`create` / `fill` / `query` / `truncate` /
`drop`), the target **Tables** (checkboxes constrained to the known table ids), and — for `fill` —
an insert strategy (`one_operation` / `cycle` / `transaction`, up to 10 000 generated rows per table).
`query` runs one of the fixed `QUERY_TYPES`. All work is delegated to the
`performance_profiler.database_actions` service (see [../api/services.md](../api/services.md)); these
are real `CREATE/INSERT/DROP` statements against the live database, so run them only on dev/staging.
