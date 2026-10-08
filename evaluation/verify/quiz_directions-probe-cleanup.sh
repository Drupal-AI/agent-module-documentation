#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_dir_probe directions question. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"directions","title"=>"quiz_dir_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_dir_probe removed"
