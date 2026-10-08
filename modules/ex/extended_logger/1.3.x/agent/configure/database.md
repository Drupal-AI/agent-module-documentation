# Extended Logger DB submodule

Submodule `extended_logger_db` (deps: `extended_logger`, `views`). Adds the `database` log target,
a Views-based log browser, per-entry detail page, and cron auto-cleanup.

- Enabling it (`extended_logger_db_install`) forces `extended_logger.settings:target` to `database`.
- Uninstalling it resets `extended_logger.settings:target` back to `file`.
- Table `extended_logger_logs` (`hook_schema`, class const `ExtendedLoggerDbPersister::DB_TABLE`):
  columns `id` (bigserial), `time` (datetime(6) / timestamp(6)), `severity` (tinyint 0–7),
  `channel` (varchar 64), `message` (text), `data` (JSON — `json`/`jsonb`/text). Indexes on
  `time` and `(time, severity)`.
- Persister service `extended_logger_db.persister` (`ExtendedLoggerDbPersister`) — the core
  `ExtendedLogger` lazy-loads it and calls `->persist($severity, $entry)`; it inserts via the
  Drupal DB API with `json_encode($entry->getData())` as `data`.

## Config object `extended_logger_db.settings`

Form `Drupal\extended_logger_db\Form\SettingsForm` (id `extended_logger_db_settings`) at route
`extended_logger_db.settings` → `/admin/config/development/extended-logger/db`
(permission `administer extended_logger configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cleanup_by_time_enabled` | bool | `true` | Delete rows older than the configured age on cron. |
| `cleanup_by_time_seconds` | int | `8035200` (~3 months) | Age threshold. Form options: 1 week … 1 year. |
| `cleanup_by_rows_enabled` | bool | `false` | Keep only the newest N rows on cron. |
| `cleanup_by_rows_limit` | int | `10000` | Row cap. Form options: 1k / 10k / 100k / 1M. |

`ExtendedLoggerDbManager::cleanupDatabase()` runs both rules; it is called from
`hook_cron` (`extended_logger_db_cron`) and from the form's **Cleanup now** button.

## Pages / routes

- `extended_logger_db.entry` → `/admin/reports/extended-logs/{entry_id}` — controller
  `ExtendedLoggerDbController::entryPage`; renders one entry's fields (`data` JSON expanded).
  Permission: `access site reports` (core).
- The default log listing lives in the shipped view `views.view.extended_logger_logs`
  (`/admin/reports/extended-logs`). The DB settings form links to it and offers a
  **Reset Logs View Page** button (`ExtendedLoggerDbUtils::resetView()` reloads the view from the
  module's `config/install`).

## Views plugins (in `data` for the log table)

Provided under `Drupal\extended_logger_db\Plugin\views`:

| Plugin id | Type | Purpose |
|---|---|---|
| `extended_logger_db_data` | field | Render selected keys from the JSON `data` column (options: `fields`, `max_length`, empty/missing text, `complex_value_render_style`, `hide_empty_values`). |
| `extended_logger_db_time` | field | Format the microsecond `time` column (`date_format`, `timezone`, `link_to_page`). |
| `extended_logger_db_severity` | field | Numeric severity rendering. |
| `extended_logger_db_time_range` | filter | Min/max time range filter. |
| `extended_logger_db_channels` | filter | in-operator filter over channels. |

`extended_logger_db_update_10001` migrates the shipped view config from 1.3.0-beta1 → beta2
(only if the site view is unchanged, otherwise it migrates the `time`/`data` field settings).
