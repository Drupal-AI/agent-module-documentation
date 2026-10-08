# Configure Cleaner

Settings form `Drupal\cleaner\Form\CleanerSettingsForm` (id `cleaner_settings_form`) at route
`cleaner.settings` → `/admin/config/system/cleaner`, permission `administer site configuration`.
All values are stored in the `cleaner.settings` config object. **The module ships with every
function disabled; nothing runs until you set an interval and enable at least one function.**

## Config keys (`cleaner.settings`)

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `cleaner_cron` | integer (seconds) | `0` | Run interval. `0` = "Every time" (every cron run). Form offers preset steps: 900, 1800, 3600, 7200, 14400, 21600, 43200, 86400, 172800, 259200, 604800. |
| `cleaner_last_cron` | integer | `0` | Internal bookkeeping — timestamp of the last cron run. Do not set by hand. |
| `cleaner_clear_cache` | boolean | `false` | Flush the injected cache backend, then `TRUNCATE` every `cache_%` table (excluding `cachetags`). |
| `cleaner_additional_tables` | string | `''` | Comma-separated list of extra table names to `TRUNCATE` on each run. |
| `cleaner_empty_watchdog` | boolean | `false` | `TRUNCATE {watchdog}`. Field only appears when `dblog` is enabled; if `dblog` is off the module forces this to `false`. |
| `cleaner_clean_sessions` | boolean | `false` | Delete rows from `sessions` older than the PHP session cookie lifetime. |
| `cleaner_optimize_db` | integer | `0` | MySQL only. `0` no, `1` `OPTIMIZE TABLE`, `2` `OPTIMIZE LOCAL TABLE` (no replication). Field only appears on the `mysql` driver. Only tables with `Data_free` overhead are optimized. |

Config schema: `config/schema/cleaner.schema.yml` (`type: config_object`, label "Cleaner settings").

## What happens at runtime

1. `cleaner_cron()` (in `cleaner.module`, `hook_cron`) reads `cleaner_cron` and
   `cleaner_last_cron`. It dispatches `CleanerRunEvent` (`cleaner.run`) when
   `request_time >= cleaner_last_cron + cleaner_cron`.
2. `cleaner_last_cron` is overwritten with the current request time on **every** cron run.
   So with a non-zero interval the event fires only when the gap since the previous cron run
   is at least `cleaner_cron` seconds; `0` ("Every time") fires on every cron run.
3. Each subscriber (priority 100 on `cleaner.run`) re-checks its own config flag before acting,
   and logs to the `cleaner` logger channel. See [../events/cleaner-run.md](../events/cleaner-run.md).

## Set values without the form

Drush:

```bash
drush config:set cleaner.settings cleaner_cron 3600 -y
drush config:set cleaner.settings cleaner_clear_cache true -y
drush config:set cleaner.settings cleaner_clean_sessions true -y
drush config:set cleaner.settings cleaner_additional_tables 'cache_mymodule,queue_tmp' -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('cleaner.settings')
  ->set('cleaner_cron', 3600)
  ->set('cleaner_optimize_db', 2)
  ->save();
```

## Notes

- `cleaner_additional_tables` truncates whatever real tables you name — there is no allowlist
  beyond an existence check, so only list tables that are safe to empty (it will happily
  truncate content tables if you name them). Names are trimmed and `Xss::filter`'d, then each
  is checked with `tableExists()` before truncation.
- Cache/table truncation and DB optimization are MySQL/MariaDB-oriented; `OPTIMIZE` is skipped
  on non-MySQL drivers (logged as an error).
