#!/usr/bin/env bash
# Execution RESET: ensure the tcei_Europe/tcei_France terms do NOT exist in the 'tags'
# vocabulary, so verify FAILS until the agent imports them from CSV. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Europe","tcei_France"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tcei_Europe / tcei_France absent from tags"
