#!/usr/bin/env bash
# Execution VERIFY: PASS when pages_restriction.settings keep_parameters is truthy (enabled).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pages_restriction.settings")->get("keep_parameters");
  $ok = (bool) $v;
  print ($ok ? "PASS" : "FAIL") . " keep_parameters=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
