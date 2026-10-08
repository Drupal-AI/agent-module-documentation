#!/usr/bin/env bash
# Execution VERIFY: PASS when the Shariff buttons field (shariff_field) is an active component
# on the Article default view display. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $ok = (bool) $vd->getComponent("shariff_field");
  print ($ok ? "PASS" : "FAIL") . " shariff_field=" . ($ok ? "shown" : "hidden") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
