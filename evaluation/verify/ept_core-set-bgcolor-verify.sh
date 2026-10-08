#!/usr/bin/env bash
# Execution VERIFY: PASS when the EPT background color is #ff0000. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ept_core.settings")->get("ept_core_background_color");
  print ((strtolower((string) $c) === "#ff0000") ? "PASS" : "FAIL") . " bg=" . var_export($c, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
