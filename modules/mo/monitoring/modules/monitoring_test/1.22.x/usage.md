Monitoring Test is a hidden test-fixture submodule that provides a controllable `test_sensor` plugin, several ready-made test sensor configs, a no-op test queue worker and a test result subclass, all used by the base Monitoring module's automated tests.

---

The module ships a `TestSensorPlugin` (`#[SensorPlugin(id: 'test_sensor', addable: TRUE)]`) whose status/value/message/exception are driven by `State` key `monitoring_test.sensor_result_data`, so tests can force a sensor into any outcome; it implements `ExtendedInfoSensorPluginInterface::resultVerbose()`. It installs a set of `monitoring.sensor_config` entities via `config/install` — `test_sensor`, `test_sensor_exceeds`, `test_sensor_falls`, `test_sensor_inner`, `test_sensor_outer`, `test_sensor_cat_watchdog`, `test_sensor_integration`, `test_sensor_config`, `watchdog_aggregate_test` — plus an optional `entity_aggregate_test` (`config/optional`), covering each threshold type (`exceeds`, `falls`, `inner_interval`, `outer_interval`) and category. It also provides a `TestWorker` queue worker (`#[QueueWorker(id: 'monitoring_test')]`, empty `processItem()`) to exercise the queue-size sensor, a `TestSensorResult` result class (a bare subclass of `SensorResult`), a config schema key `monitoring.settings.test_sensor`, and a `hook_module_implements_alter()` plus conditional `hook_requirements()` that toggle via State keys `monitoring_test_requirements_enabled` and `monitoring_test.requirements`. It is marked `hidden: TRUE` in the `Monitoring` package and depends on the base `monitoring` module; it has no UI, permissions, services or Drush of its own.

---

- Force a `test_sensor` into OK/WARNING/CRITICAL for automated tests via State.
- Force a sensor to throw an exception (`sensor_exception_message`) to test error handling.
- Provide a sensor with each threshold type (`exceeds`, `falls`, `inner_interval`, `outer_interval`).
- Exercise the queue-size sensor with the bundled `monitoring_test` queue worker.
- Test category grouping / watchdog logging with `test_sensor_cat_watchdog`.
- Test verbose sensor output through `resultVerbose()`.
- Provide a deterministic sensor for kernel/functional tests of the sensor runner.
- Test the watchdog aggregator with `watchdog_aggregate_test`.
- Test the entity aggregator with the optional `entity_aggregate_test`.
- Toggle the module's `hook_requirements` on/off via State to test requirements sensors.
- Inject arbitrary requirement rows via State key `monitoring_test.requirements`.
- Supply a `TestSensorResult` subclass for result-class-override tests.
- Reproduce sensor-runner behavior deterministically when debugging.
- Validate threshold evaluation logic for each comparison type.
- Serve as a reference implementation of a simple `SensorPlugin`.
- Provide fixtures for the base module's test suite.
- Test sensor enable/disable/rebuild flows against known sensors.
- Test the disappeared-sensors logic by adding/removing test sensors.
- Test sensor-config hook precedence (`test_sensor_config`, `test_sensor_integration`).
- Verify `caching_time` behavior with a controllable sensor value.
- Test config export/import of sensor entities using the shipped fixtures.
- Provide a known sensor id (`test_sensor`) for API and Drush examples.
- Confirm sensors never report exactly 0 execution time (the sensor sleeps 1µs).
