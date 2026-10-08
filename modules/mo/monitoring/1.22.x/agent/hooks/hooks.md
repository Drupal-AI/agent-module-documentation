# Monitoring — hooks (`monitoring.api.php`)

Two hooks let other modules integrate.

## `hook_monitoring_run_sensors(array $results)`

Called after each sensor run (from `SensorRunner::runSensors()`), with all
`SensorResultInterface[]`. Use it to react to results — e.g. the `monitoring_mail` submodule sends
escalation email here.

```php
function mymodule_monitoring_run_sensors(array $results) {
  foreach ($results as $result) {
    if ($result->isCritical()) {
      // notify, record, escalate, ...
    }
  }
}
```

## `hook_monitoring_sensor_links_alter(&$links, \Drupal\monitoring\Entity\SensorConfig $sensor_config)`

Alter the action links shown for a sensor on the sensor overview page
(`\Drupal\monitoring\Controller\SensorList::content()`).

```php
function mymodule_monitoring_sensor_links_alter(&$links, $sensor_config) {
  // add/remove/modify $links for $sensor_config->id()
}
```

That is the whole hook API. To add new **sensors**, implement a `SensorPlugin` plugin instead — see
[../plugins/sensor-plugins.md](../plugins/sensor-plugins.md). Sensor auto-creation on module install is
handled internally via `hook_modules_installed` in `monitoring.module`.
