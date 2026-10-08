# Configuration

All of DB Maintenance's behavior comes from one configuration object,
`db_maintenance.settings`, edited on its admin form. Until you configure it, cron
does nothing.

## Grant the permission

The module defines a single permission, **Administer db maintenance**
(`administer db maintenance`), which gates the settings form and the manual run.
Because it lets a user run raw optimization queries and list every table in the
database, grant it only to trusted administrator roles.

```bash
drush role:perm:add administrator 'administer db maintenance'
```

## Open the settings form

Go to **Configuration → System → DB Maintenance**
(`/admin/config/system/db_maintenance`). The form has a handful of fields, described
below.

## Log OPTIMIZE queries

Tick **Log OPTIMIZE queries** (`write_log`) to have the module record which tables
it optimized on each run, and to log a notice when a configured table doesn't exist.
This is useful for auditing but not required — leave it off to keep the log quiet.

## Optimize tables (frequency)

The **Optimize tables** dropdown (`cron_frequency`) controls how often the
optimization runs relative to cron. On each cron tick the module checks whether at
least this much time has passed since the last run before doing anything. The preset
choices are:

- **Run during every cron** — optimize on every cron run.
- Hourly, bi-hourly, daily (the shipped default), bi-daily, weekly, bi-weekly,
  monthly, and bi-monthly.

Pair a low frequency (weekly or monthly) with heavy optimization so it doesn't run
too often.

## Use time interval (maintenance window)

Tick **Use time interval** (`use_time_interval`) to restrict optimization to a daily
window, then fill in **start** and **end** times as `HH:MM` in 24-hour form (for
example `02:00` to `03:00`). When enabled, cron will only optimize if the current
time falls inside that window — ideal for keeping the table locks that `OPTIMIZE
TABLE` causes away from peak traffic. A window that crosses midnight (for example
`23:00`–`01:00`) is supported.

## Which tables to optimize

You have two choices:

- **Optimize all tables** (`all_tables`) — tick this to optimize every base table in
  each database. When on, it ignores any specific selection below.
- **Per-database table lists** (`table_list`) — otherwise, use the multi-select
  lists (one per database connection, including any extra connections defined in
  `settings.php`) to pick exactly the tables you want, such as `watchdog`,
  `sessions`, and the cache tables. Under the hood these are keyed by the actual
  **database name**, not the connection key.

## Save and run

Click **Save configuration**. From then on, cron drives the optimization on the
schedule you set. The **Optimize now.** link on the form (the CSRF-protected
`/db_maintenance` route) triggers an immediate one-off run and returns you to the
form with a status message — handy right after purging a lot of content or
revisions.

## Notes

- There is **no Drush command**; drive optimization via cron, the "Optimize now"
  link, or your own code.
- The last-run gate is stored in **state** (`db_maintenance.cron_last_run`), not in
  config, so it isn't part of your exported configuration.
