# Monitoring Test — fixtures & State control API

This submodule has no public service or route. Its "API" is a set of `State` keys that let tests
force deterministic behavior, plus config-entity fixtures installed on enable. All of it targets the
base Monitoring test suite; a human never touches it.

## Drive the `test_sensor` result via State

`TestSensorPlugin::__construct()` reads `State` key `monitoring_test.sensor_result_data` (default all
`NULL`) and `runSensor()` applies it. Set it before running any `test_sensor`-based sensor to force an
outcome:

```php
\Drupal::state()->set('monitoring_test.sensor_result_data', [
  'sensor_status'            => 'CRITICAL', // OK|INFO|WARNING|CRITICAL|UNKNOWN; empty = leave to thresholds
  'sensor_message'           => 'forced',   // appended via addStatusMessage(); empty = none
  'sensor_value'             => 42,         // setValue(); NULL = no value
  'sensor_expected_value'    => NULL,       // present in the array; not consumed by runSensor()
  'sensor_exception_message' => NULL,       // if set (non-null), runSensor() throws \RuntimeException
]);
```

Behavior in `runSensor()` (order matters):
1. `usleep(1)` so execution time is never exactly 0.
2. If `sensor_exception_message` is set → `throw new \RuntimeException(...)` (drives error handling).
3. If `sensor_value` is set → `$result->setValue()`; thresholds on the sensor config then decide the
   status unless overridden below.
4. If `sensor_status` non-empty → `$result->setStatus()` (overrides threshold evaluation).
5. If `sensor_message` non-empty → `$result->addStatusMessage()`.

The plugin implements `ExtendedInfoSensorPluginInterface::resultVerbose()`, returning a single
`#type => item` render element (`'call debug'`) — used to test verbose output rendering.

## Toggle this module's hook_requirements via State

`monitoring_test.install` conditionally defines `monitoring_test_requirements()`, which returns
whatever is in State key `monitoring_test.requirements` (default `[]`). `monitoring_test.module`'s
`hook_module_implements_alter()` unsets this module's `requirements` implementation when State key
`monitoring_test_requirements_enabled` is `FALSE` (default `TRUE`). Together they let a test inject
requirement rows and turn the hook on/off:

```php
\Drupal::state()->set('monitoring_test.requirements', [
  'my_req' => ['title' => 'X', 'severity' => REQUIREMENT_ERROR, 'value' => '...'],
]);
\Drupal::state()->set('monitoring_test_requirements_enabled', FALSE); // hide the hook again
```

## Queue worker

`Drupal\monitoring_test\Plugin\QueueWorker\TestWorker` — `#[QueueWorker(id: 'monitoring_test', cron:
['time' => 60])]`. `processItem()` is intentionally empty. Items pushed onto the `monitoring_test`
queue accumulate so the base module's queue-size sensor can be exercised against a known depth.

## Result class

`Drupal\monitoring_test\Result\TestSensorResult extends
Drupal\monitoring\Result\SensorResult` with no changes — a fixture for tests that swap the sensor
result class.

## Config schema

`config/schema/monitoring_test.schema.yml` defines `monitoring.settings.test_sensor`
(`type: monitoring.settings_base`, empty `mapping`) so the `test_sensor` plugin's per-sensor settings
validate.

## Shipped sensor-config fixtures

Installed as `monitoring.sensor_config.<id>` entities. All use `value_type: number`. Those with
`plugin_id: test_sensor` are controllable via the State key above; two use base-module aggregator
plugins to exercise those sensors. See the parent
[configure/sensors-and-settings.md](../../../../1.22.x/agent/configure/sensors-and-settings.md) for
what each field/threshold type means.

| Sensor id | plugin_id | category | thresholds | Purpose |
|---|---|---|---|---|
| `test_sensor` | test_sensor | Test | none | Baseline controllable sensor (`caching_time: 3600`, `result_logging: TRUE`). |
| `test_sensor_exceeds` | test_sensor | Test | `exceeds` warning 5 / critical 10 | Exercise the "exceeds" threshold type. |
| `test_sensor_falls` | test_sensor | Test | `falls` warning 10 / critical 5 | Exercise the "falls" threshold type. |
| `test_sensor_inner` | test_sensor | Test | `inner_interval` (warn 1–9, crit 4–6) | Exercise the inner-interval threshold type. |
| `test_sensor_outer` | test_sensor | Test | `outer_interval` (warn 70–80, crit 60–90) | Exercise the outer-interval threshold type. |
| `test_sensor_cat_watchdog` | test_sensor | Watchdog | none | Test category grouping / watchdog logging. |
| `test_sensor_config` | test_sensor | (none) | none | Test sensor-config hook precedence (`value_label: 'Test label'`). |
| `test_sensor_integration` | test_sensor | Test | none | Test integration-hook precedence (`result_logging: FALSE`). |
| `watchdog_aggregate_test` | database_aggregator | Test | `exceeds` warning 1 / critical 2 | Aggregate over the `watchdog` table (`time_interval_field: timestamp`, `86400`s, verbose `wid/message/variables`). |
| `entity_aggregate_test` *(config/optional)* | entity_aggregator | Test | `falls` warning 2 / critical 1 | Aggregate `node`/`page` entities created in last day (`value_label: Druplicons`); only installed if `entity_aggregator` is available. |
