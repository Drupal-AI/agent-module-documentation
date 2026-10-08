#!/usr/bin/env bash
# Execution VERIFY (remove): PASS when migmag_callback_upgrade is NOT enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::moduleHandler()->moduleExists("migmag_callback_upgrade");
  $ok = (!$a);
  print ($ok ? "PASS" : "FAIL") . " callback_upgrade_enabled=" . var_export($a,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
