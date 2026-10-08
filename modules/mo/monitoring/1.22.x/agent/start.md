# Monitoring — agent index

Pluggable **sensor** framework: each sensor measures a metric/process and reports
OK/WARNING/CRITICAL/UNKNOWN against thresholds, exposed via UI, Drush and REST. Depends on `views`.
Configure route: `monitoring.settings`.

- **Sensor config entity, global settings, thresholds, enable/disable/tune a sensor** →
  [configure/sensors-and-settings.md](configure/sensors-and-settings.md)
- **Write a custom sensor (`SensorPlugin`) + shipped plugin ids** →
  [plugins/sensor-plugins.md](plugins/sensor-plugins.md)
- **Drush commands (`run`, `list-sensors`, `enable`, `disable`, `rebuild`, `sensor-config`)** →
  [drush/commands.md](drush/commands.md)
- **Services + procedural API + `SensorResultInterface`** → [api/services-and-functions.md](api/services-and-functions.md)
- **Hooks other modules implement** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Sensors = `SensorPlugin` plugin (plugin type `monitoring.sensor`, manager `monitoring.sensor_manager`)
  + a `monitoring.sensor_config.<id>` config entity (`plugin_id`, `category`, `value_type`, `status`,
  `caching_time`, `settings`, `thresholds`).
- Results page: `/admin/reports/monitoring`; sensor admin: `/admin/config/system/monitoring/sensors`;
  global settings: `/admin/config/system/monitoring/settings`.
- Submodules (own docs under `modules/<sub>/1.22.x/`): `monitoring_demo`, `monitoring_mail`,
  `monitoring_multigraph`, `monitoring_prometheus`, `monitoring_test`.
