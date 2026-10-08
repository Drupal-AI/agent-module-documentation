Monitoring provides a pluggable "sensor" framework for Drupal: each sensor measures one metric or process (cron age, watchdog errors, requirements, disk/opcache usage, content/user activity, config/state values, …), evaluates it against thresholds, and exposes an OK/WARNING/CRITICAL/UNKNOWN result through a UI, Drush, and REST — ready to feed Nagios/Icinga, Prometheus, or Munin.

---

Sensors are `SensorPlugin` plugins (attribute `#[SensorPlugin]`, manager `monitoring.sensor_manager`, namespace `Plugin/monitoring/SensorPlugin`) paired with a `monitoring_sensor_config` config entity that stores each sensor's `plugin_id`, `category`, `value_type`, `status`, `caching_time`, plugin `settings`, and `thresholds` (type `exceeds`/`falls`/`inner`/`outer` with `warning`/`critical` bounds). The module ships ~40 sensor plugins and auto-creates sensors for core requirements, watchdog, cron, content entities and more when related modules are installed (`hook_modules_installed`). The `monitoring.sensor_runner` service runs sensors (with result caching) and returns `SensorResultInterface` objects; procedural helpers (`monitoring_sensor_run()`, `monitoring_sensor_run_multiple()`, `monitoring_sensor_result_last()`) wrap it. Results are viewable at `/admin/reports/monitoring`, sensors are managed at `/admin/config/system/monitoring/sensors`, and global behavior (call logging, watchdog logging, running sensors on cron) is at `/admin/config/system/monitoring/settings` (`monitoring.settings`). Drush commands (`monitoring:run`, `:list-sensors`, `:enable`, `:disable`, `:rebuild`, `:sensor-config`) drive it from CLI, and REST resources expose sensor config and results. Four permissions gate it: `administer monitoring`, `monitoring reports`, `monitoring verbose`, `monitoring force run`. Two hooks let other modules react (`hook_monitoring_run_sensors`) or alter sensor links (`hook_monitoring_sensor_links_alter`). Submodules add escalation email, multigraphs, a Prometheus exporter, a demo, and test fixtures.

---

- Get a single dashboard of site health at `/admin/reports/monitoring` (OK/WARNING/CRITICAL per sensor).
- Alert when cron has not run recently via the `core_cron_last_run_age` sensor and its thresholds.
- Watch watchdog/dblog for error, 404, and severity-based entry counts.
- Surface failing core "Status report" requirements as monitoring sensors.
- Monitor disk usage, database disk usage, and temporary file usage.
- Track OPcache memory/usage/files and APCu shared-memory metrics.
- Monitor system load average and system memory.
- Alert on new users, active users, and open user sessions.
- Detect failed login attempts (including for non-existent users) as a security signal.
- Check that a specific config value or state value matches an expected value (`config_value`, `state_value`).
- Count content entities of a type (with optional filters) via the content aggregator sensor.
- Detect when previously-present sensors "disappear" (module removed) with the disappeared-sensors sensor.
- Flag a dirty git working tree on a deployed site.
- Monitor Search API unindexed items and Solr disk usage.
- Run all sensors from CLI with `drush monitoring:run` and feed the output to Nagios/Icinga/Sensu.
- Export all sensor results to Prometheus at `/metrics` (monitoring_prometheus submodule).
- Send escalation email when a sensor transitions to a bad status (monitoring_mail submodule).
- Aggregate several sensors into one multigraph for Munin-style graphing (monitoring_multigraph submodule).
- Enable/disable individual sensors with `drush monitoring:enable|disable <sensor>` or in config.
- Tune warning/critical thresholds per sensor from the sensor edit form or config.
- Force a fresh (uncached) sensor run from the UI or API for immediate results.
- Write a custom `SensorPlugin` to monitor any app-specific metric and thresholds.
- Consume sensor config and results over REST for an external monitoring system.
- Run sensors automatically on cron by enabling the `cron_run_sensors` setting.
- Log every sensor call (or only on request) via the `sensor_call_logging` setting.
- Categorise sensors (Cron, Content, Watchdog, Security, …) for grouped reporting.
- Rebuild the sensor list after enabling/removing modules with `drush monitoring:rebuild`.
- Provide verbose diagnostic output for a sensor to debug why it is warning/critical.
- Integrate with Munin/Icinga/Prometheus for infrastructure-wide dashboards and alerting.
