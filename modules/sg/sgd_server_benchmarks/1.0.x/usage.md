<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Guardian Server Benchmarks provides on-demand PHP, database, and file-IO benchmarks and surfaces the most recent results on Drupal's Status report.

---

The benchmarks run only when an administrator visits **Administration → Reports → Server benchmarks** (`/admin/reports/server-benchmarks`) and submits the form with a chosen iteration count — importantly they are *not* run during a status-report render or an API call, because a benchmark deliberately taxes the server. PHP benchmarks cover math, string, loops, if/else, a prime sieve, and N-Queens; database benchmarks time connect/select/query plus a `SELECT BENCHMARK(...)`; file-IO benchmarks time read, write, zip, and unzip of a small file in the temp directory. Results are timed in seconds and stored in `sgd_server_benchmarks.config`.

Those stored results are then read back in two places: `hook_requirements()` adds PHP/DB/IO summary lines (with the last-run date and iteration count) to the Status report, and `hook_site_guardian_status()` returns the full result set to the Site Guardian API when that companion module is installed. The module needs no configuration and has no settings of its own. The report route is gated by the `administer site configuration` permission; the DB benchmark is skipped gracefully if the `mysqli` extension is absent.

---
- Benchmark raw PHP compute (math, strings, loops, prime sieve, N-Queens) on a server
- Time database connect/select/query performance from within Drupal
- Time file read/write/zip/unzip throughput in the temp directory
- Compare server performance across hosting environments
- Record a performance baseline and re-run after an infrastructure change
- Show the last benchmark results on the Status report for at-a-glance health
- Feed detailed benchmark data to the Site Guardian API for remote monitoring
- Run benchmarks manually with a chosen iteration count
- Increase iterations for a heavier, more stable measurement
- Detect a slow disk or database tier via the IO/DB tables
- Keep benchmarks out of the status-report render path (run only on demand)
- Confirm the `mysqli` extension is present via the DB-benchmarks-unavailable notice
- Capture the last-run timestamp and iteration count alongside results
- Sanity-check a new server before go-live
- Provide performance context to a Site Guardian consumer without extra config
- Diagnose a performance regression by re-running and comparing seconds