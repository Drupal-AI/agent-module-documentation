#!/usr/bin/env bash
# Execution VERIFY (remove): PASS when migmag_menu_link_migrate is NOT enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::moduleHandler()->moduleExists("migmag_menu_link_migrate");
  $ok = (!$a);
  print ($ok ? "PASS" : "FAIL") . " menu_link_enabled=" . var_export($a,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
