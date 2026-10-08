#!/usr/bin/env bash
# Execution VERIFY: PASS when mapping binds node--field_variant to the pattern variant setting
# card::variant. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("ui_patterns_settings.settings")->get("mapping");
  $m = is_array($m) ? $m : [];
  $v = $m["node--field_variant"] ?? NULL;
  print (($v === "card::variant") ? "PASS" : "FAIL") . " node--field_variant=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
