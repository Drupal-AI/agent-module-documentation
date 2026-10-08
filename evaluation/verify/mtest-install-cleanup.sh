#!/usr/bin/env bash
# Execution CLEANUP: uninstall monitoring_test + purge its orphan sensor configs (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall monitoring_test -y >/dev/null 2>&1
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  foreach (["test_sensor","test_sensor_cat_watchdog","test_sensor_config","test_sensor_exceeds","test_sensor_falls","test_sensor_inner","test_sensor_integration","test_sensor_outer","watchdog_aggregate_test","entity_aggregate_test"] as $id) {
    if ($e = SensorConfig::load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: monitoring_test uninstalled + test sensor configs purged (baseline)"
