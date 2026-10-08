#!/usr/bin/env bash
# Introspection SETUP: create a short_answer quiz question titled quiz_sa_probe whose expected
# answer is "Paris" (case-insensitive auto grading), so the agent must inspect the live
# question to report the correct answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"short_answer","title"=>"quiz_sa_probe"])) {
    QuizQuestion::create(["type"=>"short_answer","title"=>"quiz_sa_probe","short_answer_correct"=>"Paris","short_answer_evaluation"=>1])->save();
  }
' >/dev/null 2>&1
echo "setup: short_answer question quiz_sa_probe expects answer Paris (eval=1 case-insensitive)"
