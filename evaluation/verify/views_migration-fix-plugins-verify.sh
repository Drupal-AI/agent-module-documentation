#!/usr/bin/env bash
# Execution VERIFY for "make vm_fix use the views_migration D7 source and view destination".
# PASS when migration vm_fix source plugin == d7_views_migration and destination plugin ==
# entity:view. Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  $m = Migration::load("vm_fix");
  $src = $m ? ($m->get("source")["plugin"] ?? "") : "";
  $dst = $m ? ($m->get("destination")["plugin"] ?? "") : "";
  $ok = ($m && $src === "d7_views_migration" && $dst === "entity:view");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " dest=" . $dst . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
