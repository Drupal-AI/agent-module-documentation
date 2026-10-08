#!/usr/bin/env bash
# Introspection CLEANUP: delete the tcei_Region/tcei_City terms from tags. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Region","tcei_City"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed tcei_Region, tcei_City from tags"
