#!/usr/bin/env bash
# Execution VERIFY: PASS when sensor 'mon_task' exists, uses plugin_id config_value, and is enabled.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  $s = SensorConfig::load("mon_task");
  $plugin = $s ? $s->get("plugin_id") : NULL;
  $status = $s ? (bool) $s->get("status") : FALSE;
  $ok = ($s && $plugin === "config_value" && $status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($s ? "yes" : "no") . " plugin=" . var_export($plugin, TRUE) . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
