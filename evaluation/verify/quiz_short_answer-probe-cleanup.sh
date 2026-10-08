#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_sa_probe short_answer question. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"short_answer","title"=>"quiz_sa_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_sa_probe removed"
