#!/usr/bin/env bash
# Execution VERIFY: PASS when the Menu settings tab weight is 1 in vertical_tabs_config.order.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("vertical_tabs_config.order")->get("vertical_tabs_config_menu");
  $ok = ((int) $w === 1);
  print ($ok ? "PASS" : "FAIL") . " vertical_tabs_config_menu=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
