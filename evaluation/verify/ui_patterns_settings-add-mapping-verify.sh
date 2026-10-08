#!/usr/bin/env bash
# Execution VERIFY: PASS when ui_patterns_settings.settings mapping binds node--field_promo to
# card::title. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("ui_patterns_settings.settings")->get("mapping");
  $m = is_array($m) ? $m : [];
  $v = $m["node--field_promo"] ?? NULL;
  print (($v === "card::title") ? "PASS" : "FAIL") . " node--field_promo=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
