#!/usr/bin/env bash
# Execution VERIFY (remove override): PASS when 'config' destination uses core Config again.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cls = \Drupal::service("plugin.manager.migrate.destination")->getDefinition("config", FALSE)["class"] ?? "none";
  $ok = ($cls === "Drupal\\migrate\\Plugin\\migrate\\destination\\Config");
  print ($ok ? "PASS" : "FAIL") . " config_dest_class=" . $cls . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
