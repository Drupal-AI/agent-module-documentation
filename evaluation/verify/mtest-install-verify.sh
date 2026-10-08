#!/usr/bin/env bash
# Execution VERIFY: PASS when monitoring_test is installed AND monitoring.sensor_config.test_sensor exists.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  $enabled = \Drupal::moduleHandler()->moduleExists("monitoring_test");
  $sensor = SensorConfig::load("test_sensor");
  $ok = ($enabled && $sensor);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled ? "yes" : "no") . " test_sensor=" . ($sensor ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
