#!/usr/bin/env bash
# Execution VERIFY: PASS when sticky.settings selector is exactly '#footer'. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $sel = \Drupal::config("sticky.settings")->get("selector");
  $ok = ($sel === "#footer");
  print ($ok ? "PASS" : "FAIL") . " selector=" . var_export($sel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
