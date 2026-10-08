# Configure DB Maintenance

All configuration is the single config object **`db_maintenance.settings`**, edited from the
admin form or with drush. Configure route: `db_maintenance.admin_settings` →
`/admin/config/system/db_maintenance` (permission `administer db maintenance`).

## Settings keys (with shipped defaults)

```yaml
cron_frequency: 86400        # int seconds between runs; 0 = "Run during every cron"
use_time_interval: false     # only optimize inside a daily time window
time_interval_start: '01:30' # 'HH:MM' 24h; only used when use_time_interval is true
time_interval_end: '02:30'   # 'HH:MM' 24h
all_tables: false            # optimize ALL base tables (ignores table_list when true)
write_log: false             # log optimized tables to the db_maintenance logger channel
table_list: {}               # sequence keyed by DATABASE NAME -> list of table names
```

- `cron_frequency` — the admin form exposes preset options: `0` (every cron), `3600` hourly,
  `7200` bi-hourly, `86400` daily, `172800` bi-daily, `604800` weekly, `1209600` bi-weekly,
  `2592000` monthly, `5184000` bi-monthly.
- `time_interval_start` / `time_interval_end` must be `HH:MM` 24-hour (validated). A window that
  crosses midnight is supported (e.g. `23:00`–`01:00`).
- `all_tables: true` optimizes every base table in each database and makes `table_list` moot.
- `table_list` is keyed by the **database name** (the value of `$databases[<key>]['default']['database']`,
  usually the site's default DB name — in DDEV that is `db`, not the connection key `default`).
  Each entry is a map/list of table names (unprefixed) to optimize.

## Read it back

```bash
drush cget db_maintenance.settings
drush cget db_maintenance.settings cron_frequency
```

## Set values with drush

```bash
# Optimize all tables on every cron run:
drush cset db_maintenance.settings all_tables true -y
drush cset db_maintenance.settings cron_frequency 0 -y

# Restrict runs to a nightly window:
drush cset db_maintenance.settings use_time_interval true -y
drush cset db_maintenance.settings time_interval_start '02:00' -y
drush cset db_maintenance.settings time_interval_end '03:00' -y
```

## Select specific tables in PHP

`table_list` is nested (database name → table map), so set it programmatically:

```php
$config = \Drupal::configFactory()->getEditable('db_maintenance.settings');
$db = \Drupal::database()->getConnectionOptions()['database']; // e.g. 'db'
$config->set('table_list.' . $db, ['watchdog' => 'watchdog', 'sessions' => 'sessions'])->save();
```

## Via the admin UI

1. Go to *Configuration → System → DB Maintenance* (`/admin/config/system/db_maintenance`).
2. Optionally tick **Log OPTIMIZE queries** (`write_log`).
3. Pick **Optimize tables** frequency (`cron_frequency`).
4. Optionally tick **Use time interval** and fill **start**/**end** (`HH:MM`).
5. Either tick **Optimize all tables** (`all_tables`) or multi-select tables per database in the
   **Tables in the … database** list (`table_list`).
6. **Save configuration.** The **Optimize now.** link on the form triggers an immediate run.

## Config schema

`db_maintenance.settings` is a `config_object`; `table_list` is a nested `sequence` of strings.
