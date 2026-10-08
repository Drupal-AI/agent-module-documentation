#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH config_delete_parent.settings and its dependency
# config_delete_dchild.settings are gone. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $all = \Drupal::configFactory()->listAll("config_delete_");
  $parent = in_array("config_delete_parent.settings", $all, true);
  $child = in_array("config_delete_dchild.settings", $all, true);
  $ok = !$parent && !$child;
  print ($ok ? "PASS" : "FAIL") . " parent=" . ($parent?"present":"gone") . " child=" . ($child?"present":"gone") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
