#!/usr/bin/env bash
# Execution VERIFY: PASS when the core_cron_last_run_age sensor is enabled (status: true).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  $s = SensorConfig::load("core_cron_last_run_age");
  $status = $s ? (bool) $s->get("status") : FALSE;
  print ($status === TRUE ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
