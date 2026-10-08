# `test_sensor` SensorPlugin

This submodule does **not** define a plugin type. It provides one plugin *instance* of the base
module's `monitoring.sensor` type (discovered by manager `monitoring.sensor_manager`) — the
`test_sensor` plugin — as a reference/controllable sensor for tests. To add your own sensor, follow
the parent guide: [../../../../1.22.x/agent/plugins/sensor-plugins.md](../../../../1.22.x/agent/plugins/sensor-plugins.md).

## Class

`Drupal\monitoring_test\Plugin\monitoring\SensorPlugin\TestSensorPlugin`
extends `Drupal\monitoring\SensorPlugin\SensorPluginBase`
implements `Drupal\monitoring\SensorPlugin\ExtendedInfoSensorPluginInterface`.

Attribute:

```php
#[SensorPlugin(
  id: 'test_sensor',
  label: new TranslatableMarkup('Test SensorPlugin'),
  addable: TRUE,
)]
```

`addable: TRUE` means a `test_sensor` sensor can be created from the sensor UI. Any
`monitoring.sensor_config` entity with `plugin_id: test_sensor` uses this class (see the fixtures in
[../api/test-fixtures.md](../api/test-fixtures.md)).

## Methods

| Method | Behavior |
|---|---|
| `__construct(SensorConfig, $sensor_id, $definition)` | Calls parent, then loads State `monitoring_test.sensor_result_data` into `$this->testSensorResultData`. |
| `runSensor(SensorResultInterface $result)` | `usleep(1)`; throws `\RuntimeException` if a `sensor_exception_message` is set; otherwise applies `setValue()` / `setStatus()` / `addStatusMessage()` from the State data. |
| `resultVerbose(SensorResultInterface $result)` | Returns a render array with one `#type => item` element (title "Test", markup "call debug"). |

## Controlling it

The sensor's output is entirely determined by State key `monitoring_test.sensor_result_data`. See
[../api/test-fixtures.md](../api/test-fixtures.md) for the full key list and the order in which
`runSensor()` applies them.

> Note: this file trails a large commented-out `search example` block in the source — dead legacy
> reference code, not executed.
