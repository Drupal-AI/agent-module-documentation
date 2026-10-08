#!/usr/bin/env bash
# Execution VERIFY: PASS when node_export_import === 'skip'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("node_export.settings")->get("node_export_import");
  $ok = ($v === "skip");
  print ($ok ? "PASS" : "FAIL") . " node_export_import=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
