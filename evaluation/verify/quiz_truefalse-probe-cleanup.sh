#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_tf_probe truefalse question. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"truefalse","title"=>"quiz_tf_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_tf_probe removed"
