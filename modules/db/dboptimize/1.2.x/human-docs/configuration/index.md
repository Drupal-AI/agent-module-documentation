# Configuration

DB Optimize's settings form is where you decide which tables to optimize, trigger a
manual optimization, and set up automatic optimization via cron.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → System → DB Optimize**, or navigate directly to
   `/admin/config/system/dboptimize`.

## Choose which tables to optimize

- **Tables** — enter the names of the tables you want to optimize. **Leave this
  blank to optimize all database tables.** On a busy site, listing the high-churn
  tables (for example `cache_data`, `watchdog`, `sessions`) is a good way to keep
  each run quick and targeted.

This one setting is shared by all three ways of running the module (manual, cron,
and Drush): if table names are configured, only those tables are optimized; if the
list is empty, every table is optimized.

## Run it manually

The form includes a control to **trigger the optimization now**. Because
`OPTIMIZE TABLE` locks each table while it works, run manual optimizations during
low-traffic windows on a live site. When the run finishes, check **Reports →
Recent log messages** (`/admin/reports/dblog`) for the logged result.

## Automatic optimization via cron

DB Optimize integrates with Drupal's cron. Once the module is enabled, each cron
run will optimize your configured tables (or all tables, if you left the list
blank). Make sure cron is scheduled to fire during a quiet period so the table
locks don't disrupt visitors. If you prefer to control timing precisely, disable
reliance on cron and use the Drush command from a scheduled task instead (see
[Installation](../installation/index.md#optimize-from-the-command-line-optional)).

## Save

Click **Save configuration** to store your table list. Your choice then applies to
manual runs, cron runs, and Drush commands alike.
