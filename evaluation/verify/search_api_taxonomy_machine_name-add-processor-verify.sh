#!/usr/bin/env bash
# Execution VERIFY: PASS when satmn_index has the search_api_taxonomy_machine_name
# 'taxonomy_machine_name_hierarchy' processor enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $i=\Drupal\search_api\Entity\Index::load("satmn_index");
  $has = $i ? in_array("taxonomy_machine_name_hierarchy", array_keys($i->getProcessors())) : FALSE;
  print ($has?"PASS":"FAIL")." processor=".($has?"present":"absent")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
