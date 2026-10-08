#!/usr/bin/env bash
# Execution VERIFY: PASS when the acquia_dam_integration_links submodule is installed/enabled.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = \Drupal::moduleHandler()->moduleExists("acquia_dam_integration_links");
  print ($on ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
