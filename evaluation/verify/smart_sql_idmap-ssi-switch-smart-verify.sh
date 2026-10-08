#!/usr/bin/env bash
# Execution VERIFY: PASS when ssi_switch now uses idMap.plugin=smart_sql.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  $e = $s->load("ssi_switch");
  $plugin = $e ? ($e->get("idMap")["plugin"] ?? NULL) : NULL;
  $ok = ($plugin === "smart_sql");
  print ($ok ? "PASS" : "FAIL") . " idMap=" . var_export($plugin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
