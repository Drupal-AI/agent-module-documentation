#!/usr/bin/env bash
# Execution VERIFY: PASS when responsive_menus.configuration style === mean_menu. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("responsive_menus.configuration")->get("style");
  $ok = ($s === "mean_menu");
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
