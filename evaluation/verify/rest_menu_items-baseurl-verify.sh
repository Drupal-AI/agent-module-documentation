#!/usr/bin/env bash
# Execution VERIFY (rest_menu_items): PASS when rest_menu_items.config base_url equals
# https://headless.example.test. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("rest_menu_items.config")->get("base_url");
  $ok = ($v === "https://headless.example.test");
  print ($ok ? "PASS" : "FAIL") . " base_url=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
