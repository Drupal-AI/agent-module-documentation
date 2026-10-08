# Monitoring — sensor config, thresholds & global settings

## Global settings — `monitoring.settings` (route `monitoring.settings`, `/admin/config/system/monitoring/settings`)

| Key | Default | Meaning |
|---|---|---|
| `sensor_call_logging` | `on_request` | when to log sensor calls (`none` / `on_request` / `all`) |
| `watchdog_logging` | `false` | also send results to watchdog |
| `cron_run_sensors` | `false` | run sensors during cron |
| `disable_sensor_autocreate` | `false` | never auto-create sensors from config changes |

Read/write with drush: `drush cget monitoring.settings cron_run_sensors` /
`drush cset monitoring.settings cron_run_sensors true`.

## Sensor config entity — `monitoring_sensor_config` (config prefix `monitoring.sensor_config.<id>`)

One config entity per sensor. Schema `monitoring.sensor_config.*`:

| Field | Meaning |
|---|---|
| `id`, `label`, `description` | identity |
| `category` | grouping, e.g. `Cron`, `Content`, `Watchdog` |
| `plugin_id` | the `SensorPlugin` id that implements it (e.g. `cron_last_run_time`, `config_value`) |
| `value_type` | one of `no_value`, `number`, `string`, `time_interval`, `bool` (see `monitoring_value_types()`) |
| `value_label` | label for the value |
| `status` | boolean — enabled/disabled |
| `caching_time` | seconds to cache the result |
| `result_class` | optional custom `SensorResult` class |
| `settings` | plugin-specific settings (schema `monitoring.settings.<plugin_id>`) |
| `thresholds` | see below |

### Thresholds

`thresholds.type` is one of `exceeds`, `falls`, `inner`, `outer`, with integer bounds
`warning`/`critical` (and `*_low` / `*_high` for inner/outer). Example (`core_cron_last_run_age`):

```yaml
value_type: time_interval
thresholds:
  type: exceeds
  warning: 86400     # WARNING when age > 1 day
  critical: 259200   # CRITICAL when age > 3 days
```

## Admin UI

- Sensor overview / add / edit / delete: `/admin/config/system/monitoring/sensors`
  (`monitoring.sensors_overview_settings`, `entity.monitoring_sensor_config.edit_form`,
  `monitoring.sensor_add`). "Rebuild sensor list" at `…/sensors/rebuild`.
- Results report + per-sensor detail: `/admin/reports/monitoring`,
  `/admin/reports/monitoring/sensors/{monitoring_sensor_config}`.
- Force run: `monitoring/sensors/force` (all) or `…/force/{sensor}` (one) — needs `monitoring force run`.

## Enable / disable / tune a sensor (config, no UI)

```bash
drush monitoring:enable core_cron_last_run_age      # set status: true
drush monitoring:disable core_cron_last_run_age     # set status: false
drush cget monitoring.sensor_config.core_cron_last_run_age status
```

Or in code / config: load the `monitoring_sensor_config` entity, set `status`, `thresholds` or
`settings`, and save. Auto-created default sensors ship in `config/install`
(e.g. `monitoring.sensor_config.core_cron_last_run_age.yml`).
