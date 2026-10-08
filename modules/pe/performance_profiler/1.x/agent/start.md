<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Performance Profiler (performance_profiler) — agent index

Logs each request's **page build time**, **peak memory** and (optionally) **database-query stats**,
and can also run standalone **PHP** and **MySQL** benchmarks. A kernel `REQUEST` subscriber
(`performance_profiler.event_subscriber`, priority -100) starts a `Timer` and, when DB logging is on,
`Database::startLog('performance_profiler_db')`; it registers `performance_profiler_shutdown` →
`performance_profiler_shutdown_final`, which on shutdown reads timer/peak-memory/DB logs and routes
them to the configured sinks: **watchdog** (dblog), a **toolbar** item, and/or a bottom-right
**popup** refreshed by an AJAX call. Collected per-request data is written to the caller's own
**private tempstore** (keyed `performance_profiler_<session_id>`) and only when the current user holds
`access performance profiler`; the AJAX route reads it back and clears it. Two admin forms run
benchmarks: a PHP/DB run form and a DB-actions form that creates/fills/queries/truncates/drops
throwaway `performance_profiler_db_test_*` tables to measure raw MySQL performance.

- Depends on: nothing (`dependencies` empty). Soft-integrates core **`toolbar`** (toolbar sink is
  disabled in the form when toolbar is absent) and, if present, **`memcache`** (adds memcache timing).
- Core: `^10.1 || ^11`. Package: `Development`. Tags: `developer`.
- Has a settings page — `configure: performance_profiler.settings`
  (`/admin/config/development/performance-profiler`), gated by `administer site configuration`.
- One permission: **`access performance profiler`** (`restrict access: TRUE`) — required to see the
  toolbar/popup/AJAX output. Not granted to any role by default.
- Provides **Drush** commands (`pp-php`, `pp-db`). No plugin types. No config schema shipped. No
  fields, no entities.

## What you'd do → where

- **Turn profiling on/off, choose sinks (watchdog/toolbar/popup), enable DB logging, set
  memory/time thresholds, control anonymous logging** → [configure/settings.md](configure/settings.md)
- **Run PHP / MySQL benchmarks from the UI or understand the DB-actions form** →
  [configure/settings.md](configure/settings.md)
- **Call the benchmark / database-actions services from code, understand the shutdown-profiling
  mechanism, the AJAX route/tempstore, and the theme hooks** → [api/services.md](api/services.md)
- **Run the benchmarks from the command line** → [drush/commands.md](drush/commands.md)

## Key facts (real machine names)

- Routes: `performance_profiler.settings` (`/admin/config/development/performance-profiler`, form
  `PerformanceProfilerForm`, `administer site configuration`), `performance_profiler.run`
  (`…/run`, form `PerformanceProfilerRunForm`), `performance_profiler.database` (`…/database`, form
  `PerformanceProfilerDbForm`) — all three `administer site configuration`;
  `performance_profiler.ajax_performance_data` (`/performance-profiler/ajax/performance-data`,
  controller `Controller\AjaxPerformanceData::get`, `access performance profiler`).
- Form ids: `performance_profiler_settings`, `performance_profiler_run`, `performance_profiler_database`.
- Services: `performance_profiler.event_subscriber` (`EventSubscriber\PerformanceProfilerEventSubscriber`),
  `performance_profiler.database_actions` (`PerformanceDatabaseActions`),
  `performance_profiler.benchmark` (`PerformanceBenchmark`), `performance_profiler.commands` (Drush).
- Config object: `performance_profiler.settings` — keys `watchdog`, `toolbar`, `popup`, `anonymous`,
  `database`, `self`, `ajax`, `memory`, `time`. Install defaults: **`popup: 1`**, all others `0`/`''`.
- Permission: `access performance profiler` (restrict access). Menu link `performance_profiler.settings`
  under `system.admin_config_development`; local tasks `Settings` / `Benchmarks` / `Database actions`.
- Libraries: `performance_profiler/performance_profiler`, `…/performance_profiler_toolbar`,
  `…/performance_profiler_dynamic`.
- Theme hooks (templates in `templates/`): `performance_profiler_toolbar`,
  `performance_profiler_benchmark_php`, `performance_profiler_benchmark_db`,
  `performance_profiler_benchmark_db_actions`.
- Hooks implemented: `hook_theme`, `hook_toolbar`, `hook_page_attachments`; procedural shutdown
  functions `performance_profiler_shutdown` / `_shutdown_final` and helper
  `performance_profiler_db_get_results()`.
- DB benchmark constants (`PerformanceDatabaseActions`): `TABLE_PREFIX = performance_profiler_db_test_`,
  `QUERY_TYPES = [select, select_sort, select_sort_no_index, select_like, join, join_two]`; test tables
  `main`, `ref_by_uuid`, `ref_by_id`. DB log channel/logger id: `performance_profiler_db`.
- Drush: `pp-php` (alias `pp-php`), `pp-db` (alias `pp-db`).
