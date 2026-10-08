#!/usr/bin/env bash
# Execution VERIFY (add override): PASS when 'config' destination class is RollbackableConfig.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cls = \Drupal::service("plugin.manager.migrate.destination")->getDefinition("config", FALSE)["class"] ?? "none";
  $ok = ($cls === "Drupal\\migmag_rollbackable\\Plugin\\migrate\\destination\\RollbackableConfig");
  print ($ok ? "PASS" : "FAIL") . " config_dest_class=" . $cls . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
