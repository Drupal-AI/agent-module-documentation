#!/usr/bin/env bash
# Execution VERIFY: PASS when migmag_rollbackable enabled AND table migmag_rollbackable_data exists
# AND the migmag_rollbackable_config destination plugin is available.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $en = \Drupal::moduleHandler()->moduleExists("migmag_rollbackable");
  $tbl = \Drupal::database()->schema()->tableExists("migmag_rollbackable_data");
  $defs = \Drupal::service("plugin.manager.migrate.destination")->getDefinitions();
  $plugin = isset($defs["migmag_rollbackable_config"]);
  $ok = ($en && $tbl && $plugin);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en,TRUE) . " data_table=" . var_export($tbl,TRUE) . " migmag_rollbackable_config=" . var_export($plugin,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
