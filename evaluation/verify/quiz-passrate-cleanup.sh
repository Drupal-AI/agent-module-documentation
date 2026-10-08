#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_probe quiz entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz")->loadByProperties(["title"=>"quiz_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_probe removed"
