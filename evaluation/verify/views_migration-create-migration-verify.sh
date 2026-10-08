#!/usr/bin/env bash
# Execution VERIFY for "create a views migration vm_task in the views_migration group".
# PASS when migration vm_task exists with migration_group=views_migration, source plugin
# d7_views_migration and destination plugin entity:view. Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  $m = Migration::load("vm_task");
  $grp = $m ? $m->get("migration_group") : "";
  $src = $m ? ($m->get("source")["plugin"] ?? "") : "";
  $dst = $m ? ($m->get("destination")["plugin"] ?? "") : "";
  $ok = ($m && $grp === "views_migration" && $src === "d7_views_migration" && $dst === "entity:view");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($m ? "yes" : "no") . " group=" . $grp . " source=" . $src . " dest=" . $dst . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
