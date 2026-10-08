#!/usr/bin/env bash
# Execution VERIFY: PASS when NO purger with plugin_id 'fastly' remains in purge.plugins.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("purge.plugins")->get("purgers") ?: [];
  $present = FALSE;
  foreach ($p as $e) { if (($e["plugin_id"] ?? "") === "fastly") { $present = TRUE; } }
  $ok = !$present;
  print ($ok ? "PASS" : "FAIL") . " purgers=" . json_encode(array_column($p, "plugin_id")) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
