#!/usr/bin/env bash
# Execution RESET: ensure the three color terms do NOT exist in 'tags', so verify FAILS until the
# agent imports them from CSV. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach (["tcei_Red","tcei_Green","tcei_Blue"] as $n) { foreach ($ts->loadByProperties(["name"=>$n,"vid"=>"tags"]) as $t) { $t->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tcei_Red / tcei_Green / tcei_Blue absent from tags"
