#!/usr/bin/env bash
# Execution VERIFY: PASS when transformation_settings.days_of_the_week.enabled === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("views_natural_sort.settings")->get("transformation_settings.days_of_the_week.enabled");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " days_enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
