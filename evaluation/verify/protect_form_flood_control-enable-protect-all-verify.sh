#!/usr/bin/env bash
# Execution VERIFY: PASS when general.protect_all === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("protect_form_flood_control.settings")->get("general.protect_all");
  print (($v === TRUE || $v === 1 || $v === "1") ? "PASS" : "FAIL") . " protect_all=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
