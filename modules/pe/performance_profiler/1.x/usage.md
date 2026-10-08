<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Performance Profiler logs each request's page build time, peak memory and optional database-query statistics, and can run standalone PHP and MySQL benchmarks.

---

Install it with Composer (`composer require drupal/performance_profiler`) and enable it like any module; it has no dependencies, though the toolbar output needs core's **Toolbar** module. Configure it at **`/admin/config/development/performance-profiler`** (requires *administer site configuration*): under **Appearance** choose where stats appear — **watchdog** (dblog), the **Toolbar**, and/or a bottom-right **popup**; under **Log entries** turn on **Log Database queries** to capture read/write counts, timings and the 20 slowest queries, and control whether the profiler's own AJAX call and other XHR requests are counted; under **Track** set minimum memory (Mb) and time (seconds) thresholds so only heavy requests are recorded. The toolbar/popup output is shown only to users with the **`access performance profiler`** permission (grant it to trusted operators). To benchmark raw environment performance, use **`/admin/config/development/performance-profiler/run`** for PHP and DB benchmarks, and **`/admin/config/development/performance-profiler/database`** to manually create, fill, query, truncate or drop throwaway `performance_profiler_db_test_*` tables; the same benchmarks run from the CLI via `ddev drush pp-php` and `ddev drush pp-db`. Note that the DB benchmark and database-actions tooling create and drop real tables, so run them on dev/staging rather than production.

---

- Log page build time per request.
- Log peak memory usage per request.
- Log database query counts and timings.
- Identify the 20 slowest queries on a page.
- See per-module database query time and count.
- Send stats to watchdog / dblog.
- Show stats in the admin toolbar.
- Show stats in a bottom-right popup.
- Find slow pages during development.
- Spot memory-heavy pages.
- Set a minimum time threshold to record only slow requests.
- Set a minimum memory threshold to record only heavy requests.
- Include or exclude AJAX/XHR requests from stats.
- Optionally collect stats for anonymous requests.
- Restrict who sees profiler output via the access permission.
- Run a PHP micro-benchmark (math, string, loop, if-else).
- Run a full MySQL benchmark cycle.
- Manually create/fill/query/truncate/drop DB test tables.
- Compare insert strategies (single, per-row, transaction).
- Compare raw performance across environments.
- Run benchmarks from the command line with Drush (`pp-php`, `pp-db`).
- Add memcache timing when the memcache module is present.
- Enable profiling only when investigating, then disable it.
- Keep diagnostic output limited to operators.
