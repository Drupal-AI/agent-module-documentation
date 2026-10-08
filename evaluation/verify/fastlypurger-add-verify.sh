#!/usr/bin/env bash
# Execution VERIFY: PASS when a purger with plugin_id 'fastly' is registered in purge.plugins.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("purge.plugins")->get("purgers") ?: [];
  $ok = FALSE;
  foreach ($p as $e) { if (($e["plugin_id"] ?? "") === "fastly") { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " purgers=" . json_encode(array_column($p, "plugin_id")) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
