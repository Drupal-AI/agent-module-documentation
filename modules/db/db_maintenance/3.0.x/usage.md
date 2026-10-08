DB Maintenance periodically runs a database optimization query (`OPTIMIZE TABLE` on MySQL/MariaDB, `VACUUM` on PostgreSQL) on selected tables during Drupal cron, to reclaim space and defragment tables.

---

The module adds an admin settings form at `/admin/config/system/db_maintenance` (route `db_maintenance.admin_settings`, permission `administer db maintenance`) where you pick which database tables should be optimized and how often. On each `hook_cron()` run it checks whether enough time has elapsed since the last run (the `cron_frequency` config value, from "every cron" up to bi-monthly) and, optionally, whether the current time falls inside a configured `time_interval_start`–`time_interval_end` window; if so it issues the engine-appropriate optimization query for each configured table. Tables can be chosen per database (the site's default connection plus any extra connections in `settings.php`), or you can flip `all_tables` on to optimize every base table without listing them. A driver factory picks a `MySqlHandler` (`OPTIMIZE TABLE`) or `PgSqlHandler` (`VACUUM`) based on the active connection, and table names are un-prefixed before the raw SQL is issued. Optional `write_log` logging records which tables were optimized (or were configured but missing). All settings live in the `db_maintenance.settings` config object; the last cron run timestamp is kept in state (`db_maintenance.cron_last_run`). A link/route (`/db_maintenance`, `db_maintenance.optimize_tables_page`, CSRF-protected) lets an admin trigger an "Optimize now" run on demand. There is no field, entity, or plugin type — it is a small cron-driven utility.

---

- Automatically defragment high-churn tables like `cache_*`, `watchdog`, `sessions`, or `queue` on a schedule.
- Reclaim disk space (reduce "overhead") from MyISAM tables that see large deletions.
- Run `VACUUM` on frequently-updated PostgreSQL tables to reclaim storage from dead tuples.
- Optimize a specific short-list of tables during cron rather than the whole database.
- Optimize every base table in the database by enabling "Optimize all tables" instead of listing each one.
- Schedule optimization at a fixed cadence (every cron, hourly, daily, weekly, monthly, bi-monthly).
- Constrain optimization to run only inside a quiet maintenance window (e.g. 01:30–02:30) to avoid table locks during peak traffic.
- Trigger an immediate one-off optimization from the admin form via the "Optimize now" link.
- Log to watchdog which tables were optimized on each run for auditing.
- Detect misconfiguration: log a notice when a configured table does not exist in the database.
- Optimize tables across multiple databases when extra connections are defined in `settings.php`.
- Keep MySQL InnoDB tables rebuilt periodically after bulk data churn.
- Reduce index bloat on tables that grow and shrink repeatedly (import/export workloads).
- Deploy optimization settings as exported config (`db_maintenance.settings`) across environments.
- Gate who can configure maintenance with the `administer db maintenance` permission.
- Avoid writing a custom cron hook just to run periodic `OPTIMIZE TABLE`/`VACUUM`.
- Pair with a low cron frequency so heavy optimization only happens weekly or monthly.
- Keep the `search_api`/log/cache tables lean on a busy editorial site.
- Add DB housekeeping to a site without shell/SQL access by non-DBA admins.
- Ensure optimization only fires overnight by combining the time-interval window with a daily frequency.
- Run optimization on every cron tick during a one-time cleanup, then dial the frequency back down.
- Standardise database maintenance across a fleet of sites via a shared config export.
- Recover space after purging large volumes of content, revisions, or log rows.
- Schedule maintenance to skip weekends implicitly by choosing a weekly frequency aligned to a weekday cron.
- Give editors a self-service "optimize now" button instead of opening a database client.
