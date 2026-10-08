# Monitoring — Drush commands

Provided by `\Drupal\monitoring\Commands\MonitoringCommands` (`drush.services.yml`,
`monitoring.commands`).

| Command | Alias | Purpose |
|---|---|---|
| `monitoring:run [sensor_name]` | `monitoring-run` | Run all sensors (or one). Returns results with exit code. |
| `monitoring:list-sensors` | `monitoring-list-sensors` | List all sensors (label, name, category, enabled). |
| `monitoring:sensor-config [sensor_name]` | `monitoring-sensor-config` | Show config for all sensors or one. |
| `monitoring:enable <sensor_name>` | `monitoring-enable` | Enable a sensor (`status: true`). |
| `monitoring:disable <sensor_name>` | `monitoring-disable` | Disable a sensor. |
| `monitoring:rebuild` | `monitoring-rebuild` | Rebuild the sensor list (pick up new auto-createable sensors). |

## `monitoring:run` options

- `--force` — bypass the cached result and run fresh.
- `--verbose` — include each sensor's verbose diagnostic output.
- `--output=<...>` and `--expand=sensor` — control output / include full sensor config.
- Sensu integration flags: `--sensu-source`, `--sensu-ttl`, `--sensu-handlers`,
  `--sensu-metric-handlers`, `--sensu-metrics`.
- Standard Drush `--format=` (table/json/yaml/…) applies.

## Examples

```bash
drush monitoring:list-sensors
drush monitoring:run                                  # all sensors
drush monitoring:run core_cron_last_run_age --force   # one sensor, uncached
drush monitoring:run --format=json                    # machine-readable (for Nagios/Sensu/etc.)
drush monitoring:enable core_cron_last_run_age
drush monitoring:disable dblog_404
drush monitoring:rebuild
```

Exit code from `monitoring:run` reflects the worst sensor status, so it can gate CI / alerting.
