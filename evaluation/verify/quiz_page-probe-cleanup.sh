#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_pg_probe page question. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"page","title"=>"quiz_pg_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_pg_probe removed"
