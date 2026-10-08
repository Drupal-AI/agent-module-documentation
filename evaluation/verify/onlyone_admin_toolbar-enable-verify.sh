#!/usr/bin/env bash
# Execution VERIFY: PASS when onlyone_admin_toolbar is installed. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = \Drupal::moduleHandler()->moduleExists("onlyone_admin_toolbar");
  print ($ok ? "PASS" : "FAIL") . " onlyone_admin_toolbar=" . ($ok ? "installed" : "not-installed") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
