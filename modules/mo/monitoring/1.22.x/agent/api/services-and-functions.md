# Monitoring — services, procedural API & results

## Services

### `monitoring.sensor_manager` — `\Drupal\monitoring\Sensor\SensorManager`

Plugin manager for sensors, plus config-entity helpers:

- `getAllSensorConfig()` / `getEnabledSensorConfig()` — `monitoring_sensor_config` entities.
- `getSensorConfigByName($sensor_name)` — one config entity.
- `getSensorConfigByCategories($enabled = TRUE)` — grouped by category.
- `enableSensor($sensor_name)` / `disableSensor($sensor_name)`.
- `rebuildSensors($display_message = TRUE)` — recreate auto-createable sensors.
- `createInstance($plugin_id, $configuration)` — instantiate a `SensorPlugin`.
- `resetCache()`.

### `monitoring.sensor_runner` — `\Drupal\monitoring\SensorRunner`

- `runSensors(array $sensors_config_all = [], $force = FALSE, $verbose = FALSE): SensorResultInterface[]`
  — runs sensors (respecting `caching_time` unless `$force`), fires `hook_monitoring_run_sensors`.
- `resetCache(array $sensor_names = [])`.

## Procedural API (`monitoring.module`)

| Function | Does |
|---|---|
| `monitoring_sensor_manager()` | returns the sensor manager service |
| `monitoring_sensor_config()` | all sensor config entities |
| `monitoring_sensor_config_by_categories($enabled = TRUE)` | config grouped by category |
| `monitoring_sensor_run($sensor_name, $force_run = FALSE, $verbose = FALSE)` | run one sensor → `SensorResultInterface` |
| `monitoring_sensor_run_multiple($sensor_names = [], $force_run = FALSE, $verbose = FALSE)` | run several/all |
| `monitoring_sensor_result_last($sensor_name)` | last stored result |
| `monitoring_sensor_result_save(SensorResultInterface $result)` | persist a result |
| `monitoring_value_types()` | value-type registry (`no_value`, `number`, `string`, `time_interval`, `bool`) |

```php
$result = monitoring_sensor_run('core_cron_last_run_age', TRUE);
print $result->getStatus();      // OK | WARNING | CRITICAL | UNKNOWN
print $result->getValue();
print $result->getMessage();
```

## `SensorResultInterface` (`\Drupal\monitoring\Result\SensorResultInterface`)

Set inside a plugin's `runSensor()`: `setValue()`, `setStatus()`, `setExpectedValue()`,
`setMessage()/addStatusMessage()`, `setExecutionTime()`, `setVerboseOutput()`.
Read: `getStatus()`, `getValue()`, `getMessage()`, `isOk()/isWarning()/isCritical()/isUnknown()`,
`toNumber()`, `toArray()`, `getSensorId()`, `getSensorConfig()`, `getPreviousResult()`.

Status constants live on the interface (`STATUS_OK`, `STATUS_WARNING`, `STATUS_CRITICAL`,
`STATUS_UNKNOWN`).
