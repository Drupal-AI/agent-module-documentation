#!/usr/bin/env bash
# Introspection SETUP: create a 'directions' quiz question titled quiz_dir_probe with known
# body text, so the agent must inspect the live question to report the directions. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"directions","title"=>"quiz_dir_probe"])) {
    QuizQuestion::create(["type"=>"directions","title"=>"quiz_dir_probe","body"=>"Read each question carefully"])->save();
  }
' >/dev/null 2>&1
echo "setup: directions question quiz_dir_probe body = 'Read each question carefully'"
