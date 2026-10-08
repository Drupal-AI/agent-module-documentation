#!/usr/bin/env bash
# Introspection SETUP: ensure a clean slate (delete any orphan test sensor configs left by a prior
# uninstall), then install monitoring_test so its shipped test sensor configs exist to inspect.
# Baseline uninstalled; cleanup uninstalls + purges. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  foreach (["test_sensor","test_sensor_cat_watchdog","test_sensor_config","test_sensor_exceeds","test_sensor_falls","test_sensor_inner","test_sensor_integration","test_sensor_outer","watchdog_aggregate_test","entity_aggregate_test"] as $id) {
    if ($e = SensorConfig::load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush pm:install monitoring_test -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: monitoring_test installed"
