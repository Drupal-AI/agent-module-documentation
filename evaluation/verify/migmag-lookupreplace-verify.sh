#!/usr/bin/env bash
# Execution VERIFY (add override): PASS when migration_lookup process plugin class is MigMagLookup.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cls = \Drupal::service("plugin.manager.migrate.process")->getDefinition("migration_lookup", FALSE)["class"] ?? "none";
  $ok = ($cls === "Drupal\\migmag_process\\Plugin\\migrate\\process\\MigMagLookup");
  print ($ok ? "PASS" : "FAIL") . " migration_lookup_class=" . $cls . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
