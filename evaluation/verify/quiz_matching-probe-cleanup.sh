#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_mt_probe matching question (its pair paragraphs are
# composite and are removed with it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"matching","title"=>"quiz_mt_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_mt_probe removed"
