#!/usr/bin/env bash
# Introspection SETUP: create a truefalse quiz question titled quiz_tf_probe whose correct
# answer is True (truefalse_correct=1), so the agent must inspect the live question to report
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"truefalse","title"=>"quiz_tf_probe"])) {
    QuizQuestion::create(["type"=>"truefalse","title"=>"quiz_tf_probe","truefalse_correct"=>1])->save();
  }
' >/dev/null 2>&1
echo "setup: truefalse question quiz_tf_probe has truefalse_correct=1 (True)"
