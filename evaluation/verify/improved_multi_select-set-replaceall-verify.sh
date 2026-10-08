#!/usr/bin/env bash
# Execution VERIFY: PASS when isall===TRUE and placeholder_text==='Filter options'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("improved_multi_select.settings");
  $ok = ($c->get("isall") === TRUE) && ($c->get("placeholder_text") === "Filter options");
  print ($ok ? "PASS" : "FAIL") . " isall=" . var_export($c->get("isall"), TRUE) . " placeholder=" . var_export($c->get("placeholder_text"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
