#!/usr/bin/env bash
# Introspection CLEANUP: delete tcei_Continent and its children from tags. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Continent","tcei_Kenya","tcei_Egypt","tcei_Ghana"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed tcei_Continent and children from tags"
