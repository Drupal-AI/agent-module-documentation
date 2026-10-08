#!/usr/bin/env bash
# Execution VERIFY: PASS when migration ssi_task exists and its idMap plugin is smart_sql.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  $e = $s->load("ssi_task");
  $plugin = $e ? ($e->get("idMap")["plugin"] ?? NULL) : NULL;
  $ok = ($plugin === "smart_sql");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "yes" : "no") . " idMap=" . var_export($plugin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
