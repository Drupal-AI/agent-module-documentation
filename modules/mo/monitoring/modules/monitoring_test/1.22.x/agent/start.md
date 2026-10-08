# Monitoring Test — agent index

Hidden **test-fixture** submodule of the Monitoring project (`hidden: TRUE`, package `Monitoring`).
It ships a controllable `test_sensor` SensorPlugin whose result is driven entirely by `State`, a set
of ready-made `monitoring.sensor_config` fixtures (one per threshold type and category), a no-op
`monitoring_test` queue worker, a `TestSensorResult` result subclass, and State-toggled
`hook_requirements`. Everything here exists to exercise the base Monitoring module's own automated
tests — there is no end-user surface. Depends on `monitoring`. No settings page, no permissions, no
services, no Drush of its own.

- **Drive the test sensor / requirements / queue via State, plus the shipped sensor-config fixtures** →
  [api/test-fixtures.md](api/test-fixtures.md)
- **The `test_sensor` SensorPlugin (reference implementation, class + methods)** →
  [plugins/test-sensor.md](plugins/test-sensor.md)

For how sensors, `SensorConfig` entities and thresholds work in general, see the parent module docs:
[../../../../1.22.x/agent/start.md](../../../../1.22.x/agent/start.md) and
[../../../../1.22.x/agent/plugins/sensor-plugins.md](../../../../1.22.x/agent/plugins/sensor-plugins.md).

Key facts:
- Plugin: `Drupal\monitoring_test\Plugin\monitoring\SensorPlugin\TestSensorPlugin`,
  `#[SensorPlugin(id: 'test_sensor', addable: TRUE)]`; implements `ExtendedInfoSensorPluginInterface`.
- State key `monitoring_test.sensor_result_data` sets the sensor's status/value/message/exception.
- State keys `monitoring_test_requirements_enabled` (bool) and `monitoring_test.requirements` (array)
  drive `monitoring_test_requirements()` via `hook_module_implements_alter()`.
- Queue worker: `#[QueueWorker(id: 'monitoring_test')]` (`TestWorker`, `processItem()` is a no-op,
  `cron.time = 60`).
- Result class: `Drupal\monitoring_test\Result\TestSensorResult extends SensorResult`.
- Config schema: `monitoring.settings.test_sensor` (type `monitoring.settings_base`, empty mapping).
- Sensor-config fixtures (`config/install`): `test_sensor`, `test_sensor_exceeds`, `test_sensor_falls`,
  `test_sensor_inner`, `test_sensor_outer`, `test_sensor_cat_watchdog`, `test_sensor_integration`,
  `test_sensor_config`, `watchdog_aggregate_test`; plus optional `entity_aggregate_test`
  (`config/optional`).
