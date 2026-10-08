# Monitoring — writing a sensor (`SensorPlugin`)

Plugin type id **`monitoring.sensor`**. Manager `monitoring.sensor_manager`
(`\Drupal\monitoring\Sensor\SensorManager`), discovered from `Plugin/monitoring/SensorPlugin/` in any
module. Attribute `\Drupal\monitoring\Attribute\SensorPlugin` (legacy annotation `@SensorPlugin`).

## Attribute fields

```php
#[SensorPlugin(
  id: 'my_sensor',
  label: new TranslatableMarkup('My sensor'),
  description: new TranslatableMarkup('...'),   // optional
  addable: TRUE,                                 // may a user add instances in the UI
  provider: NULL,                                // optional module provider
  metric_type: NULL,                             // optional
  report_execution_time: FALSE,
  deriver: NULL,                                 // optional deriver class
)]
```

## Minimal plugin

```php
namespace Drupal\mymodule\Plugin\monitoring\SensorPlugin;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\monitoring\Attribute\SensorPlugin;
use Drupal\monitoring\Result\SensorResultInterface;
use Drupal\monitoring\SensorPlugin\SensorPluginBase;

#[SensorPlugin(id: 'my_sensor', label: new TranslatableMarkup('My sensor'), addable: TRUE)]
class MySensorPlugin extends SensorPluginBase {
  public function runSensor(SensorResultInterface $result) {
    $result->setValue($this->computeValue());   // number/string/bool/interval per value_type
    // Either set status explicitly ...
    // $result->setStatus(SensorResultInterface::STATUS_WARNING);
    // ... or let thresholds decide by leaving the value and configuring thresholds.
    $result->addStatusMessage('Optional extra detail');
  }
}
```

Base class `SensorPluginBase` implements the boilerplate of `SensorPluginInterface`:
`getDefaultConfiguration()`, `getConfigurableValueType()`, `isEnabled()`, `getSensorId()`,
`buildConfigurationForm()/validate/submit` (override to add settings), `calculateDependencies()`.
Useful bases/interfaces: `ValueComparisonSensorPluginBase` (compare a value to an expected one, as
`config_value`/`state_value` do), `ExtendedInfoSensorPluginInterface` + `resultVerbose()` for verbose
diagnostic output, and `DatabaseAggregatorSensorPluginBase` for query-based counts.

## Registering the sensor instance

A plugin only becomes a live sensor when a `monitoring_sensor_config` entity references its `plugin_id`
(see [../configure/sensors-and-settings.md](../configure/sensors-and-settings.md)). Ship one in your
module's `config/install/monitoring.sensor_config.<id>.yml`, create it in the UI (Add Sensor), or run
`drush monitoring:rebuild` to pick up auto-createable sensors.

## Shipped sensor plugin ids (in `monitoring` itself)

`config_value`, `state_value`, `cron_last_run_time`, `enabled_modules`, `disappeared_sensors`,
`update_status`, `core_requirements`, `requirements_recap`, `git_dirty_tree`, `queue_size`,
`content_entity_aggregator`, `database_aggregator`, `watchdog_aggregator`, `view_display_aggregator`,
`dblog_404`, `redirect_404`, `image_missing_style`, `user_failed_logins`,
`non_existing_user_failed_logins`, `user_integrity`, `user_active_session_count`,
`response_time_average`, `system_load`, `system_memory`, `disk_usage`, `database_disk_usage`,
`solr_disk_usage`, `temporary_files_usages`, `php_notices`, `twig_debug_mode`,
`apcu_shared_memory_size`, `apcu_shared_memory_expunges`, `opcache_memory_usage`, `opcache_files`,
`opcache_string_buffer`, `search_api_unindexed`, `commerce_turnover`, `payment_turnover`,
`elysia_cron`, `ultimate_cron_errors`. (The test submodule adds `test_sensor`.)
