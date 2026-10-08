#!/usr/bin/env bash
# VERIFY: PASS when the tome_sync_autoclean module is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = \Drupal::moduleHandler()->moduleExists("tome_sync_autoclean");
  print ($on ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
