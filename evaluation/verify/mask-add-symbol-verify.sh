#!/usr/bin/env bash
# Execution VERIFY: PASS when mask.settings translation has a symbol 'Q' whose pattern is the
# requested uppercase-letter class [A-Z]. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("mask.settings")->get("translation") ?: [];
  $p = $t["Q"]["pattern"] ?? NULL;
  $ok = ($p === "[A-Z]");
  print ($ok ? "PASS" : "FAIL") . " Q_pattern=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
