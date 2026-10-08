#!/usr/bin/env bash
# Execution VERIFY: PASS when stale_while_revalidate is truthy AND value === 3600.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("fastly.settings");
  $on = $cfg->get("stale_while_revalidate");
  $val = $cfg->get("stale_while_revalidate_value");
  $ok = (!empty($on) && (int) $val === 3600);
  print ($ok ? "PASS" : "FAIL") . " stale_while_revalidate=" . var_export($on, TRUE) . " value=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
