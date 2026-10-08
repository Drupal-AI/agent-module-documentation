#!/usr/bin/env bash
# Execution VERIFY: PASS when migmag_process is enabled AND the migmag_lookup process plugin is
# available AND the migmag_process.lookup.stub service exists.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $en = \Drupal::moduleHandler()->moduleExists("migmag_process");
  $defs = \Drupal::service("plugin.manager.migrate.process")->getDefinitions();
  $plugin = isset($defs["migmag_lookup"]);
  $svc = \Drupal::hasService("migmag_process.lookup.stub");
  $ok = ($en && $plugin && $svc);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en,TRUE) . " migmag_lookup=" . var_export($plugin,TRUE) . " stub_service=" . var_export($svc,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
