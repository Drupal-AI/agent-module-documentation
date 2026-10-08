#!/usr/bin/env bash
# Introspection SETUP: create a 'page' quiz question titled quiz_pg_probe with a known body
# ("Section A intro"), so the agent must inspect the live question to report it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"page","title"=>"quiz_pg_probe"])) {
    QuizQuestion::create(["type"=>"page","title"=>"quiz_pg_probe","body"=>"Section A intro"])->save();
  }
' >/dev/null 2>&1
echo "setup: page question quiz_pg_probe has body 'Section A intro'"
