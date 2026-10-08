#!/usr/bin/env bash
# Introspection CLEANUP: delete the quiz_mc_probe multichoice question (its alternative
# paragraphs are composite and are removed with it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"multichoice","title"=>"quiz_mc_probe"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "cleanup: quiz_mc_probe removed"
