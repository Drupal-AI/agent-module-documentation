#!/usr/bin/env bash
# Introspection SETUP: create a matching quiz question titled quiz_mt_probe with exactly 2
# question/answer pairs (France->Paris, Italy->Rome), so the agent must inspect the live
# question to report how many pairs it has. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"matching","title"=>"quiz_mt_probe"])) {
    $pairs = [];
    foreach ([["France","Paris"],["Italy","Rome"]] as $p) {
      $par = Paragraph::create(["type"=>"quiz_matching","matching_question"=>$p[0],"matching_answer"=>$p[1]]);
      $par->save();
      $pairs[] = $par;
    }
    QuizQuestion::create(["type"=>"matching","title"=>"quiz_mt_probe","quiz_matching"=>$pairs,"choice_penalty"=>0])->save();
  }
' >/dev/null 2>&1
echo "setup: matching question quiz_mt_probe has 2 pairs"
