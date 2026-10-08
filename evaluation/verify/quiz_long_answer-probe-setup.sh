#!/usr/bin/env bash
# Introspection SETUP: create a long_answer quiz question titled quiz_la_probe with a known
# grading rubric, so the agent must inspect the live question to report the rubric. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"long_answer","title"=>"quiz_la_probe"])) {
    QuizQuestion::create(["type"=>"long_answer","title"=>"quiz_la_probe","long_answer_rubric"=>"Grade on completeness and accuracy"])->save();
  }
' >/dev/null 2>&1
echo "setup: long_answer question quiz_la_probe rubric = Grade on completeness and accuracy"
