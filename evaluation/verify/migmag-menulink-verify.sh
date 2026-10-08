#!/usr/bin/env bash
# Execution VERIFY (add): PASS when migmag_menu_link_migrate is enabled AND its dependency
# migmag_process is enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mh = \Drupal::moduleHandler();
  $a = $mh->moduleExists("migmag_menu_link_migrate");
  $b = $mh->moduleExists("migmag_process");
  $ok = ($a && $b);
  print ($ok ? "PASS" : "FAIL") . " menu_link=" . var_export($a,TRUE) . " migmag_process=" . var_export($b,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
