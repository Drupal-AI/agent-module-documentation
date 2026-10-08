DB Optimize runs MySQL/MariaDB table maintenance — OPTIMIZE, ANALYZE, CHECK and REPAIR — plus a full-database backup, from an admin UI, cron, or Drush.

---

DB Optimize (`dboptimize`) gives site administrators a single place to keep the database healthy on MySQL/MariaDB sites. From `/admin/config/system/dboptimize` it provides four table-maintenance forms — Optimize (reclaim space / defragment), Analyze (refresh optimizer statistics), Check (verify table/index integrity) and Repair (fix corrupted tables) — each with a searchable, sortable table picker and a confirmation step before anything runs. Operations execute through the Batch API so large selections stream progress and results. The same four operations can run automatically on cron, per operation, at a configurable frequency (hourly through yearly), executed either directly inside `hook_cron` or handed off to queue workers for background processing; per-operation last-run time, duration and last error are recorded and shown on the settings page. A Drush command set mirrors the UI (`dboptimize:optimize|analyze|check|repair`, plus `dboptimize:cron-*` handlers) for scripting and CI. An Overview page summarises total database size, groups table sizes by content area (nodes, media, taxonomy, paragraphs, cache, etc.) and lists the largest tables, and a Backup form produces a downloadable (optionally gzip-compressed) `mysqldump` of the whole database. All routes require the `administer site configuration` permission. Tested on MySQL and MariaDB; PostgreSQL is not implemented.

---

- Reclaim space and defragment bloated tables such as `cache_*`, `watchdog` and `sessions` after heavy churn.
- Optimize a hand-picked set of tables from the Optimize form, with a confirmation screen listing exactly what will run.
- Search/filter the table list by name and sort by rows, size (MB) or free space to find the worst offenders.
- Analyze tables to refresh the query optimizer's statistics after large data imports or deletions.
- Check tables to detect corruption or index errors before it causes site failures.
- Repair corrupted MyISAM/Aria tables flagged by a prior Check run.
- Schedule daily optimization of cache tables via cron without manual intervention.
- Configure a different cron frequency per operation (e.g. optimize weekly, check monthly).
- Enable only the operations you want on cron and leave the others UI-only.
- Choose between running cron operations directly in `hook_cron` or enqueuing them to queue workers for background execution.
- Restrict a cron operation to a specific list of tables, or leave the selection empty to process every table.
- Review each operation's last run time, duration and last error on the settings page, and reset those metrics when needed.
- Run optimization from the command line in CI/CD: `drush dboptimize:optimize --tables=cache_data,watchdog`.
- Analyze or check specific tables from a deploy script: `drush dboptimize:analyze --tables=node,users`.
- Trigger a cron handler on demand and ignore its frequency gate: `drush dboptimize:cron-optimize --bypass-last-run`.
- See total database size and the percentage contributed by nodes, media, taxonomy, paragraphs, comments and cache on the Overview page.
- Identify the ten largest tables to target maintenance or storage planning.
- Download a full `mysqldump` backup of the database (optionally gzip-compressed) before running risky maintenance.
- Automate routine database maintenance on staging and production as part of a scheduled housekeeping workflow.
- View the outcome of each batch run (per-table status and messages) on the Results page.
- Consult the built-in Help page for the list of Drush commands and example invocations.
