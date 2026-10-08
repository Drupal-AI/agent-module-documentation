<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DB Cleanups truncates Drupal's `cache_*` tables and the `watchdog` (dblog) table on a cron schedule, with optional `OPTIMIZE TABLE` and a manual "Run Cleanup Now" trigger.

---

DB Cleanups is a small, dependency-free maintenance module that keeps Drupal's log and cache tables from bloating on busy or storage-constrained sites. On each cron run (`hook_cron` in `db_cleanups.module`) it compares the current time against per-task "last run" timestamps stored in State and, when the configured interval has elapsed, truncates the `watchdog` table and every `cache_*` table (discovered with `SHOW TABLES LIKE 'cache_%'`), optionally running `OPTIMIZE TABLE` on each to reclaim disk space. Two intervals are configurable in hours (`watchdog_interval`, default 1; `cache_interval`, default 8) plus an `optimize_tables` toggle (default on), all held in the `db_cleanups.settings` config object and edited at `/admin/config/development/db-cleanup` (route `db_cleanups.settings`, gated by the `administer site configuration` permission). The same settings form offers a "Run Cleanup Now" button that immediately truncates both, then reports database size before/after and space saved. Note that truncating `watchdog` discards audit/diagnostic log history, and truncating cache tables forces a cold-cache rebuild; treat this as a privileged, destructive admin maintenance task.

---

- Automatically trim the `watchdog` (dblog) table on a schedule to cap log growth.
- Automatically truncate all `cache_*` tables on a schedule.
- Keep the database small on shared or resource-restricted hosting.
- Reclaim disk space by running `OPTIMIZE TABLE` after each truncation.
- Set how often watchdog is cleared (hours) via `watchdog_interval`.
- Set how often cache tables are cleared (hours) via `cache_interval`.
- Toggle the post-cleanup optimize step with `optimize_tables`.
- Manually purge cache and watchdog immediately with "Run Cleanup Now".
- See database size before, after, and space saved after a manual run.
- Use core cron to schedule cleanups without an external scheduler.
- Combine cache and log cleanup in one lightweight module.
- Reduce backup size and dump time by keeping log/cache tables lean.
- Predictably control cache table growth on high-traffic sites.
- Avoid manual `TRUNCATE` SQL by an admin each maintenance window.
- Prevent `dblog` from silently accumulating millions of rows.
- Configure everything from Administration → Configuration → Development.
- Run as an admin-only maintenance task (no custom permission added).
- Deploy on sites with no Composer or library requirements beyond core.
- Improve query performance on fragmented cache/log tables via optimize.
- Force a clean cache rebuild on a schedule for troubleshooting stale-cache issues.
- Pair with core Database Logging (dblog) to bound its footprint.
- Use on MySQL/MariaDB where `SHOW TABLES` and `OPTIMIZE TABLE` are supported.
- Complement (not replace) core's own cache-clear tooling with timed automation.
- Give operators one place to configure log + cache retention intervals.
