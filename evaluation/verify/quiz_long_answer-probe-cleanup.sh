#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_la_probe long_answer question. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"long_answer","title"=>"quiz_la_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_la_probe removed"
