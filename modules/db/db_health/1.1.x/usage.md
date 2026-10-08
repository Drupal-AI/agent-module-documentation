DB Health records the size and row count of every database table over time and charts the history on an admin report so you can spot bloated or fast-growing tables.

---

DB Health is an administration/reporting module for Drupal 9, 10, and 11. On each cron run — at an interval you choose on its settings form (from every 5 minutes up to once a month, defaulting to daily) — the `DbHealthSizeChecker` service walks every table in the site's database, capturing each table's size in bytes and its row count, plus the total database size stored as a pseudo-table called `db`. Each measurement is written with a Unix timestamp into two dedicated tables (`db_health_sizes` and a normalized `db_health_table_names`), building a historical record of database growth. The report page at `/admin/reports/db-health` reads that history and renders it as an interactive Chart.js visualization, sorting tables largest-first. A separate logs form lets an administrator review the stored snapshots by timestamp and delete selected ones (with a confirmation step), and a Drush command forces an immediate collection outside the cron schedule. MySQL/MariaDB and PostgreSQL are both supported through driver-specific queries. All three pages require the `administer site configuration` permission, so the report is not exposed to unprivileged users.

---

- Track total Drupal database size growth over days, weeks, and months.
- Identify which individual tables are consuming the most disk space.
- Spot tables that are growing unexpectedly fast between measurements.
- Monitor per-table row counts alongside byte sizes.
- Diagnose database bloat from logging, cache, or queue tables (e.g. `watchdog`, `sessions`, `cache_*`, `queue`).
- Detect runaway growth in `paragraphs`, revision, or field-data tables.
- Establish a historical baseline before a large content import or migration.
- Compare table sizes before and after running maintenance or cleanup tasks.
- Support capacity-planning and scaling decisions with real trend data.
- Decide which tables are candidates for archiving or truncation.
- Visualize database trends on an admin dashboard chart without external tooling.
- Sort tables by size to prioritize optimization work.
- Configure how frequently metrics are collected to balance detail against overhead.
- Run an on-demand database health snapshot from the command line with `drush db-health:run`.
- Integrate database-size collection into CI/CD or server cron via the Drush command.
- Review a timeline of measurement snapshots and prune old ones to control history-table size.
- Delete a specific bad or test measurement snapshot by its timestamp.
- Keep long-term growth history that survives across deployments.
- Provide administrators a quick current-state view of database composition.
- Monitor both MySQL/MariaDB and PostgreSQL Drupal databases with the same module.
- Verify the effect of a module uninstall or content purge on database size.
- Catch tables left behind (measured at size 0) after their source tables are dropped.
- Feed a regular cron-driven monitoring routine for production database health.
