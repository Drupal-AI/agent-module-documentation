#!/usr/bin/env bash
# Execution VERIFY: PASS when cache_control_override.settings has max_age.minimum = 300 and
# max_age.maximum = 3600 (integers, not strings). exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cache_control_override.settings");
  $min = $c->get("max_age.minimum");
  $max = $c->get("max_age.maximum");
  $ok = ((int) $min === 300 && (int) $max === 3600);
  print ($ok ? "PASS" : "FAIL") . " minimum=" . var_export($min, TRUE) . " maximum=" . var_export($max, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
